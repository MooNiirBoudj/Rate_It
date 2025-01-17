// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE7BC2F), Color(0xFFFDF8EA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: screenHeight * 0.1),
                // Top images row with text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Left image with text
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/1.png',
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.15,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                    // Right image with text
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/3.png',
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.15,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ],
                ),
                Spacer(flex: 2),
                Text(
                  'Share Honest \nRatings, Make \nInformed Choices',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Outfit',
                  ),
                ),
                Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/4.png',
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.15,
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      'assets/images/2.png',
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.15,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                Spacer(flex: 2),
                // Buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/welcome');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 183, 59),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 12.0,
                          ),
                        ),
                        child: Text(
                          "Let's Start",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Outfit',
                            color: Color.fromARGB(255, 255, 183, 59),
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