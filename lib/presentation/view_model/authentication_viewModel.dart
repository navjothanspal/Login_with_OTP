import 'package:flutter/material.dart';
import '../../data/repo/user_repository_impl.dart';
import '../../domain/usecase/get_users_usecase.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final sendOtpUseCase = SendOtpUseCase(AuthRepositoryImpl());
  final verifyOtpUseCase = VerifyOtpUseCase(AuthRepositoryImpl());

  bool isLoading = false;
  String? message;

  // Send OTP
  Future<bool> sendOtp(String phoneNumber) async {
    isLoading = true;
    notifyListeners();


    final response = await sendOtpUseCase.execute(phoneNumber);

    message = response.message;
    isLoading = false;
    notifyListeners();

    return response.success; // Return success status
  }

  // Verify OTP
  Future<bool> verifyOtp(String phoneNumber, String otp ,token) async {
    isLoading = true;
    notifyListeners();

    final response = await verifyOtpUseCase.execute(phoneNumber, otp,token);

    message = response.message;
    isLoading = false;
    notifyListeners();

    return response.success; // Return success status
  }
}
