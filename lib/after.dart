import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_login/user.dart'; 

class AfterLogin extends StatefulWidget {
  const AfterLogin({Key key, this.user}) : super(key: key);

  @override
  _AfterLoginState createState() => _AfterLoginState();
  final UserModel user;
}

class _AfterLoginState extends State<AfterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("NAMA ${widget.user.name}"),
          Text("Email ${widget.user.email}"),
          CircleAvatar(
            backgroundColor: Colors.teal[800],
            radius: 50,
          )
        ],
      ),
    );
  }
}
