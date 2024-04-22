import 'package:rezerv/services/auth.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../const/description.dart';
import '../../const/styles.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({super.key, required this.toggle});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //ref for the AuthServices class
  final AuthServices _auth = AuthServices();

  //form key
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
                children: [
                  const Text(
                    "CREATE ACCOUNT",
                    style: TextStyle(
                        color: mainBlue,
                        fontSize: 40,
                        fontFamily: 'PoppinsSemiBold'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    registerdescription,
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
                          //email
                          TextFormField(
                            style: const TextStyle(color: bgBlack),
                            decoration: inputFieldDecoration,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter an email address.";
                              }

                              // Using RegExp for a valid email format
                              RegExp emailRegex = RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                              );

                              if (!emailRegex.hasMatch(val)) {
                                return "Enter a valid email address.";
                              }

                              return null;
                            },
                            onChanged: (val) {
                              print("Email: $val");
                              setState(() {
                                email = val;
                              });
                            },
                          ),

                          const SizedBox(
                            height: 40,
                          ),

                          //password
                          TextFormField(
                            style: const TextStyle(color: bgBlack),
                            decoration: inputFieldDecoration.copyWith(
                                hintText: "Password"),
                            validator: (val) => val!.length < 6
                                ? "Enter a valid password."
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
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  error = "Register error.";
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
                                  "REGISTER",
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
                                "Already have an account?",
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
                                  "LOGIN",
                                  style: TextStyle(
                                      color: mainBlue,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
