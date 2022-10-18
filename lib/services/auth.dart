import 'package:wol_pro_1/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wol_pro_1/services/database.dart';

import '../screens/register_login/volunteer/sign_in_volunteer.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  Users? _userFromCredUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromCredUser(user));
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));

  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromCredUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password refugee
  Future signInWithEmailAndPasswordRef(String email, String password) async {

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign in with email and password volunteer
  Future signInWithEmailAndPasswordVol(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// register with email and password refugee
  Future registerWithEmailAndPasswordRef(String email, String password, String user_name, String phone_number, String pesel) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('New refugee','2', user_name, phone_number, pesel,[], user.uid);
      return _userFromCredUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// register with email and password volunteer
  Future registerWithEmailAndPasswordVol(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('New volunteer','1', userName, phoneNumber, pesel, chosenCategory, user.uid);
      return _userFromCredUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }




// sign out
Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
}
}