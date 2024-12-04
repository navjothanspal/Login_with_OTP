import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthResponse> sendOtp(String phoneNumber);
  Future<AuthResponse> verifyOtp(String phoneNumber, String otp);
}