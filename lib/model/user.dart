class User {
  String uid;

  User({uid});
}

class UserData {
  final String email;
  final String userId;
  final String userName;
  final String role;
  final String strength;

  UserData({
    this.role,
    this.strength,
    this.email,
    this.userId,
    this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'email': email,
      'userId': userId,
      'strength': strength,
      'userName': userName,
    };
  }

  UserData.fromFirestore(Map<String, dynamic> doc)
      : email = doc['email'],
        userId = doc['userId'],
        role = doc['role'],
        strength = doc['strength'],
        userName = doc['userName'];
}
