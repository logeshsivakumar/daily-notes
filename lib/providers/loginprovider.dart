

import 'package:dailynotes/customwidgets/utils.dart';
import 'package:dailynotes/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LoginProvider  {
 final FirebaseAuth _firebaseAuth;
  LoginProvider(this._firebaseAuth);
  Stream<User?> get authStateChanges =>_firebaseAuth.authStateChanges();


  Future<String?> signIn(String email, String password,BuildContext context) async{
    showDialog(context: context,barrierDismissible: false, builder: (context)=>const Center(child: CircularProgressIndicator(),));
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      return "Success";
    }on FirebaseAuthException catch(e){
      Utils.showSnackBar(e.message);
    }
     return "";
  }


 Future<String?> signUp(String email, String password,BuildContext context) async{
   showDialog(context: context,barrierDismissible: false, builder: (context)=>const Center(child: CircularProgressIndicator(),));
   try{
     await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
     navigatorKey.currentState!.popUntil((route) => route.isFirst);
     return "Success";
   }on FirebaseAuthException catch(e){
   Utils.showSnackBar(e.message);
   }
   return "";
 }
 Future resetPassword(String resetEmail,BuildContext context) async{
   showDialog(context: context,barrierDismissible: false, builder: (context)=>const Center(child: CircularProgressIndicator(),));
   try{
     await _firebaseAuth.sendPasswordResetEmail(email: resetEmail);
     Utils.showSnackBar("Password reset Email sent");
     navigatorKey.currentState!.popUntil((route) => route.isFirst);
     return "Success";
   }on FirebaseAuthException catch(e){
     Utils.showSnackBar(e.message);
     Navigator.of(context).pop();
   }
   return "";
 }
 }
