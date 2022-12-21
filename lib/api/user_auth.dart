import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospal/pages/user/jobseeker/js_auth.dart';
import 'package:hospal/pages/user/jobseeker/js_nav_bar.dart';
import 'package:path/path.dart';
import 'package:universal_html/html.dart';

class UserAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String? get userRole {
    String? role;
    try {
      if (currentUser != null) {
        var tmp = FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            if (documentSnapshot.get('role') == 'Jobseeker') {
              role = 'Jobseeker';
            } else if (documentSnapshot.get('role') == 'Employer') {
              role = 'Employer';
            }
            // else {}
          } else {
            print('User does not exist within the database');
          }
        });
      }
    } on Exception catch (e) {
      print(e);
    }
    return role;
  }

  String? get userRoleAsString {
    return userRole.toString();
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
    // required String role, //Validation
  }) async {
    // await _firebaseAuth
    //     .signInWithEmailAndPassword(email: email, password: password)
    //     .then((_) async {
    //   String validatedRole = await validateUserDetails(email, role);
    //   // ignore: unrelated_type_equality_checks
    //   if (role != validatedRole) {
    //     // throw Exception('Role mismatched.\nResult: $validatedRole');
    //     print('Role mismatched.\nResult: $validatedRole');
    //   } else {
    //     print("YAY! CORRECT ROLE.");
    //     // Navigator.of(context).push(MaterialPageRoute(builder: ((context) => JobseekerNavBar()));
    //   }
    // }).catchError((e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // });
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    // required String role, //options: Jobseeker or Employer.
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    // postDetailsToFirestore(email: email, role: role);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
