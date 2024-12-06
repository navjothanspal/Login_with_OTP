class ApiResponseFromOtpVerify {
  Data? data;
  bool success;
  String? response;
  String? message;

  ApiResponseFromOtpVerify ({ this.data, required this.success, this.response, this.message});

  factory ApiResponseFromOtpVerify.fromJson(Map<String, dynamic> json) {
    return ApiResponseFromOtpVerify(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      success: json['success'],
      response: json['response'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'success': success,
      'response': response,
      'message': message,
    };
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? refId;
  String? socialRefId;
  String? phoneNumber;
  bool? existingUser;
  String? loginToken;
  String? deviceName;
  bool? alreadyLoggedIn;
  String? jwtToken;
  String? jwt256Token;

  Data({
    this.id,
    this.name,
    this.email,
    this.refId,
    this.socialRefId,
    this.phoneNumber,
    this.existingUser,
    this.loginToken,
    this.deviceName,
    this.alreadyLoggedIn,
    this.jwtToken,
    this.jwt256Token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      refId: json['refId'],
      socialRefId: json['socialRefId'],
      phoneNumber: json['phoneNumber'],
      existingUser: json['existingUser'],
      loginToken: json['loginToken'],
      deviceName: json['deviceName'],
      alreadyLoggedIn: json['alreadyLoggedIn'],
      jwtToken: json['jwtToken'],
      jwt256Token: json['jwt256Token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'refId': refId,
      'socialRefId': socialRefId,
      'phoneNumber': phoneNumber,
      'existingUser': existingUser,
      'loginToken': loginToken,
      'deviceName': deviceName,
      'alreadyLoggedIn': alreadyLoggedIn,
      'jwtToken': jwtToken,
      'jwt256Token': jwt256Token,
    };
  }
}
