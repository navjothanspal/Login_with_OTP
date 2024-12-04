import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<AuthResponse> execute(String phoneNumber) {
    return repository.sendOtp(phoneNumber);
  }
}

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<AuthResponse> execute(String phoneNumber, String otp) {
    return repository.verifyOtp(phoneNumber, otp);
  }


}

