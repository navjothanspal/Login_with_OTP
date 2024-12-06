import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_api_with_num/domain/usecase/share_preference.dart';

import '../../data/repo/user_repository_impl.dart';
import '../../domain/usecase/get_users_usecase.dart';
import 'home_page.dart';



class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  OtpVerificationScreen({required this.phoneNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  final verifyOtpUseCase = VerifyOtpUseCase(AuthRepositoryImpl());
  final csrfTokenUseCase =GenerateCsrfToken(AuthRepositoryImpl());

  bool isLoading = false;
  String? errorMessage;
  String? csrfToken;
  String? jwdToken; // Variable to store the CSRF token

  @override
  void initState() {
    super.initState();
    _fetchCsrfToken(); // Fetch the CSRF token on screen initialization
  }

  Future<void> _fetchCsrfToken() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await csrfTokenUseCase.execute();
      if (response.success && response.data != null) {
        setState(() {
          csrfToken = response.data; // Store the CSRF token
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch CSRF token';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  Future<void> verifyOtp() async {
    if (csrfToken == null) {
      setState(() {
        errorMessage = 'CSRF token not available';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });
      print( csrfToken);
    final response = await verifyOtpUseCase.execute(
      widget.phoneNumber,
      otpController.text,
      csrfToken!, // Pass the CSRF token here
    );

    setState(() {
      isLoading = false;
      if (response.success ) {

         // jwdToken = SharedPreferencesService().getString("jwdToken");
        //  print("check value  $jwdToken");


        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()),
              (route) => false,
        );
      } else {
        errorMessage = response.message;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Phone Number: ${widget.phoneNumber}'),
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            if (errorMessage != null)
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: isLoading ? null : verifyOtp,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

