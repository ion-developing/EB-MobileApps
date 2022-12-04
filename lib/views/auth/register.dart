import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:superestaurants/api/user/service.dart';
import '../../api/user/user.dart';
import '../../theme/design.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterStateful();
}

class RegisterStateful extends State<Register> {
  // UserService auth = UserService();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  register() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    User push = User(
        username: usernameController.text,
        password: passwordController.text,
        first_name: nameController.text,
        last_name: lastNameController.text);
    var user = await UserService.register(push);
    if (user != null) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
      print(user);
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error has occurred'),
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
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2699FB)),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff2699FB)),
                          ),
                          TextButton(
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2699FB)),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TextField(
                          style: const TextStyle(color: Color(0xff2699FB)),
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: Design.myInputBorder,
                            enabledBorder: Design.myInputBorder,
                            focusedBorder: Design.myInputBorder,
                            hintText: 'First Name',
                            hintStyle: TextStyle(color: Color(0xff2699FB)),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: TextField(
                          style: const TextStyle(color: Color(0xff2699FB)),
                          controller: lastNameController,
                          decoration: const InputDecoration(
                              border: Design.myInputBorder,
                              enabledBorder: Design.myInputBorder,
                              focusedBorder: Design.myInputBorder,
                              hintText: 'Lastname',
                              hintStyle: TextStyle(color: Color(0xff2699FB))),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: TextField(
                          style: const TextStyle(color: Color(0xff2699FB)),
                          controller: usernameController,
                          decoration: const InputDecoration(
                              border: Design.myInputBorder,
                              enabledBorder: Design.myInputBorder,
                              focusedBorder: Design.myInputBorder,
                              prefixIcon:
                                  Icon(Icons.email, color: Color(0xff2699FB)),
                              hintText: 'Username',
                              hintStyle: TextStyle(color: Color(0xff2699FB))),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: TextField(
                          style: const TextStyle(color: Color(0xff2699FB)),
                          obscureText: true,
                          controller: passwordController,
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
                            child: const Text('Register'),
                            onPressed: () {
                              register();
                            },
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}
