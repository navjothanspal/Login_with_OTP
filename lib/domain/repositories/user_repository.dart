import 'package:login_api_with_num/domain/entities/response_csrf_token.dart';

import '../entities/response_of_otp_verify.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthResponse> sendOtp(String phoneNumber);
  Future<ApiResponseFromOtpVerify > verifyOtp(String phoneNumber, String otp, String token);
  Future<CsrfTokenResponse> getCsrfToken();
}