import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});
  
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE7BC2F), Color(0xFFFDF8EA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Image.asset(
                  'assets/images/5.png',
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  margin: EdgeInsets.all(screenWidth * 0.05),
                  child: Text(
                    'Welcome to RateIt your go-to platform for sharing and discovering trustworthy reviews. Get reliable feedback to make better, informed choices!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ),
                Spacer(flex: 2),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.04,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 183, 59),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: screenHeight * 0.015,
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}