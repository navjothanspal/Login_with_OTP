import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repo/user_repository_impl.dart';
import '../../domain/usecase/get_users_usecase.dart';
import '../view_model/authentication_viewModel.dart';
import 'otp_verfication.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Add provider for state management

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  late AuthViewModel _viewModel;  // Declare the ViewModel
  final TextEditingController phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure that the ViewModel is only instantiated once per widget lifecycle
    _viewModel = Provider.of<AuthViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Display the error message if exists
            if (_viewModel.message != null)
              Text(
                _viewModel.message!,
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: _viewModel.isLoading
                  ? null
                  : () {
                _sendOtp(phoneController.text);
              },
              child: _viewModel.isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }

  // Call the ViewModel's method to send OTP
  Future<void> _sendOtp(String phoneNumber) async {
    final isOtpSent = await _viewModel.sendOtp(phoneNumber);
    if (isOtpSent) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            phoneNumber: phoneNumber,
          ),
        ),
      );
    }
  }
}





// class PhoneNumberScreen extends StatefulWidget {
//   @override
//   _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
// }
//
// class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
//   final TextEditingController phoneController = TextEditingController();
//   final sendOtpUseCase = SendOtpUseCase(AuthRepositoryImpl());
//   bool isLoading = false;
//   String? errorMessage;
//
//   Future<void> sendOtp() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });
//
//     final response = await sendOtpUseCase.execute(phoneController.text);
//     print('phone num is  ${phoneController.text}');
//
//     setState(() {
//       isLoading = false;
//       if (response.success) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpVerificationScreen(
//               phoneNumber: phoneController.text,
//
//
//             ),
//           ),
//         );
//       } else {
//         errorMessage = response.message;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Enter Phone Number')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: phoneController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 20),
//             if (errorMessage != null) Text(errorMessage!, style: TextStyle(color: Colors.red)),
//             ElevatedButton(
//               onPressed: isLoading ? null : sendOtp,
//               child: isLoading
//                   ? CircularProgressIndicator(color: Colors.white)
//                   : Text('Send OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }