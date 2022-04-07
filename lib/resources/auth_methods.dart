// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';

import 'package:capygram/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
    bool isLoading = false,
    // required Uint8List file,
  }) async {
    String res = "Some error ocurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // Register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        // Add user to our database
        _firestore.collection("users").doc(credential.user!.uid).set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        //
        res = "success";
      } else {}
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({required String email, required String password}) async {
    String res = 'Some error occurred ';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'Success';       
      }else{
        res = 'Please enter all fields';
      }
    }
    // You can specify the errors here
    
    // on FirebaseAuthException catch(e){
    //   if (e.code == 'user-not-found') {
        
    //   } else {
    //   }
    // } 
    catch (e) {
      res = e.toString();
    }
    return res;
  }
}