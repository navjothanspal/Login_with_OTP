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
  Future<AuthResponse> verifyOtp(String phoneNumber, String otp) {
    return remoteDataSource.verifyOtp(phoneNumber, otp);
  }
}
