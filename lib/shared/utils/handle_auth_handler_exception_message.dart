

import 'package:firebase_auth/firebase_auth.dart';

String handleAuthExceptionMessage(FirebaseAuthException error) {
  String message = 'An error occurred during authentication.';
  switch (error.code) {
    // Errors common to both createUserWithEmailAndPassword and signInWithEmailAndPassword
    case 'weak-password':
      message = 'The password provided is too weak.';
      break;
    case 'invalid-email':
      message = 'The email address you entered is invalid.';
      break;
    case 'operation-not-allowed':
      message = 'This operation is not allowed. Make sure you enabled Email/Password sign-in in the Firebase console.';
      break;
    case 'network-request-failed':
      message = 'Please check your internet connection and try again.';
      break;

    // Errors specific to signInWithEmailAndPassword
    case 'user-disabled':
      message = 'The user account you entered is disabled.';
      break;
    case 'user-not-found':
      message = 'The email address or password is incorrect.';
      break;
    case 'wrong-password':
      message = 'The email address or password is incorrect.';
      break;
    case 'invalid-credential':
      message = 'The provided sign-in credential is invalid.';
      break;
    default:
      message = 'Please contact support for assistance.';
  }
  return message;
}