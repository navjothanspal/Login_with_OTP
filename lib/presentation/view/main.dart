import 'package:flutter/material.dart';
import 'package:login_api_with_num/presentation/view/phone_number_verify.dart';
import 'package:provider/provider.dart';

import '../../data/repo/user_repository_impl.dart';
import '../../domain/usecase/get_users_usecase.dart';
import '../view_model/authentication_viewModel.dart';
import 'otp_verfication.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(), // Add your AuthViewModel provider
        ),
        // Add other providers here
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Number Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhoneNumberScreen(), // The first screen when the app starts
    );
  }
}






// TextEditingController@override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 4,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: 25),
//                child: Text(
//                   'Login With OTP',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontFamily: 'Roboto',
//                   ),
//                 )
//             )
//
//             ,
//             TextField(
//               controller: _phoneNumberController ,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 prefixIcon: Icon(Icons.phone),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//       ElevatedButton(
//         onPressed: () async {
//           final success = await viewModel.sendOtp(_phoneNumberController.text);
//           if (success) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => OtpVerificationScreen(
//                   phoneNumber:_phoneNumberController.text,
//                 ),
//               ),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(viewModel.message ?? 'Error')),
//             );
//           }
//         },
//         child: viewModel.isLoading
//             ? CircularProgressIndicator(color: Colors.white)
//             : Text('Send OTP'),
//       ),
//           ],
//         ),
//       ),
//     );
//   }
// }

