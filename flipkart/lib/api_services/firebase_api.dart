import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_first_app/todo_application/todo_model.dart';

class FirebaseApi {
  FirebaseApi._();

  static FirebaseApi instance = FirebaseApi._();

  User? user;

  //SignUP
  Future<User?> signUp(String email, String password, String name) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      log(credential.user.toString());
      user = credential.user;

      //firebasecloud storage

      if (user != null) {
        await user?.updateDisplayName(name);
        createUser(name, user!.email!, user!.uid);
      }

      return credential.user;
    } on FirebaseAuthException catch (e) {
      log(e.code);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //Login
  Future<User?> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      log(credential.user.toString());
      user = credential.user;

      return credential.user;
    } on FirebaseAuthException catch (e) {
      log(e.code);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

//Google Login

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//Phone verification
  Future<void> phoneVerify(String countryCode, String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCode + phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        log("$credential verification Completed",
            name: 'verificationCompleted');
      },
      verificationFailed: (FirebaseAuthException e) {
        log(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //fireBaseCloud Storage
  Future<void> createTodos(TodoModel model) async {
    final user = FirebaseAuth.instance.currentUser;

    CollectionReference todos = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('todos');
    await todos.add(model.toMap()).then((value) {
      log(
        '${value.id} ${value.path} ${value.parent}',
        name: 'createTodos',
      );
    }).catchError((e) {
      log(e.toString(), name: 'createTodos error');
    });
  }

  //Bloc provider(create todos)
  Future<bool> createTodo(TodoModel model) async {
    final user = FirebaseAuth.instance.currentUser;

    CollectionReference todos = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('todos');

    model.id - todos.doc().id;

     return await todos.doc(model.id).set(model.toMap()).then((value) {
      log('added', name: 'fire base api');
      return true;
    }).catchError((e) {
      log(e.toString(), name: 'createTodo');
      return false;
    });
  }

//Delete todos (blocProvider)
   Future<bool> deleteTodo(String id) async{
    final user = FirebaseAuth.instance.currentUser;
    final todoId = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('todos')
        .doc(id);
    await todoId.delete();
    return true;
  }
  //fireBaseCloud Storage-- createuser

  Future<void> createUser(String username, String email, String docId) async {
    DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(docId);
    await users.set({
      'user_name': username,
      'email': email,
    }).then(
      (value) {
        log('sucess', name: 'createUser');
      },
    ).catchError(
      (e) {
        log(e.toString(), name: 'createUser error');
      },
    );
  }

  //fireBaseCloud Storage-- getTodosuser

  Future<List<QueryDocumentSnapshot<Object?>>> getTodos() async {
    final user = FirebaseAuth.instance.currentUser;

    CollectionReference todos = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('todos');
    final res = await todos.get();
    return res.docs;
  }

//update todos
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> updateTodos() {
    return users
        .doc('3')
        .update({})
        .then((value) => log("User deleted"))
        .catchError((error) => log("Failed to update user: $error"));
  }

//delete  todos

  Future<void> deleteTodos() {
    return users
        .doc('ABC123')
        .delete()
        .then((value) => log("User Deleted"))
        .catchError((error) => log("Failed to delete user: $error"));
  }
}
