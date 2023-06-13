// ignore_for_file: file_names, use_build_context_synchronously

import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:ammommyappgp/widgets/custom_list_tile.dart';
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
                  title: const Text('إضافة إلى حقيبة المستشفى' , textAlign: TextAlign.right,),
                  content: TextField(
                     textDirection: TextDirection.rtl,
                    autofocus: true,
                    onChanged: (value) {
                      newTitle = value;
                    },
                    decoration:
                        const InputDecoration(
                          
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'اضيفي هنا'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('ترجع'),
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
                  return snapshot.data == null || snapshot.data!.isEmpty
                      ? const Center(
                          child: Text(""),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return CustomListTile(
                              title: snapshot.data![index].name,
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
                                            snapshot.data![index], "hospitalBag");
                                    Navigator.of(context).pop();
                                  },
                                );
      
                                // set up the AlertDialog
                                AlertDialog alert = AlertDialog(
                                  title: const Text("حذف من حقيبة المستشفى" ,textAlign: TextAlign.right,),
                                  content: const Text("هل أنتي متاكدة؟" ,textAlign: TextAlign.right,),
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
                                        title: const Text('تعديل حقيبة المستشفى' , textAlign: TextAlign.right,),
                                        content: TextField(
                                           textDirection: TextDirection.rtl,
                                          autofocus: true,
                                          onChanged: (value) {
                                            newTitle = value;
                                          },
                                          decoration: InputDecoration(
                                            hintTextDirection: TextDirection.rtl,
                                              hintText:
                                                  snapshot.data![index].name),
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
                                                showMessage("الرجاء إدخال التعديل");
                                              } else {
                                                Todo todo = Todo(
                                                    completed: snapshot
                                                        .data![index].completed,
                                                    name: newTitle,
                                                    uid: snapshot
                                                        .data![index].uid);
                                                await FirebaseFirestoreHelper
                                                    .instance
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
                                snapshot.data![index].completed = value!;
      
                                Todo todo = Todo(
                                    completed: snapshot.data![index].completed,
                                    name: snapshot.data![index].name,
                                    uid: snapshot.data![index].uid);
                                await FirebaseFirestoreHelper.instance
                                    .updateNameCompletion(todo, "hospitalBag");
      
                                setState(() {});
                              },
                              value: snapshot.data![index].completed,
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
