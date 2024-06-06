import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  User? getCurrentUser(){
    FirebaseAuth.instance.currentUser;
  }
  // sign In
  Future<UserCredential> signInwithEmailPassword(String email,password) async {
   try{
     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password,
     );
     return userCredential;
   }
   on FirebaseAuthException catch (e) {
     throw Exception(e.code);
   }
  }
  // sign Up
  Future<UserCredential> signUpwithEmailPassword(String email,password) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    }
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

}
