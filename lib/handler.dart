import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login/user.dart';
import 'package:http/http.dart' as http;

class HandlerFunction {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount;
    try {
      print("jalan");
      googleSignInAccount = await googleSignIn.signIn();
    } catch (e) {
      print(e.toString());
      return null;
    }
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;

    print(user.email);

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      UserModel userModel = UserModel(
          email: user.email, name: user.displayName, userID: user.uid);
      print('signInWithGoogle succeeded: $user');

      return userModel;
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }

  final _fbLogin = FacebookLogin();

  Future<UserModel> facebookSignIn() async {
    try {
      print("fb jalan");
      final FacebookLoginResult result = await _fbLogin.logIn(["email"]);
      final String token = result.accessToken.token;

      final response = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
      final profile = jsonDecode(response.body);

      print(profile);

      UserModel user = UserModel.toJson(profile);
      return user;
      // return profile;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOutFacebook() async {
    await _fbLogin.logOut();

    print("User Signed Out");
  }
}
