// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rate_it/DB/dbhelper.dart';
import 'package:rate_it/utilities/orginize.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController UsernameController = TextEditingController();
  bool showPassword = false;
  bool isProcessing = false;
  String message = '';

  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

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
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Log',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            ' In',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username can't be empty";
                                }
                                return null;
                              },
                              controller: UsernameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
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
                                border: const OutlineInputBorder(),
                                labelText: 'Password',
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
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await _handleLogin();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 183, 59),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0,
                                  vertical: 12.0,
                                ),
                              ),
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (isProcessing) const CircularProgressIndicator(),
                            if (!isProcessing && message.isNotEmpty)
                              Text(
                                message,
                                style: TextStyle(
                                  color: message == "Login Successful"
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            const SizedBox(height: 16),
                            const Divider(
                              color: Colors.black,
                              thickness: 1.0,
                              indent: 20.0,
                              endIndent: 20.0,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Not registered yet?'),
                                InkWell(
                                  onTap: () {
                                    if (loginfirst) {
                                      Navigator.pushNamed(context, '/signup');
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    ' Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/main');
                              },
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

 Future<void> _handleLogin() async {
    setState(() {
      isProcessing = true;
      message = '';
    });
    await Future.delayed(const Duration(seconds: 5));
    final db = await DBHelper.getDatabase();
    final List<Map<String, dynamic>> users = await db.query(
      'user',
      where: 'userName = ?',
      whereArgs: [UsernameController.text],
    );

    if (users.isNotEmpty && users[0]['password'] == passwordController.text) {
      setState(() {
        message = "Login Successful";
      });
    } else {
      setState(() {
        message = "Wrong user name or password";
      });
    }

    setState(() {
      isProcessing = false;
    });
  }
}
