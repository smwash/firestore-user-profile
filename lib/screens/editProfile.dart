import 'package:auth_practice/model/user.dart';
import 'package:auth_practice/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class EditProgile extends StatefulWidget {
  @override
  _EditProgileState createState() => _EditProgileState();
}

class _EditProgileState extends State<EditProgile> {
  final _formKey = GlobalKey<FormState>();
  List<String> _strengths = ['50', '100', '150', '200', '300', '400', '500'];
  String _strength;
  String _editedName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return StreamBuilder<Object>(
        stream: Database().getUserData(user.userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          UserData userData = snapshot.data;
          return Container(
            padding: EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      initialValue: userData.userName,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Username is required';
                        }
                        if (value.trim().length < 3) {
                          return 'Username is too short';
                        }
                        if (value.trim().length > 30) {
                          return 'Username is too long';
                        }
                        return null;
                      },
                      onSaved: (value) => _editedName = value,
                    ),
                    SizedBox(height: 15.0),
                    DropdownButtonFormField(
                      value: userData.strength,
                      decoration: kTextFieldDecoration,
                      items: _strengths.map((strength) {
                        return DropdownMenuItem(
                          value: strength,
                          child: Text('$strength points'),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _strength = value),
                    ),
                    SizedBox(height: 15.0),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.teal[200],
                        child: Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final isValid = _formKey.currentState.validate();
                          if (isValid) {
                            _formKey.currentState.save();
                            var updatedUser = UserData(
                              userName: _editedName,
                              strength: _strength,
                              userId: userData.userId,
                              role: userData.role,
                              email: userData.email,
                            );

                            Database().updateProfile(updatedUser);
                            Navigator.pop(context);
                          }
                        }
                        //_handleEditForm,
                        ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
