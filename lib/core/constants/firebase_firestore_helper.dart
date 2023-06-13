import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/models/todos_model.dart';
import 'package:ammommyappgp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/weekly_info.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future senddate(DateTime formatedDuedate, BuildContext context) async {
    showLoaderDialog(context);
    User? user = _auth.currentUser;
    String userId = user!.uid;
    await Future.wait([
      addSuggestionFemaleName(),
      addSuggestionMaleName(),
    ]);
    await _firestore.collection('user').doc(userId).update({
      'dueDate': formatedDuedate,
      // add any other user data you want to store
    });
  }

  Future<void> addSuggestionFemaleName() async {
    for (var element in suggestionNameFemale) {
      await addName(Todo(completed: false, name: element, uid: "1"),
          "femaleNameSuggestion");
    }
  }

  Future<void> addSuggestionMaleName() async {
    for (var element in suggestionNameMale) {
      await addName(Todo(completed: false, name: element, uid: "1"),
          "maleNameSuggestion");
    }
  }

  Stream<List<Todo>> getTodoList() {
    String? uid = _auth.currentUser!.uid;
    return _firestore
        .collection("user")
        .doc(uid)
        .collection('todos')
        .snapshots()
        .map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs
              .map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Future<void> addTodo(Todo todo) {
    String? uid = _auth.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> reference =
        _firestore.collection("user").doc(uid).collection('todos').doc();

    Todo add =
        Todo(completed: todo.completed, name: todo.name, uid: reference.id);
    return reference.set(add.toJson());
  }

  Future<void> updateTodoCompletion(Todo todo, bool completed) {
    String? uid = _auth.currentUser!.uid;
    return _firestore
        .collection("user")
        .doc(uid)
        .collection('todos')
        .doc(todo.uid)
        .update({'completed': completed});
  }

  Stream<List<Todo>> getNameList(String collectionName) {
    String? uid = _auth.currentUser!.uid;
    return _firestore
        .collection("user")
        .doc(uid)
        .collection(collectionName)
        .snapshots()
        .map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs
              .map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Stream<List<Todo>> getFavoriteList() {
    String? uid = _auth.currentUser!.uid;
    return _firestore
        .collection("user")
        .doc(uid)
        .collection("favName")
        .where("completed", isEqualTo: true)
        .snapshots()
        .map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs
              .map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Future<void> addName(Todo todo, String collectionName) {
    String? uid = _auth.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> reference =
        _firestore.collection("user").doc(uid).collection(collectionName).doc();

    Todo add =
        Todo(completed: todo.completed, name: todo.name, uid: reference.id);
    return reference.set(add.toJson());
  }

  Future<void> addFavourite(Todo todo, String collectionName) {
    String? uid = _auth.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> reference = _firestore
        .collection("user")
        .doc(uid)
        .collection(collectionName)
        .doc(todo.uid);

    Todo add =
        Todo(completed: todo.completed, name: todo.name, uid: reference.id);
    return reference.set(add.toJson());
  }

  Future<void> updateNameCompletion(Todo todo, String collectionName) {
    String? uid = _auth.currentUser!.uid;
    return _firestore
        .collection("user")
        .doc(uid)
        .collection(collectionName)
        .doc(todo.uid)
        .update(todo.toJson());
  }

  Future<void> updateSuggestionFavourte(
    Todo todo,
  ) async {
    String? uid = _auth.currentUser!.uid;
    DocumentSnapshot docsna = await _firestore
        .collection("user")
        .doc(uid)
        .collection("maleNameSuggestion")
        .doc(todo.uid)
        .get();

    return docsna.exists
        ? _firestore
            .collection("user")
            .doc(uid)
            .collection("maleNameSuggestion")
            .doc(todo.uid)
            .update({"completed": todo.completed})
        : _firestore
            .collection("user")
            .doc(uid)
            .collection("femaleNameSuggestion")
            .doc(todo.uid)
            .update({"completed": todo.completed});
  }

  Future<void> daleteNameCompletion(Todo todo, String collectionName) {
    String? uid = _auth.currentUser!.uid;
    return _firestore
        .collection("user")
        .doc(uid)
        .collection(collectionName)
        .doc(todo.uid)
        .delete();
  }

  Future<UserModel> getUserModel() async {
    String? uid = _auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection("user").doc(uid).get();
    UserModel returnUserModel = UserModel.fromJson(documentSnapshot.data()!);
    return returnUserModel;
  }

  Future<void> getWeekInfo() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("weekly_Info").get();
    weeklyInfo = querySnapshot.docs
        .map((e) => WeeklyInfo.fromJson(e.data() as Map<String, dynamic>))
        .toList();

   
  }
}
