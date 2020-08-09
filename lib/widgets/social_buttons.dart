import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  SocialButtons({
    @required this.icon,
    this.onPress,
  });

  final IconData icon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              icon,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: onPress,
          ),
          Text(
            'SignIn',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
