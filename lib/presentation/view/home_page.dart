import 'package:flutter/material.dart';

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
              onPressed: () {},
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