import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/models/appointments_model.dart';
import 'package:ammommyappgp/models/contractions_model.dart';
import 'package:ammommyappgp/models/report_model.dart';
import 'package:ammommyappgp/models/todos_model.dart';
import 'package:ammommyappgp/models/user_model.dart';
import 'package:ammommyappgp/models/weight_model.dart';
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

  Stream<List<AppointmentsModel>> getAppoinment() {
    // String? uid = _auth.currentUser!.uid;
        String? uid = FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection("user")
        .doc(uid)
        .collection("appointments")
        .snapshots()
        .map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs
              .map((doc) => AppointmentsModel.fromJson(
                  doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Future<bool> addAppointment(AppointmentsModel appointmentsModel) async {
    try {
      // String? uid = _auth.currentUser!.uid;
    String? uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference reference = _firestore
          .collection("user")
          .doc(uid)
          .collection("appointments")
          .doc();
      AppointmentsModel appointmentsModelNew = AppointmentsModel(
          title: appointmentsModel.title,
          desription: appointmentsModel.desription,
          dateTime: appointmentsModel.dateTime,
          id: reference.id);
      await reference.set(appointmentsModelNew.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAppointment(AppointmentsModel appointmentsModel) async {
    try {
      // String? uid = _auth.currentUser!.uid;
    String? uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference reference = _firestore
          .collection("user")
          .doc(uid)
          .collection("appointments")
          .doc(appointmentsModel.id);

      await reference.update(appointmentsModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAppointment(String id) async {
    try {
      // String? uid = _auth.currentUser!.uid;
    String? uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference reference = _firestore
          .collection("user")
          .doc(uid)
          .collection("appointments")
          .doc(id);

      await reference.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<ReportModel>> getReport() {
    String? uid = FirebaseAuth.instance.currentUser!.uid;

    // String? uid = _auth.currentUser!.uid;
    return _firestore
        .collection("user")
        .doc(uid)
        .collection("reports")
        .snapshots()
        .map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs
              .map((doc) =>
                  ReportModel.fromJson(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Stream<List<ContractionsModel>> getContractionCal() {
    // String? uid = _auth.currentUser!.uid;
    String? uid = FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection("user")
        .doc(uid)
        .collection("contractionsCalculator")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs
              .map((doc) => ContractionsModel.fromJson(
                  doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Future<bool> addReport(ReportModel reportModel) async {
    try {
      // String? uid = _auth.currentUser!.uid;
      String? uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference reference =
          _firestore.collection("user").doc(uid).collection("reports").doc();
      ReportModel reportModelNew = ReportModel(
          bloodsuger: reportModel.bloodsuger,
          bloodpressure: reportModel.bloodpressure,
          id: reference.id,
          weight: reportModel.weight,
          dateTime: reportModel.dateTime,
          vitaminD: reportModel.vitaminD,
          calcium: reportModel.calcium,
          hemoglobin: reportModel.hemoglobin);
      await reference.set(reportModelNew.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateReports(ReportModel reportModel) async {
    try {
      // String? uid = _auth.currentUser!.uid;
      String? uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference reference = _firestore
          .collection("user")
          .doc(uid)
          .collection("reports")
          .doc(reportModel.id);

      await reference.update(reportModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteReport(String id) async {
    try {
      // String? uid = _auth.currentUser!.uid;
      String? uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference reference =
          _firestore.collection("user").doc(uid).collection("reports").doc(id);

      await reference.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addContractionsCalculator(
      ContractionsModel contractionsModel) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser!.uid;

      CollectionReference reference = _firestore
          .collection("user")
          .doc(uid)
          .collection("contractionsCalculator");
      await reference.add(contractionsModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future clearContraction() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser!.uid;

      CollectionReference reference = _firestore
          .collection("user")
          .doc(uid)
          .collection("contractionsCalculator");
      QuerySnapshot querySnapshot = await reference.get();
      if (querySnapshot.size > 0) {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }
        showMessage("Successfully Clear");
      } else {
        showMessage("Empty Please Add Something to deleted");
      }
    } catch (e) {
      showMessage("Something went wrong");
    }
  }

  Future updateUser(UserModel userModel) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference reference = _firestore.collection("user").doc(uid);

      await reference.update(userModel.toJson());
      showMessage("Successfully Update");
    } catch (e) {
      showMessage("Something went wrong");
    }
  }

  Future addWeight(String weekNumber, String weight) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference reference = _firestore
          .collection("user")
          .doc(uid)
          .collection("weights")
          .doc(weekNumber);

      await reference.set({
        "weight": weight,
        "id": weekNumber,
      });
      // showMessage("Successfully Update");
    } catch (e) {
      showMessage("Something went wrong");
    }
  }

  Future<List<WeightModel>> getAllWeight() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference reference =
          _firestore.collection("user").doc(uid).collection("weights");

      QuerySnapshot<Object?> querySnapshot = await reference.get();
      return querySnapshot.docs
          .map((e) => WeightModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      // showMessage("Successfully Update");
    } catch (e) {
      return [];
    }
  }
}
