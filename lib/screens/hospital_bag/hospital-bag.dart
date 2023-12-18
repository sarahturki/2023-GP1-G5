// ignore_for_file: file_names, use_build_context_synchronously

import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:ammommyappgp/widgets/custom_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/todos_model.dart';

class HospitalBag extends StatefulWidget {
  const HospitalBag({super.key});

  @override
  State<HospitalBag> createState() => _HospitalBagState();
}

class _HospitalBagState extends State<HospitalBag> {
  bool isShowAddButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("حقيبة المستشفى", context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                String newTitle = '';
                return AlertDialog(
                  title: const Text(
                    'إضافة إلى حقيبة المستشفى',
                    textAlign: TextAlign.right,
                  ),
                  content: TextField(
                    textDirection: TextDirection.rtl,
                    autofocus: true,
                    onChanged: (value) {
                      newTitle = value;
                    },
                    decoration: const InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        hintText: 'اضيفي هنا'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('تراجع'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text('إضافة'),
                      onPressed: () async {
                        if (newTitle == "") {
                          showMessage("الرجاء ادخال الإضافة");
                        } else {
                          Todo todo = Todo(
                              completed: false, name: newTitle, uid: "213");
                          FirebaseFirestoreHelper.instance
                              .addName(todo, "hospitalBag");
                          Navigator.of(context).pop();
                          setState(() {});
                        }
                      },
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                stream:
                    FirebaseFirestoreHelper.instance.getNameList("hospitalBag"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text(""));
                  }
                  final sortedTasks = List.from(snapshot.data!);

                  sortedTasks.sort((a, b) {
                    int aDate = a.dateTime!.microsecondsSinceEpoch;
                    int bDate = b.dateTime!.microsecondsSinceEpoch;
                    return bDate.compareTo(aDate);
                  });
                  sortedTasks.sort((a, b) {
                    if (a.completed && !b.completed) {
                      return 1; // a should come after b
                    } else if (!a.completed && b.completed) {
                      return -1; // a should come before b
                    } else {
                      return 0; // no change in order
                    }
                  });
                  return snapshot.data == null || sortedTasks.isEmpty
                      ? const Center(
                          child: Text(""),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: sortedTasks.length,
                          itemBuilder: (context, index) {
                            return CustomListTile(
                              title: sortedTasks[index].name,
                              onDelete: () {
                                Widget cancelButton = TextButton(
                                  child: const Text("تراجع"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                                Widget continueButton = TextButton(
                                  child: const Text("حذف"),
                                  onPressed: () {
                                    FirebaseFirestoreHelper.instance
                                        .daleteNameCompletion(
                                            sortedTasks[index], "hospitalBag");
                                    Navigator.of(context).pop();
                                  },
                                );

                                // set up the AlertDialog
                                AlertDialog alert = AlertDialog(
                                  title: const Text(
                                    "حذف من حقيبة المستشفى",
                                    textAlign: TextAlign.right,
                                  ),
                                  content: const Text(
                                    "هل أنتي متاكدة؟",
                                    textAlign: TextAlign.right,
                                  ),
                                  actions: [
                                    cancelButton,
                                    continueButton,
                                  ],
                                );

                                // show the dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              },
                              onEdit: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      String newTitle = '';
                                      return AlertDialog(
                                        title: const Text(
                                          'تعديل حقيبة المستشفى',
                                          textAlign: TextAlign.right,
                                        ),
                                        content: TextField(
                                          textDirection: TextDirection.rtl,
                                          autofocus: true,
                                          onChanged: (value) {
                                            newTitle = value;
                                          },
                                          decoration: InputDecoration(
                                              hintTextDirection:
                                                  TextDirection.rtl,
                                              hintText:
                                                  sortedTasks[index].name),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('تراجع'),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                          TextButton(
                                            child: const Text('تعديل'),
                                            onPressed: () async {
                                              if (newTitle == "") {
                                                showMessage(
                                                    "الرجاء إدخال التعديل");
                                              } else {
                                                Todo todo = Todo(
                                                    completed: snapshot
                                                        .data![index].completed,
                                                    dateTime: snapshot
                                                        .data![index].dateTime,
                                                    name: newTitle,
                                                    uid:
                                                        sortedTasks[index].uid);
                                                String? uid = FirebaseAuth
                                                    .instance.currentUser!.uid;
                                              
                                                 await FirebaseFirestoreHelper.instance
                                              .updateNameCompletion(
                                                  todo, "hospitalBag");

                                                Navigator.of(context).pop();
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              onChanged: (value) async {
                                sortedTasks[index].completed = value!;

                                Todo todo = Todo(
                                    completed: sortedTasks[index].completed,
                                    name: sortedTasks[index].name,
                                    uid: sortedTasks[index].uid);
                                await FirebaseFirestoreHelper.instance
                                    .updateNameCompletion(todo, "hospitalBag");

                                setState(() {});
                              },
                              value: sortedTasks[index].completed,
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
