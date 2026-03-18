class TerminalOnboardingLinkStructResp {
  String? code;
  TerminalOnboardingLinkStruct? data;
  int? logId;

  TerminalOnboardingLinkStructResp({this.code, this.data, this.logId});

  TerminalOnboardingLinkStructResp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null
        ? new TerminalOnboardingLinkStruct.fromJson(json['data'])
        : null;
    logId = json['log_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['log_id'] = this.logId;
    return data;
  }

  static maybeFromMap(dynamic jsonBody) {
    if (jsonBody is Map<String, dynamic>) {
      return TerminalOnboardingLinkStructResp.fromJson(jsonBody);
    }
    return null;
  }
}

class TerminalOnboardingLinkStruct {
  String? object;
  LinkOptions? linkOptions;
  String? linkType;
  String? redirectUrl;

  TerminalOnboardingLinkStruct(
      {this.object, this.linkOptions, this.linkType, this.redirectUrl});

  static TerminalOnboardingLinkStruct? maybeFromMap(dynamic data) => data is Map
      ? TerminalOnboardingLinkStruct.fromJson(data.cast<String, dynamic>())
      : null;

  TerminalOnboardingLinkStruct.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    linkOptions = json['link_options'] != null
        ? new LinkOptions.fromJson(json['link_options'])
        : null;
    linkType = json['link_type'];
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object'] = this.object;
    if (this.linkOptions != null) {
      data['link_options'] = this.linkOptions!.toJson();
    }
    data['link_type'] = this.linkType;
    data['redirect_url'] = this.redirectUrl;
    return data;
  }
}

class LinkOptions {
  AppleTermsAndConditions? appleTermsAndConditions;

  LinkOptions({this.appleTermsAndConditions});

  LinkOptions.fromJson(Map<String, dynamic> json) {
    appleTermsAndConditions = json['apple_terms_and_conditions'] != null
        ? new AppleTermsAndConditions.fromJson(
            json['apple_terms_and_conditions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appleTermsAndConditions != null) {
      data['apple_terms_and_conditions'] =
          this.appleTermsAndConditions!.toJson();
    }
    return data;
  }
}

class AppleTermsAndConditions {
  bool? allowRelinking;
  String? merchantDisplayName;

  AppleTermsAndConditions({this.allowRelinking, this.merchantDisplayName});

  AppleTermsAndConditions.fromJson(Map<String, dynamic> json) {
    allowRelinking = json['allow_relinking'];
    merchantDisplayName = json['merchant_display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow_relinking'] = this.allowRelinking;
    data['merchant_display_name'] = this.merchantDisplayName;
    return data;
  }
}
