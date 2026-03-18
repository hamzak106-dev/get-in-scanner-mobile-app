import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';
import 'interceptors.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start GetInAuth Group Code

class GetInAuthGroup {
  static String getBaseUrl({
    String? apiBaseURL = '',
    String? scannerApiKey = '',
    String? apiVersion = '',
  }) =>
      '${apiBaseURL}';
  static Map<String, String> headers = {
    'scanner-api-key': '[scannerApiKey]',
  };
  static CheckVFiveCall checkVFiveCall = CheckVFiveCall();
  static LoginVFiveCall loginVFiveCall = LoginVFiveCall();

  static final interceptors = [
    ExampleInterceptor(),
  ];
}

class CheckVFiveCall {
  Future<ApiCallResponse> call({
    String? phoneEmail = '',
    String? phoneCountryCode = '',
    String? firebaseAuthToken = '',
    String? apiBaseURL = '',
    String? scannerApiKey = '',
    String? apiVersion = '',
  }) async {
    final baseUrl = GetInAuthGroup.getBaseUrl(
      apiBaseURL: apiBaseURL,
      scannerApiKey: scannerApiKey,
      apiVersion: apiVersion,
    );

    final ffApiRequestBody = '''
{
  "phone_email": "${phoneEmail}",
  "phone_country_code": "${phoneCountryCode}",
  "firebase_auth_token": "${firebaseAuthToken}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'CheckVFive',
        apiUrl: '${baseUrl}/api/user-auth/check/${apiVersion}',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {
          'scanner-api-key': '${scannerApiKey}',
        },
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      GetInAuthGroup.interceptors,
    );
  }
}

class LoginVFiveCall {
  Future<ApiCallResponse> call({
    String? phoneEmail = '',
    String? otpCode = '',
    String? csrfToken = '',
    String? phoneCountryCode = '',
    String? apiBaseURL = '',
    String? scannerApiKey = '',
    String? apiVersion = '',
  }) async {
    final baseUrl = GetInAuthGroup.getBaseUrl(
      apiBaseURL: apiBaseURL,
      scannerApiKey: scannerApiKey,
      apiVersion: apiVersion,
    );

    final ffApiRequestBody = '''
{
  "phone_email": "${phoneEmail}",
  "otp_code": "${otpCode}",
  "phone_country_code": "${phoneCountryCode}",
  "csrf_token": "${csrfToken}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'LoginVFive',
        apiUrl: '${baseUrl}/api/user-auth/login/${apiVersion}',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {
          'scanner-api-key': '${scannerApiKey}',
        },
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      GetInAuthGroup.interceptors,
    );
  }
}

/// End GetInAuth Group Code

/// Start GetIn Scanner APIs Group Code

class GetInScannerAPIsGroup {
  static String getBaseUrl({
    String? apiBaseURL = '',
  }) =>
      '${apiBaseURL}';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  static SyncWithGetINCall syncWithGetINCall = SyncWithGetINCall();
  static UploadCSVCall uploadCSVCall = UploadCSVCall();
  static CreateStripeTapToPayPaymentCall createStripeTapToPayPaymentCall =
      CreateStripeTapToPayPaymentCall();
  static CreateEventQuickPayCall createEventQuickPayCall =
      CreateEventQuickPayCall();
  static CheckEventQuickPayCall checkEventQuickPayCall =
      CheckEventQuickPayCall();
  static GetQuickPayTerminalTokenCall getQuickPayTerminalTokenCall =
      GetQuickPayTerminalTokenCall();
  static TerminalOnboardingCall terminalOnboardingCall = TerminalOnboardingCall();

  static final interceptors = [
    ExampleInterceptor(),
  ];
}

class SyncWithGetINCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? phone = '',
    String? accessCode = '',
    int? userId,
    String? refreshToken = '',
    String? accessToken = '',
    String? phoneCountryCode = '',
    String? profileImg = '',
    String? token = '',
    String? apiBaseURL = '',
  }) async {
    final baseUrl = GetInScannerAPIsGroup.getBaseUrl(
      apiBaseURL: apiBaseURL,
    );

    final ffApiRequestBody = '''
{
  "access_code": "${accessCode}",
  "user_id": ${userId},
  "refresh_token": "${refreshToken}",
  "access_token": "${accessToken}",
  "name": "${name}",
  "email": "${email}",
  "phone": "${phone}",
  "phone_country_code": "${phoneCountryCode}",
  "profile_img": "${profileImg}",
  "token": "${token}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'SyncWithGetIN',
        apiUrl: '${baseUrl}/attendees',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {
          'Content-Type': 'application/json',
        },
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      GetInScannerAPIsGroup.interceptors,
    );
  }
}

class UploadCSVCall {
  Future<ApiCallResponse> call({
    int? eventId,
    FFUploadedFile? file,
    String? token = '',
    String? apiBaseURL = '',
  }) async {
    final baseUrl = GetInScannerAPIsGroup.getBaseUrl(
      apiBaseURL: apiBaseURL,
    );

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'Upload CSV',
        apiUrl: '${baseUrl}/uploadCSV',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {
          'Content-Type': 'application/json',
        },
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {
          'file': file,
          'eventId': eventId,
          'token': token,
        },

        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      GetInScannerAPIsGroup.interceptors,
    );
  }
}

class CreateStripeTapToPayPaymentCall {
  Future<ApiCallResponse> call({
    String? apiBaseURL = '',
    String? amount = '',
    String? eventId = '',
  }) async {
    final baseUrl = GetInScannerAPIsGroup.getBaseUrl(
      apiBaseURL: apiBaseURL,
    );

    final ffApiRequestBody = '''
{
  "amount": "${amount}",
  "event_id": "${eventId}",
}''';

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'CreateStripeTapToPayPayment',
        apiUrl: '${baseUrl}/api/stripe-tap-to-pay/payment/create',
        callType: ApiCallType.POST,
        headers: {
          'Content-Type': 'application/json',
        },
        params: {},
        body: jsonEncode({
          "amount": "${amount}",
          "event_id": "${eventId}",
        }),
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      GetInScannerAPIsGroup.interceptors,
    );
  }
}

class CreateEventQuickPayCall {
  Future<ApiCallResponse> call({
    String? apiBaseURL = '',
    String? amount = '',
    String? eventId = '',
    String? scannerApiKey = '',
    String? deviceName = '',
    String? deviceId = '',
    String? appVersion = '',
    String? platform = '',
  }) async {
    final baseUrl = GetInScannerAPIsGroup.getBaseUrl(
      apiBaseURL: apiBaseURL,
    );

    final ffApiRequestBody = '''
{
  "amount": "${amount}",
  "event_id": "${eventId}",
}''';

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'CreateStripeTapToPayPayment',
        apiUrl: '${baseUrl}/api/scanner-app/purchase/${eventId}/quick-pay',
        callType: ApiCallType.POST,
        headers: {
          'Content-Type': 'application/json',
          'scanner-api-key': '${scannerApiKey}',
          'X-Device-Id': '${deviceId}',
          'X-Device-Model': '${deviceName}',
          'X-Device-OS': '${platform}',
          'X-App-Version': '${appVersion}',
        },
        params: {},
        body: jsonEncode({
          "amount": "${amount}",
        }),
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      GetInScannerAPIsGroup.interceptors,
    );
  }
}

class CheckEventQuickPayCall {
  Future<ApiCallResponse> call({
    String? apiBaseURL = '',
    String? scannerApiKey = '',
    String? eventId = '',
    String? hash = '',
    String? email = '',
    String? phone = '',
  }) async {
    final baseUrl = GetInScannerAPIsGroup.getBaseUrl(
      apiBaseURL: apiBaseURL,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'CheckStripeTapToPayPayment',
        apiUrl:
            '${baseUrl}/api/scanner-app/purchase/${eventId}/quick-pay/check',
        callType: ApiCallType.POST,
        headers: {
          'Content-Type': 'application/json',
          'scanner-api-key': '${scannerApiKey}',
        },
        params: {},
        body: jsonEncode({
          "hash": hash,
          if (email != null && email.isNotEmpty) "email": email,
          if (phone != null && phone.isNotEmpty) "phone": phone,
        }),
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      GetInScannerAPIsGroup.interceptors,
    );
  }
}

class GetQuickPayTerminalTokenCall {
  Future<ApiCallResponse> call({
    String? apiBaseURL = '',
    String? scannerApiKey = '',
    String? eventId = '',
  }) async {
    final baseUrl = GetInScannerAPIsGroup.getBaseUrl(
      apiBaseURL: apiBaseURL,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'GetQuickPayTerminalToken',
        apiUrl:
            '${baseUrl}/api/scanner-app/purchase/${eventId}/quick-pay/terminal-token',
        callType: ApiCallType.POST,
        headers: {
          'Content-Type': 'application/json',
          'scanner-api-key': '${scannerApiKey}',
        },
        params: {},
        body: null,
        // No body
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      GetInScannerAPIsGroup.interceptors,
    );
  }
}

class TerminalOnboardingCall {
  Future<ApiCallResponse> call({
    String? apiBaseURL = '',
    String? scannerApiKey = '',
    String? eventId = '',
    String? ScannerName = '',
  }) async {
    final baseUrl = GetInScannerAPIsGroup.getBaseUrl(
      apiBaseURL: apiBaseURL,
    );

    final body = '''{
  "scanner_name": "${ScannerName}",
}''';

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'GetQuickPayTerminalToken',
        apiUrl:
            '${baseUrl}/api/scanner-app/purchase/stripe/createOnboardingLink',
        callType: ApiCallType.POST,
        headers: {
          'Content-Type': 'application/json',
          'scanner-api-key': '${scannerApiKey}',
        },
        params: {},
        body: body,
        // No body
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      GetInScannerAPIsGroup.interceptors,
    );
  }
}

/// End GetIn Scanner APIs Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
