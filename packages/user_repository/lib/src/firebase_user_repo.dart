import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/src/user_repo.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepo implements UserRepository {
  // ignore: unused_field
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  // TODO: implement user
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap(
      (firebaseUser) async* {
        if (firebaseUser == null) {
          yield MyUser.empty;
        } else {
          yield await userCollection.doc(firebaseUser.uid).get().then(
                (value) => MyUser.fromEntity(
                  MyUserEntity.fromDocument(value.data()!),
                ),
              );
        }
      },
    );
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myuser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myuser.email,
        password: password,
      );

      myuser.userId = user.user!.uid;
      return myuser;
    } catch (e) {
      log("error sign up : $e");
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myuser) async {
    try {
      await userCollection
          .doc(myuser.userId)
          .set(myuser.toEntity().toDocument());
    } catch (e) {
      log("error set : $e");
      rethrow;
    }
  }
}
