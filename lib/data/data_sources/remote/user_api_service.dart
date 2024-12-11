import 'package:http/http.dart' as http;
import 'package:login_api_with_num/domain/entities/response_csrf_token.dart';
import 'package:login_api_with_num/utils/network_constant.dart';
import 'dart:convert';

import '../../../domain/entities/response_of_otp_verify.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecase/share_preference.dart';
import '../../../utils/string_constant.dart';

// request that send to client

class AuthRemoteDataSource {
  final http.Client client = http.Client(); // Direct instantiation

  // first to send the number

  Future<AuthResponse> sendOtp(String phoneNumber) async {

    final url = Uri.parse('${BaseUrl.BaseUrlForUserLoginApi}${EndPoints.sendOtpEndPoint}');
    final headers = Header.getHeaderToSendOtp;

    final body1 = json.encode({JsonConstant.phone:phoneNumber});

    final response = await client.post(url, headers: headers, body: body1);

    if (response.statusCode == 200) {
      return AuthResponse(success: true, message: AppString.otpVerifiedSuccessfully);
    } else {
      return AuthResponse(success: false, message: AppString.otpVerificationFailed);
    }
  }

   // it returning the response api have csrf token
  Future<CsrfTokenResponse> generationCSRFfToken() async {
    final url = Uri.parse('${BaseUrl.BaseUrlForUserLoginApi}${EndPoints.toGetCsrfToken}');
    final headers = Header.getHeaderToGetCsrfToken;

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(CsrfTokenResponse.fromJson(jsonResponse));// Parse the JSON
      return CsrfTokenResponse.fromJson(jsonResponse);
    } else {
      return CsrfTokenResponse(
        success: false,
        message: AppString.otpVerificationFailed,
        status: null,
        data: null,
      );
    }
  }

  Future<ApiResponseFromOtpVerify > verifyOtp(String phoneNumber, String otp ,String token) async {
    final url = Uri.parse('${BaseUrl.BaseUrlForUserLoginApi}${EndPoints.verifyOtpEndPoint}');
    final headers = Header.getHeadersForVerifyApi(token);
    final body = json.encode({ JsonConstant.phone: phoneNumber, JsonConstant.otp: otp});

    final response = await client.post(url, headers: headers, body: body);


    if (response.statusCode == 200) {

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Map JSON to ApiResponseFromOtpVerify model
      ApiResponseFromOtpVerify apiResponse =
      ApiResponseFromOtpVerify.fromJson(jsonResponse);

      // Access nested data
      Data? data = apiResponse.data;
      if (apiResponse.data != null) {
        await SharedPreferencesService.saveString(AppString.jwtToken, data!.jwtToken);
        print(apiResponse.data!.jwtToken); // Use null-aware operator `!`
        
      }
      print("value in service cls $data");

      return ApiResponseFromOtpVerify (success: true, message: AppString.otpVerifiedSuccessfully);
    } else {
      return ApiResponseFromOtpVerify (data: null,success: false, message: AppString.otpVerificationFailed);
    }
  }



}
