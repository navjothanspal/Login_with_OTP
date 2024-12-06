import 'package:flutter/material.dart';
import 'package:login_api_with_num/presentation/view/home_page.dart';
import 'package:login_api_with_num/presentation/view/phone_number_verify.dart';
import 'package:provider/provider.dart';

import '../../data/repo/user_repository_impl.dart';
import '../../domain/usecase/get_users_usecase.dart';
import '../../domain/usecase/share_preference.dart';
import '../view_model/authentication_viewModel.dart';
import 'otp_verfication.dart';


Future<void> main() async {
 // WidgetsFlutterBinding.ensureInitialized();
 // await SharedPreferencesService().init();
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
      home: //WelcomePage()
      PhoneNumberScreen(), // The first screen when the app starts
    );
  }
}

