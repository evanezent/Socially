import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_login/handler.dart';
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NAMA ${widget.user.name}"),
            Text("Email ${widget.user.email}"),
            CircleAvatar(
              backgroundColor: Colors.teal[800],
              radius: 50,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                HandlerFunction().signOutGoogle();
                Navigator.pop(context);
              },
              color: Colors.white,
              child: Center(
                child: Text("G-Sign Out"),
              ),
            ),
            RaisedButton(
              onPressed: () {
                HandlerFunction().signOutFacebook();
                Navigator.pop(context);
              },
              color: Colors.blue,
              child: Center(
                child: Text("F-Sign Out"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
