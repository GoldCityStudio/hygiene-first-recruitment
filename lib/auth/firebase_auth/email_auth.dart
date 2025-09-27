import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> emailSignInFunc(
  String email,
  String password,
) async {
  try {
    print('Attempting to sign in with email: $email');
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: password);
    print('Sign in successful: ${credential.user?.uid}');
    return credential;
  } catch (e) {
    print('Sign in error: $e');
    rethrow;
  }
}

Future<UserCredential?> emailCreateAccountFunc(
  String email,
  String password,
) async {
  try {
    print('Attempting to create account with email: $email');
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    print('Account creation successful: ${credential.user?.uid}');
    return credential;
  } catch (e) {
    print('Account creation error: $e');
    rethrow;
  }
}
