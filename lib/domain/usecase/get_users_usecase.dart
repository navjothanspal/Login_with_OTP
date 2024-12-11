import 'package:login_api_with_num/domain/entities/response_csrf_token.dart';

import '../entities/response_of_otp_verify.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<AuthResponse> execute(String phoneNumber) {
    return repository.sendOtp(phoneNumber);
  }
}

class GenerateCsrfToken {
  final AuthRepository repository;

  GenerateCsrfToken(this.repository);

  Future<CsrfTokenResponse> execute() {
    return repository.getCsrfToken();
  }}

class VerifyOtpUseCase{
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<ApiResponseFromOtpVerify> execute(String phoneNumber, String otp, String token) {
    return repository.verifyOtp(phoneNumber, otp, token);
  }}



