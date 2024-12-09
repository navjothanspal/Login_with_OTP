import 'package:flutter/material.dart';
import 'package:login_api_with_num/domain/usecase/share_preference.dart';
import 'package:login_api_with_num/presentation/view/phone_number_verify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body:  Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically center
          crossAxisAlignment: CrossAxisAlignment.center, // Horizontally center
          children: [

            Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // background
                foregroundColor: Colors.black, // foreground
              ),
              onPressed: () async {
               await SharedPreferencesService.remove("jwtToken");
               String? jwtToken = await SharedPreferencesService.getString("jwtToken");
               print("here the value of jwt  $jwtToken");
               if(jwtToken == null){

                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(builder: (context) => PhoneNumberScreen()),
                       result: (route) => false,
                 );
               }
              },
                child: Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20 ,color: Colors.white),
                ),
            ),
          ],
        )


      ),
    );
  }
}