import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var multicastManager: MulticastManager?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "xyz.getin.scanner/channel",
            binaryMessenger: controller.binaryMessenger)
        
        multicastManager = MulticastManager()
        
        channel.setMethodCallHandler { [weak self] call, result in
            guard let self = self else { return }
            
            switch call.method {
            case "getFlavor":
                let flavor = Bundle.main.infoDictionary?["App - Flavor"]
                result(flavor)
        
            case "initialize":
                self.multicastManager?.initialize(channel: channel, result: result)
                
            case "sendMessage":
                if let message = call.arguments as? String {
                    self.multicastManager?.sendMessage(message, result: result)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT",
                                        message: "Expected string message",
                                        details: nil))
                }
                
            case "cleanup":
                self.multicastManager?.cleanup()
                result(nil)
                
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
