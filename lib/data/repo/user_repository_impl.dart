import 'package:login_api_with_num/domain/entities/response_csrf_token.dart';

import '../../domain/entities/response_of_otp_verify.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/remote/user_api_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource = AuthRemoteDataSource(); // No DI

  @override
  Future<AuthResponse> sendOtp(String phoneNumber) {
    return remoteDataSource.sendOtp(phoneNumber);
  }
  @override
  Future<ApiResponseFromOtpVerify> verifyOtp2(String phoneNumber, String otp ,String token) {
    return remoteDataSource.verifyOtp(phoneNumber, otp,token);
  }
  @override
  Future<CsrfTokenResponse>verifyOtp() {
    return remoteDataSource.generationCSRFfToken();
  }
}
