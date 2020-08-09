import 'package:auth_practice/model/user.dart';
import 'package:auth_practice/screens/editProfile.dart';
import 'package:auth_practice/services/authservice.dart';
import 'package:auth_practice/services/database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    final _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('ProfileScreen'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 5),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: StreamBuilder<UserData>(
                  stream: Database().getUserData(user.userId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    UserData userData = snapshot.data;
                    return Column(
                      children: [
                        Text(
                          'UserName: ${userData.userName}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'User Strength: ${userData.strength}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'User Role: ${userData.role}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'UserEmail: ${userData.email}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          child: Text('Edit'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => EditProgile(),
                            );
                          },
                        )
                      ],
                    );
                  }),
            ),
            FlatButton(
              child: Text('SignOut'),
              onPressed: () {
                _auth.signOutUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
