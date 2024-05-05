import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/description.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/services/auth.dart';

class Login extends StatefulWidget {
  final Function toggle;
  const Login({Key? key, required this.toggle}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "WELCOME BACK",
                  style: TextStyle(
                      color: mainBlue,
                      fontSize: 40,
                      fontFamily: 'PoppinsSemiBold'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  logindescription,
                  style: descriptionStyle,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(color: bgBlack),
                          decoration: inputFieldDecoration,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter an email address.";
                            }
                            RegExp emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                            );

                            if (!emailRegex.hasMatch(val)) {
                              return "Enter a valid email address.";
                            }

                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          style: const TextStyle(color: bgBlack),
                          decoration: inputFieldDecoration.copyWith(
                              hintText: "Password"),
                          validator: (val) => val!.length < 6
                              ? "Enter a valid password?"
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        //error text
                        Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontFamily: 'PoppinsRegular',
                            fontSize: 20,
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        GestureDetector(
                          onTap: () async {
                            dynamic result = await _auth
                                .loginWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = "Login error.";
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: mainBlue,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Center(
                              child: Text(
                                "LOG IN",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    fontFamily: 'PoppinsSemiBold'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do not have an account?",
                              style: descriptionStyle,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(
                                  color: mainBlue,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'PoppinsRegular',
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
