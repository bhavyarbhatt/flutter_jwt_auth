import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white, Colors.green,
              ],
              begin: FractionalOffset(0.0,0.1),
              end: FractionalOffset(0.0,1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.repeated,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign up with email",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
                ),
                ),

                SizedBox(
                  height: 20,
                ),
            ],
          ),
        )
    );
  }

  Widget usernameTextFeild(String label) {
    return Column(
      children: [
        Text("label"),
      ],
    );
  }

}