import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/user_entity.dart';

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

    final body = json.encode({"phone":"7428873899"});
    final response = await client.post(url, headers: headers, body: body1);

    if (response.statusCode == 200) {
      return AuthResponse(success: true, message: 'OTP sent successfully');
    } else {
      return AuthResponse(success: false, message: 'Failed to send OTP');
    }
  }

   // second is to verify the otp

  Future<AuthResponse> verifyOtp(String phoneNumber, String otp) async {
    final url = Uri.parse('https://your-api.com/verify-otp');
    final headers = {
      'cp-origin': '',
      'x-auth-token': '',
      'x-jwt-token': '',
      'Content-Type': 'application/json',
    };
    final body = json.encode({'phone_number': phoneNumber, 'otp': otp});

    final response = await client.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return AuthResponse(success: true, message: 'OTP verified successfully');
    } else {
      return AuthResponse(success: false, message: 'Failed to verify OTP');
    }
  }
}
