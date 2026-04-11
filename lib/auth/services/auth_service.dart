import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:journal_application/auth/model/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up
  Future<AppUser?> signUp(String email,String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = result.user;

      if(user != null) {
        return AppUser.fromFirebase(user);
      }

      return null;
    }catch (e) {
      throw e.toString();
    }
  }

  // Login
  Future<AppUser?> login(String email,String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      if(user != null) {
        return AppUser.fromFirebase(user);
      }
      return null;
    }catch(e){
      throw e.toString();
    }
  }

  Future<AppUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user != null) {
        return AppUser.fromFirebase(user);
      }

      return null;
    } catch (e) {
      print("Google Error: $e");
      return null;
    }
  }


  // logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // get current user
  AppUser? getCurrentUser(){
    final user = _auth.currentUser;

    if(user != null) {
      return AppUser.fromFirebase(user);
    }
    return null;
  }
}
