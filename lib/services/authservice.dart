import 'package:auth_practice/model/user.dart';
import 'package:auth_practice/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = Database();
  var message = '';

  UserData _userFromFirebase(FirebaseUser user) {
    return user != null ? UserData(userId: user.uid) : null;
  }

  Stream<UserData> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  //SignUp:
  Future signUpUser({
    String email,
    String password,
    String username,
    String role,
    String strength,
  }) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //adding username:
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = username;
      await authResult.user.updateProfile(userUpdateInfo);
      await authResult.user.reload();

      //adding user to firestore:
      var user = UserData(
        role: role,
        email: email,
        userId: authResult.user.uid,
        strength: strength,
        userName: username,
      );

      _db.addUser(user);

      return _userFromFirebase(authResult.user);
    } on PlatformException catch (error) {
      if (error != null) {
        print(error);
        message = error.message;
      }
    } catch (err) {
      print(err);
    }
  }

  //login:
  Future logIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on PlatformException catch (error) {
      if (error != null) {
        message = error.message;
      }
    } catch (err) {}
  }

  //sign out:
  Future signOutUser() async {
    try {
      await _auth.signOut();
    } catch (error) {}
  }
}
