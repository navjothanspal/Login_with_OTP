import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_with_num/presentation/bloc/auth_bloc.dart';
import 'package:login_api_with_num/presentation/bloc/auth_event.dart';
import 'package:login_api_with_num/presentation/bloc/auth_state.dart';
import 'package:provider/provider.dart';
import '../../data/repo/user_repository_impl.dart';
import '../../domain/usecase/get_users_usecase.dart';
import 'otp_verfication.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        sendOtpUseCase: SendOtpUseCase(AuthRepositoryImpl()),
        verifyOtpUseCase: VerifyOtpUseCase(AuthRepositoryImpl()),
        generateCsrfTokenUseCase: GenerateCsrfToken(AuthRepositoryImpl())
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('Enter Phone Number')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              // BlocConsumer to listen and build UI based on AuthState
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    // Navigate to the OTP screen on success
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpVerificationScreen(
                          phoneNumber: phoneController.text,
                        ),
                      ),
                    );
                  } else if (state is AuthFailure) {
                    // Show a snack bar if authentication fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is AuthLoading
                        ? null // Disable button while loading
                        : () {
                      // Only dispatch SendOtpEvent on button press
                      _sendOtp(context, phoneController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      textStyle: TextStyle(fontSize: 10),
                    ),
                    child: state is AuthLoading
                        ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the widgets vertically
                    crossAxisAlignment: CrossAxisAlignment.center, // Center the widgets horizontally
                    children: [
                      SizedBox(
                        width: 20, // Desired width of the progress indicator
                        height: 20, // Desired height of the progress indicator
                        child: CircularProgressIndicator(
                          strokeWidth: 2, // Adjust the thickness
                          color: Colors.white, // Set the color
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing between the widgets
                      Text('Loading...', style: TextStyle(color: Colors.white)), // Optional text below
                    ],
                  )
                  : Text('Send OTP'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dispatch the SendOtpEvent to AuthBloc
  void _sendOtp(BuildContext context, String phoneNumber) {
    // Only dispatch the event when the button is pressed
    context.read<AuthBloc>().add(SentOtpEvent(phoneNumber));
  }
}


