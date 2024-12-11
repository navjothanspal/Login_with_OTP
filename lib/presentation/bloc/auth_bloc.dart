

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_with_num/domain/usecase/get_users_usecase.dart';
import 'package:login_api_with_num/presentation/bloc/auth_event.dart';
import 'package:login_api_with_num/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{

  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final GenerateCsrfToken generateCsrfTokenUseCase;


  AuthBloc({required this.sendOtpUseCase, required this.verifyOtpUseCase ,required this.generateCsrfTokenUseCase}):super(AuthInitial()){
    on<SentOtpEvent>(_onSendOtp);
    on<VerifyOtpEvents>(_onVerifyOtp);
    on<FetchCsrfTokenEvent>(_onFetchCsrfToken);
  }


  Future<void> _onSendOtp(SentOtpEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoading());
    try {
      final response = await sendOtpUseCase.execute(event.phoneNumber);
      if (response.success) {
        emit(AuthSuccess(response.message ?? 'OTP verified successfully'));
      } else {
        emit(AuthFailure(response.message ?? 'Failed to verify OTP'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }


  }

  Future<void> _onVerifyOtp (VerifyOtpEvents event, Emitter<AuthState> emit) async{
    emit(AuthLoading());
    try {
      final response = await verifyOtpUseCase.execute(event.phoneNumber, event.otp, event.token);
      if (response.success) {
        emit(AuthSuccess(response.message ?? 'OTP verified successfully'));
      } else {
        emit(AuthFailure(response.message ?? 'Failed to verify OTP'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onFetchCsrfToken(
      FetchCsrfTokenEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await generateCsrfTokenUseCase.execute();
      if (response.success && response.data != null) {
        emit(AuthCsrfTokenFetched(response.data!));  // Emit CSRF token
      } else {
        emit(AuthFailure('Failed to fetch CSRF token'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

}