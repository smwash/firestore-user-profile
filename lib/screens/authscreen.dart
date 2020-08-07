import 'package:auth_practice/widgets/authform.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: AuthForm(),
        ),
      ),
    );
  }
}
