import 'package:http/http.dart' as http;
import 'package:login_api_with_num/domain/entities/response_csrf_token.dart';
import 'dart:convert';

import '../../../domain/entities/response_of_otp_verify.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecase/share_preference.dart';

// request that send to client

class AuthRemoteDataSource {
  final http.Client client = http.Client(); // Direct instantiation

  // first to send the number

  Future<AuthResponse> sendOtp(String phoneNumber) async {

    final url = Uri.parse('https://staginguserapi.adda247.com/new-phone-verify?src=aweb');
    final headers = {
      'cp-origin': '11',
      'x-auth-token': 'fpoa43edty5',
      'Content-Type': 'application/json'
    };

    final body1 = json.encode({'phone':phoneNumber});

   // final body = json.encode({"phone":"7428873899"});
    final response = await client.post(url, headers: headers, body: body1);

    if (response.statusCode == 200) {
      return AuthResponse(success: true, message: 'OTP sent successfully');
    } else {
      return AuthResponse(success: false, message: 'Failed to send OTP');
    }
  }

   // it returning the response api have csrf token
  Future<CsrfTokenResponse> generationCSRFfToken() async {
    final url = Uri.parse('https://staginguserapi.adda247.com/csrf/token?src=and');
    final headers = {
      'cp-origin': '11',
      'login_type':'1',
      'x-auth-token': 'fpoa43edty5',

    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(CsrfTokenResponse.fromJson(jsonResponse));// Parse the JSON
      return CsrfTokenResponse.fromJson(jsonResponse);
    } else {
      return CsrfTokenResponse(
        success: false,
        message: 'Failed to verify OTP',
        status: null,
        data: null,
      );
    }
  }

  Future<ApiResponseFromOtpVerify > verifyOtp(String phoneNumber, String otp ,String token) async {
    final url = Uri.parse('https://staginguserapi.adda247.com/v3/new-otp-verify?src=and');
    final headers = {
      'cp-origin': '11',
      'dname': 'Chrome on Mac Desktop',
      'login_type':'2',
      'x-auth-token': 'fpoa43edty5',
      'x-csrf-token' : token,
      'dID': '1e0def8712fc92f7',
      'dName': 'google sdk_gphone64_x86_64',
      'Content-Type': 'application/json',
    };
    final body = json.encode({'phone': phoneNumber, 'otp': otp});

    final response = await client.post(url, headers: headers, body: body);
    // if (response.statusCode == 200) {
    //   // Decode JSON
    //   final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    //
    //   // Map JSON to ApiResponseFromOtpVerify model
    //   ApiResponseFromOtpVerify apiResponse =
    //   ApiResponseFromOtpVerify.fromJson(jsonResponse);
    //
    //   // Access nested data
    //   Data? data = apiResponse.data;
    //   if (apiResponse.data != null) {
    //     await SharedPreferencesService.saveString("jwtToken", data!.jwtToken);
    //     print(apiResponse.data!.jwtToken); // Use null-aware operator `!`
    //
    //
    //   }
    //   print("value in service cls $data");
    // }

    if (response.statusCode == 200) {

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Map JSON to ApiResponseFromOtpVerify model
      ApiResponseFromOtpVerify apiResponse =
      ApiResponseFromOtpVerify.fromJson(jsonResponse);

      // Access nested data
      Data? data = apiResponse.data;
      if (apiResponse.data != null) {
        await SharedPreferencesService.saveString("jwtToken", data!.jwtToken);
        print(apiResponse.data!.jwtToken); // Use null-aware operator `!`
        
      }
      print("value in service cls $data");

      return ApiResponseFromOtpVerify (success: true, message: 'OTP verified successfully');
    } else {
      return ApiResponseFromOtpVerify (data: null,success: false, message: 'Failed to verify OTP');
    }
  }



}
