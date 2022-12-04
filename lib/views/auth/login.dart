import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:superestaurants/api/user/service.dart';
import 'package:superestaurants/views/auth/register.dart';

import '../../api/user/user.dart';
import '../../persistence/preferences.dart';
import '../../theme/design.dart';
import '../list.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => LoginStateful();
}

class LoginStateful extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  initState() {
    super.initState();
    UserService.isLogged().then((value) {
      if (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Restaurants()),
        );
      }
    });
  }

  login(email, password) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    User user = await UserService.login(email, password);
    if (user != null) {
      Preferences prefs = Preferences();
      await prefs.init();
      await prefs.saveUser(user);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Restaurants()),
      );
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid credentials'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            // width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sing In',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2699FB)),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff2699FB)),
                        ),
                        TextButton(
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2699FB)),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      style: const TextStyle(color: Color(0xff2699FB)),
                      decoration: const InputDecoration(
                          border: Design.myInputBorder,
                          enabledBorder: Design.myInputBorder,
                          focusedBorder: Design.myInputBorder,
                          prefixIcon:
                              Icon(Icons.email, color: Color(0xff2699FB)),
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Color(0xff2699FB))),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      width: 360,
                      child: TextField(
                        controller: passwordController,
                        style: const TextStyle(color: Color(0xff2699FB)),
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: Design.myInputBorder,
                            enabledBorder: Design.myInputBorder,
                            focusedBorder: Design.myInputBorder,
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xff2699FB)),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Color(0xff2699FB))),
                      ),
                    ),
                    Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () {
                            login(usernameController.text,
                                passwordController.text);
                          },
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
