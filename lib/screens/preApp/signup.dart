// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rate_it/DB/dbhelper.dart';
import 'package:rate_it/utilities/orginize.dart';
import 'package:sqflite/sqflite.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  String? selectedGender;
  bool showPassword = false;
  bool showConfirmPassword = false;
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9]+$');
  /*void signup() {
    if (_formKey.currentState!.validate()) {
      dummyUser['email'] = emailController.text;
      dummyUser['password'] = passwordController.text;
      Navigator.pushNamed(context, '/login');
    }
  }*/

  void signup() async {
  if (_formKey.currentState!.validate()) {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await Future.delayed(const Duration(seconds: 2));

      final db = await DBHelper.getDatabase();

      final user = {
        'firstName': fullnameController.text,
        'lastName': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'gender': selectedGender,
      };
      await db.insert(
        'users',
        user,
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      Navigator.pop(context); // Close loading dialog

      // Navigate to Home page
      Navigator.pushReplacementNamed(context, '/main');
    } catch (e) {
      Navigator.pop(context); // Close loading dialog

      if (e.toString().contains('UNIQUE constraint failed')) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Signup Failed'),
            content: const Text('A user with this email already exists.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Signup Failed'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE7BC2F), Color(0x00fdf8ea)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 40, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sign',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              ' Up',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Fist name can't be empty";
                                } else if (!usernameRegex.hasMatch(value)) {
                                  return "First name must contain only letters and numbers";
                                }
                                return null;
                              },
                              controller: fullnameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'First name',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                              ),
                            ),
                            SizedBox(height: 6),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Last name can't be empty";
                                } else if (!usernameRegex.hasMatch(value)) {
                                  return "Last name must contain only letters and numbers";
                                }
                                return null;
                              },
                              controller: usernameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Last name',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                              ),
                            ),
                            SizedBox(height: 6),
                            DropdownButtonFormField<String>(
                              value: selectedGender,
                              items: [
                                DropdownMenuItem(
                                  value: 'Male',
                                  child: Text('Male'),
                                ),
                                DropdownMenuItem(
                                  value: 'Female',
                                  child: Text('Female'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                              validator: (value) => value == null
                                  ? "Please select a gender"
                                  : null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Gender',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                              ),
                            ),
                            SizedBox(height: 6),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can't be empty";
                                } else if (!emailRegex.hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                              ),
                            ),
                            SizedBox(height: 6),
                            TextFormField(
                              validator: (value) => value!.isEmpty
                                  ? "Password can't be empty"
                                  : null,
                              controller: passwordController,
                              obscureText: !showPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Confirm password can't be empty";
                                } else if (value != passwordController.text) {
                                  return "Passwords don't match";
                                }
                                return null;
                              },
                              obscureText: !showConfirmPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Password',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showConfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showConfirmPassword =
                                          !showConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            ElevatedButton(
                              onPressed: () {
                                signup();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 183, 59),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40.0,
                                  vertical: 12.0,
                                ),
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 6),
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                              indent: 20.0,
                              endIndent: 20.0,
                            ),
                            Text(
                              'or log in with',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[800],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.facebook,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.g_mobiledata,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.apple,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account?'),
                                InkWell(
                                  onTap: () {if (!loginfirst)
                                    {Navigator.pushNamed(context, '/login');}
                                    else
                                    {Navigator.pop(context);}
                                  },
                                  child: Text(
                                    ' Sign In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
