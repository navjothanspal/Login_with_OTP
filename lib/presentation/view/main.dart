import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_with_num/presentation/bloc/auth_bloc.dart';
import 'package:login_api_with_num/presentation/view/home_page.dart';
import 'package:login_api_with_num/presentation/view/phone_number_verify.dart';
import '../../data/repo/user_repository_impl.dart';
import '../../domain/usecase/get_users_usecase.dart';
import '../../domain/usecase/share_preference.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   final sendOtpUseCase = SendOtpUseCase(AuthRepositoryImpl());
   final verifyOtpUseCase = VerifyOtpUseCase(AuthRepositoryImpl());
  final generateCsrfTokenUseCase= GenerateCsrfToken(AuthRepositoryImpl());

  String? logInToken = await SharedPreferencesService.getString("jwtToken");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            sendOtpUseCase: sendOtpUseCase,
            verifyOtpUseCase:verifyOtpUseCase,
           generateCsrfTokenUseCase: generateCsrfTokenUseCase
          ),
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

