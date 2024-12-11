import 'package:flutter/material.dart';
import 'package:login_api_with_num/domain/usecase/share_preference.dart';
import 'package:login_api_with_num/presentation/view/phone_number_verify.dart';
import 'package:login_api_with_num/utils/dimenstion_file.dart';
import 'package:login_api_with_num/utils/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.homepage),
      ),
      body:  Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically center
          crossAxisAlignment: CrossAxisAlignment.center, // Horizontally center
          children: [
            const Text(
              AppString.welcome,
              style: TextStyle(fontSize: AppDimensions.fontSize_24),
            ),

            SizedBox(height: AppDimensions.height_20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // background
                foregroundColor: Colors.black, // foreground
              ),
              onPressed: () async {
               await SharedPreferencesService.remove(AppString.jwtToken);
               String? jwtToken = await SharedPreferencesService.getString(AppString.jwtToken);
               print("here the value of jwt  $jwtToken");
               if(jwtToken == null){

                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(builder: (context) => PhoneNumberScreen()),
                       result: (route) => false,
                 );
               }
              },
                child: const Text(
                 AppString.logout,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppDimensions.fontSize_20 ,color: Colors.white),
                ),
            ),
          ],
        )
      ),
    );
  }
}