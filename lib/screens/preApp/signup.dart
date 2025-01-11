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
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
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
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        await Future.delayed(Duration(seconds: 2));

        final db = await DBHelper.getDatabase();

        final user = {
          'Name': nameController.text,
          'username': usernameController.text,
          'password': passwordController.text,
        };
        await db.insert(
          'user',
          user,
          conflictAlgorithm: ConflictAlgorithm.abort,
        );

        Navigator.pop(context);

        /* 
        print('User Signup Successful:');
        print('Full Name: ${user['firstName']}');
        print('Email: ${user['email']}');
        */

        Navigator.pushNamed(context, '/login');
      } catch (e) {
        Navigator.pop(context);

        if (e.toString().contains('UNIQUE constraint failed')) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Signup Failed'),
              content: Text('User name must be unique.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Signup Failed'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
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
            colors: [Color(0xFFE7BC2F), Color(0xFFFDF8EA)],
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
                                  return "Name can't be empty";
                                } else if (!usernameRegex.hasMatch(value)) {
                                  return "Name must contain only letters and numbers";
                                }
                                return null;
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username can't be empty";
                                }
                                return null;
                              },
                              controller: usernameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'User Name',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                              ),
                            ),
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                              indent: 20.0,
                              endIndent: 20.0,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account?'),
                                InkWell(
                                  onTap: () {
                                    if (!loginfirst) {
                                      Navigator.pushNamed(context, '/login');
                                    } else {
                                      Navigator.pop(context);
                                    }
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
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                ' Enter as a guest',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 183, 59),
                                ),
                              ),
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
