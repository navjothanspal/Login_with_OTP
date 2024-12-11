import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_with_num/domain/usecase/share_preference.dart';

import '../../data/repo/user_repository_impl.dart';
import '../../domain/usecase/get_users_usecase.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'home_page.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  OtpVerificationScreen({required this.phoneNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  String? errorMessage;
  String? csrfToken;
  late bool success;

  @override
  void initState() {
    super.initState();
    // Fetch CSRF token when the screen loads
    context.read<AuthBloc>().add(FetchCsrfTokenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthCsrfTokenFetched) {
              // Store the CSRF token when fetched
              setState(() {
                csrfToken = state.csrfToken;
                print( "data in the block $csrfToken");// Assign the CSRF token received
              });
            }
            if (state is AuthSuccess) {
              success = true;
              print("auth sucesss");
              if (state.message == 'OTP Verified Successfully') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                      (route) => false,
                );
              }
            }
            if (state is AuthFailure) {
              setState(() {
                errorMessage = state.message;
              });
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Text('Phone Number: ${widget.phoneNumber}'),
                TextField(
                  controller: otpController,
                  decoration: InputDecoration(labelText: 'Enter OTP'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                    print("Data ouside the bloc $csrfToken");
                    if (csrfToken != null) {
                      context.read<AuthBloc>().add(
                        VerifyOtpEvents(
                          widget.phoneNumber,
                          otpController.text,
                          csrfToken!,
                        ),

                      );
                      if(state is AuthSuccess){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomePage()),
                              (route) => false,
                        );
                      }
                    } else {
                      setState(() {
                        errorMessage = 'CSRF token is not available yet';
                      });
                    }
                  },
                  child: state is AuthLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Verify OTP'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
