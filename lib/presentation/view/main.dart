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
   WidgetsFlutterBinding.ensureInitialized();
 // await SharedPreferencesService().init();
  String? logInToken = await SharedPreferencesService.getString("jwtToken");
   print("check value  $logInToken");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(), // Add your AuthViewModel provider
        ),
        // Add other providers here
      ],

      child: MyApp(isLoggedIn: logInToken,),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override

  final String? isLoggedIn;

  const MyApp({Key? key,this.isLoggedIn}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Number Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ( isLoggedIn !=null )?const WelcomePage() : PhoneNumberScreen(), // The first screen when the app starts
    );
  }
}

