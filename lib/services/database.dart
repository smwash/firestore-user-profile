import 'package:auth_practice/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  // final String uid;
  // Database({this.uid});
  final _db = Firestore.instance;

  //storing user to database:
  Future<void> addUser(UserData user) async {
    return await _db
        .collection('users')
        .document(user.userId)
        .setData(user.toMap());
  }

  Future<UserData> getData(String id) async {
    return _db
        .collection('users')
        .document(id)
        .get()
        .then((doc) => UserData.fromFirestore(doc.data));
  }

  //get user data:
  Stream<UserData> getUserData(String uid) {
    return _db
        .collection('users')
        .document(uid)
        .snapshots()
        .map((snapshot) => UserData.fromFirestore(snapshot.data));
  }
}
