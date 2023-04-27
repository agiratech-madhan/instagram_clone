import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../posts/typedefs/user_id.dart';
import '../constants/constants.dart';
import '../models/auth_result.dart';

class Authenticator {
  User? currentUser = FirebaseAuth.instance.currentUser;
  UserId? get userId => currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => currentUser?.displayName ?? '';
  String? get email => currentUser?.email ?? '';

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (token == null) {
      return AuthResult.aborted;
    }
    final oauthCredential = FacebookAuthProvider.credential(token);
    try {
      final r = await FirebaseAuth.instance.signInWithCredential(
        oauthCredential,
      );
      print(r.user?.displayName);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(
          email,
        );
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    // final googleUser = await GoogleSignIn().signIn();
    // final googleAuth = await googleUser?.authentication;
    // final token = googleAuth?.idToken;
    // if (token == null) {
    //   return AuthResult.aborted;
    // }
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    print('signInAccount' '$signInAccount');
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      final UserCredential uc =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      print(uc.user?.displayName);

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
    // return AuthResult.failure;
  }
}
