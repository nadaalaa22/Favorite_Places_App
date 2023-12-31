import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemoteDS {
  ///
  Future <void> signUp (String email , String password);
  ///
  Future <void> signIn (String email , String password);
  ///
  Future <void> signOut ();
  ///
  bool checkIfAuth () ;

}
class AuthenticationImp implements AuthenticationRemoteDS {
  @override
  bool checkIfAuth() =>  FirebaseAuth.instance.currentUser != null ;

  @override
  Future<void> signIn(String email, String password) async {
   await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signUp(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
