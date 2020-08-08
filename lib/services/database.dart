import 'package:auth_practice/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final _db = Firestore.instance;

  //storing user to database:
  Future<void> addUser(UserData user) async {
    return await _db
        .collection('users')
        .document(user.userId)
        .setData(user.toMap());
  }

  //get user data:
  Stream<UserData> getUserData(String uid) {
    return _db
        .collection('users')
        .document(uid)
        .snapshots()
        .map((snapshot) => UserData.fromFirestore(snapshot.data));
  }

  Future<void> updateProfile(UserData user) async {
    return await _db
        .collection('users')
        .document(user.userId)
        .updateData(user.toMap());
  }
}
