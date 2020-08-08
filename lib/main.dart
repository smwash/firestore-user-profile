import 'package:auth_practice/model/user.dart';
import 'package:auth_practice/screens/authscreen.dart';
import 'package:auth_practice/screens/profilescreen.dart';
import 'package:auth_practice/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return ProfilePage();
              }
              return AuthScreen();
            }),
      ),
    );
  }
}
