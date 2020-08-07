import 'package:auth_practice/constants.dart';
import 'package:auth_practice/model/user.dart';
import 'package:auth_practice/services/authservice.dart';
import 'package:auth_practice/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _obscureText = true;
  String _username;
  String _userEmail;
  String _userPassword;
  String _role;
  String _strength;

  List<String> _roles = ['Admin', 'User'];
  List<String> _strengths = ['50', '100', '150', '200', '300', '400', '500'];

  _handleSubmitForm() async {
    final _auth = AuthService();
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();

    try {
      print('Signing user:');
      if (isValid) {
        _formKey.currentState.save();
        if (_isLogin) {
          await _auth.logIn(
            email: _userEmail,
            password: _userPassword,
          );
        } else {
          await _auth.signUpUser(
            role: _role,
            email: _userEmail,
            strength: _strength,
            username: _username,
            password: _userPassword,
          );
          print('SigningUp user:');
        }
      }
      if (!isValid) {
        return null;
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                _isLogin ? 'LogIn' : 'SignUp',
                style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.0),
              if (!_isLogin)
                TextFormField(
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
                  onSaved: (value) => _username = value,
                ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Email..',
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }

                  return null;
                },
                onSaved: (value) => _userEmail = value,
              ),
              SizedBox(height: 10.0),
              if (!_isLogin)
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                          value: _role,
                          decoration: kTextFieldDecoration,
                          items: _roles.map((role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text('$role'),
                            );
                          }).toList(),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter a valid strength';
                          //   }
                          //   return 'user';
                          // },
                          onChanged: (value) => setState(() => _role = value)),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _strength,
                        decoration: kTextFieldDecoration,
                        items: _strengths.map((strength) {
                          return DropdownMenuItem(
                            value: strength,
                            child: Text('$strength points'),
                          );
                        }).toList(),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter a valid strength';
                        //   }
                        //   return '50';
                        // },
                        onChanged: (value) => setState(() => _strength = value),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a valid email';
                  }
                  if (value.length < 6) {
                    return 'Password is too short';
                  }
                  return null;
                },
                onSaved: (value) => _userPassword = value,
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.teal[200],
                child: Text(
                  _isLogin ? 'LogIn' : 'SignUp',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _handleSubmitForm,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_isLogin
                      ? 'Create Account?'
                      : 'Already have an account?'),
                  FlatButton(
                    child: Text(_isLogin ? 'SignUp' : 'LogIn'),
                    onPressed: () {
                      setState(() => _isLogin = !_isLogin);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
