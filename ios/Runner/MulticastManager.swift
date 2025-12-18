import Flutter
import Foundation
import Network
import Darwin

@objc public class MulticastManager: NSObject {
    private var sendSocket: CFSocket?
    private var receiveSocket: CFSocket?
    private let multicastGroup = "239.95.88.100"
    private let port: UInt16 = 9588
    private var channel: FlutterMethodChannel?
    private var isListening = false
    
    @objc public func initialize(channel: FlutterMethodChannel, result: @escaping FlutterResult) {
        self.channel = channel
        setupSendSocket { sendSuccess in
            if sendSuccess {
                self.setupReceiveSocket { receiveSuccess in
                    DispatchQueue.main.async {
                        receiveSuccess ? result(true) : result(FlutterError(
                            code: "SETUP_FAILED", message: "Failed to setup receive socket", details: nil))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    result(FlutterError(code: "SETUP_FAILED", message: "Failed to setup send socket", details: nil))
                }
            }
        }
    }
    
    private func setupSendSocket(completion: @escaping (Bool) -> Void) {
        var context = CFSocketContext()
        context.info = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        
        sendSocket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_DGRAM, IPPROTO_UDP, 0, nil, &context)
        
        guard let sendSocket = sendSocket else {
            print("Failed to create send socket")
            completion(false)
            return
        }
        
        let sock = CFSocketGetNative(sendSocket)
        
        var yes: Int32 = 1
        setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &yes, socklen_t(MemoryLayout<Int32>.size))
        setsockopt(sock, SOL_SOCKET, SO_REUSEPORT, &yes, socklen_t(MemoryLayout<Int32>.size))
        setsockopt(sock, SOL_SOCKET, SO_BROADCAST, &yes, socklen_t(MemoryLayout<Int32>.size))
        
        // Set TTL for multicast
        var ttl: UInt8 = 255
        setsockopt(sock, IPPROTO_IP, IP_MULTICAST_TTL, &ttl, socklen_t(MemoryLayout<UInt8>.size))
        
        // Find and bind to WiFi interface
        if let wifiAddress = getWiFiAddress() {
            var addr = sockaddr_in()
            addr.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            addr.sin_family = sa_family_t(AF_INET)
            addr.sin_port = 0
            addr.sin_addr.s_addr = inet_addr(wifiAddress)
            
            let bindData = Data(bytes: &addr, count: MemoryLayout<sockaddr_in>.size)
            if CFSocketSetAddress(sendSocket, bindData as CFData) != CFSocketError.success {
                print("Failed to bind send socket to interface")
                completion(false)
                return
            }
            
            // Set outgoing interface for multicast
            var ifaddr = in_addr()
            ifaddr.s_addr = inet_addr(wifiAddress)
            setsockopt(sock, IPPROTO_IP, IP_MULTICAST_IF, &ifaddr, socklen_t(MemoryLayout<in_addr>.size))
            
            // Disable multicast loopback
            var loopback: UInt8 = 0
            setsockopt(sock, IPPROTO_IP, IP_MULTICAST_LOOP, &loopback, socklen_t(MemoryLayout<UInt8>.size))
        }
        
        print("Send socket setup complete")
        completion(true)
    }
    
    private func setupReceiveSocket(completion: @escaping (Bool) -> Void) {
        var sockAddr = sockaddr_in()
        sockAddr.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        sockAddr.sin_family = sa_family_t(AF_INET)
        sockAddr.sin_port = port.bigEndian
        sockAddr.sin_addr.s_addr = INADDR_ANY
        
        var context = CFSocketContext()
        context.info = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        
        receiveSocket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_DGRAM, IPPROTO_UDP,
                                       CFSocketCallBackType.dataCallBack.rawValue,
                                       { socket, _, _, data, info in
            if let info = info, let data = data {
                let manager = Unmanaged<MulticastManager>.fromOpaque(info).takeUnretainedValue()
                manager.handleReceivedData(data)
            }
        }, &context)
        
        guard let receiveSocket = receiveSocket else {
            print("Failed to create receive socket")
            completion(false)
            return
        }
        
        let sock = CFSocketGetNative(receiveSocket)
        
        var yes: Int32 = 1
        setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &yes, socklen_t(MemoryLayout<Int32>.size))
        setsockopt(sock, SOL_SOCKET, SO_REUSEPORT, &yes, socklen_t(MemoryLayout<Int32>.size))
        
        let sockAddrData = Data(bytes: &sockAddr, count: MemoryLayout<sockaddr_in>.size)
        if CFSocketSetAddress(receiveSocket, sockAddrData as CFData) != CFSocketError.success {
            print("Failed to bind receive socket")
            completion(false)
            return
        }
        
        // Join multicast group on WiFi interface
        if let wifiAddress = getWiFiAddress() {
            var mreq = ip_mreq()
            mreq.imr_multiaddr.s_addr = inet_addr(multicastGroup)
            mreq.imr_interface.s_addr = inet_addr(wifiAddress)
            
            if setsockopt(sock, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mreq, socklen_t(MemoryLayout<ip_mreq>.size)) < 0 {
                print("Failed to join multicast group")
                completion(false)
                return
            }
        }
        
        let runLoopSource = CFSocketCreateRunLoopSource(kCFAllocatorDefault, receiveSocket, 0)
        CFRunLoopAddSource(CFRunLoopGetMain(), runLoopSource, .commonModes)
        
        print("Receive socket setup complete")
        completion(true)
    }
    
    @objc public func sendMessage(_ message: String, result: @escaping FlutterResult) {
        guard let socket = sendSocket else {
            result(FlutterError(code: "SOCKET_ERROR", message: "Socket not initialized", details: nil))
            return
        }
        
        guard let data = message.data(using: .utf8) else {
            result(FlutterError(code: "INVALID_MESSAGE", message: "Could not encode message", details: nil))
            return
        }
        
        let socketFD = CFSocketGetNative(socket)
        
        // Prepare destination address
        var destAddr = sockaddr_in()
        destAddr.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        destAddr.sin_family = sa_family_t(AF_INET)
        destAddr.sin_port = port.bigEndian
        destAddr.sin_addr.s_addr = inet_addr(multicastGroup)
        
        // Use sendto directly for more control
        let sendResult = withUnsafePointer(to: destAddr) { pointer in
            pointer.withMemoryRebound(to: sockaddr.self, capacity: 1) { addr in
                Darwin.sendto(
                    socketFD,
                    [UInt8](data),
                    data.count,
                    0,
                    addr,
                    socklen_t(MemoryLayout<sockaddr_in>.size)
                )
            }
        }
        
        if sendResult >= 0 {
            print("Message sent successfully: \(message)")
            result(true)
        } else {
            let error = errno
            let errorString = String(cString: strerror(error))
            print("Send failed with error \(error): \(errorString)")
            result(FlutterError(code: "SEND_FAILED", message: "Failed to send message", details: errorString))
        }
    }
    
    private func handleReceivedData(_ data: UnsafeRawPointer?) {
        do {
            // Validate input data
            guard let data = data else {
                print("Error: Received nil data pointer")
                return
            }
            
            // Safely get CFData and validate
            let cfData = try {
                let data = Unmanaged<CFData>.fromOpaque(data).takeUnretainedValue()
                guard CFDataGetLength(data) > 0 else {
                    throw NSError(domain: "MessageHandler", code: 1, userInfo: [NSLocalizedDescriptionKey: "Empty CFData received"])
                }
                return data
            }()
            
            // Get byte pointer and length
            guard let bytePtr = CFDataGetBytePtr(cfData) else {
                throw NSError(domain: "MessageHandler", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to get byte pointer"])
            }
            
            let length = CFDataGetLength(cfData)
            
            // Create and validate message data
            let messageData = try {
                let data = Data(bytes: bytePtr, count: length)
                guard !data.isEmpty else {
                    throw NSError(domain: "MessageHandler", code: 3, userInfo: [NSLocalizedDescriptionKey: "Empty message data"])
                }
                return data
            }()
            
            // Convert to string and validate
            guard let messageString = String(data: messageData, encoding: .utf8), !messageString.isEmpty else {
                throw NSError(domain: "MessageHandler", code: 4, userInfo: [NSLocalizedDescriptionKey: "Failed to decode message or empty string"])
            }
            
            print("Received message: \(messageString)")
            
            // Safely dispatch to main queue
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    print("Warning: Self reference lost")
                    return
                }
                
                guard let channel = self.channel else {
                    print("Warning: Flutter channel not available")
                    return
                }
                
                channel.invokeMethod("onMessageReceived", arguments: messageString) { error in
                    if let error = error {
                        print("Error sending message to Flutter: \(error)")
                    }
                }
            }
            
        } catch {
            print("Error handling received data: \(error)")
        }
    }
    
    private func getWiFiAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        guard getifaddrs(&ifaddr) == 0 else {
            return nil
        }
        defer { freeifaddrs(ifaddr) }
        
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next }
            
            let interface = ptr!.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            
            if addrFamily == UInt8(AF_INET),
               let name = String(cString: interface.ifa_name, encoding: .utf8),
               name == "en0" {
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(interface.ifa_addr,
                            socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname,
                            socklen_t(hostname.count),
                            nil,
                            0,
                            NI_NUMERICHOST)
                address = String(cString: hostname)
                break
            }
        }
        return address
    }
    
    @objc public func cleanup() {
        if let receiveSocket = receiveSocket {
            let sock = CFSocketGetNative(receiveSocket)
            var mreq = ip_mreq()
            mreq.imr_multiaddr.s_addr = inet_addr(multicastGroup)
            mreq.imr_interface.s_addr = INADDR_ANY
            setsockopt(sock, IPPROTO_IP, IP_DROP_MEMBERSHIP, &mreq, socklen_t(MemoryLayout<ip_mreq>.size))
            CFSocketInvalidate(receiveSocket)
        }
        
        sendSocket.map { CFSocketInvalidate($0) }
        receiveSocket = nil
        sendSocket = nil
        channel = nil
    }
}
