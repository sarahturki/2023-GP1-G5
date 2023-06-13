// ignore_for_file: use_build_context_synchronously

import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/todos_model.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:ammommyappgp/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});
  static final TextEditingController name = TextEditingController();

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("قائمة المهام", context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                String newTitle = '';
                return AlertDialog(
                  title: const Text('إضافة مهمة' ,textAlign: TextAlign.right,),
                  content: TextField(
                     textDirection: TextDirection.rtl,
                    autofocus: true,
                    onChanged: (value) {
                      newTitle = value;
                    },
                    decoration:
                        const InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'اضيفي مهامك هنا'),
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
                          showMessage("الرجاء أدخال المهمة");
                        } else {
                          Todo todo = Todo(
                              completed: false, name: newTitle, uid: "213");
                          FirebaseFirestoreHelper.instance.addTodo(todo);
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
        child: StreamBuilder(
          stream: FirebaseFirestoreHelper.instance.getTodoList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return snapshot.data == null || snapshot.data!.isEmpty
                ? const Center(
                    child: Text("لا توجد مهام حالية"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CustomListTile(
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
                                      snapshot.data![index], "todos");
                              Navigator.of(context).pop();
                            },
                          );
      
                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: const Text("حذف المهمة" ,textAlign: TextAlign.right,),
                            content: const Text("هل أنتي متأكدة؟" , textAlign: TextAlign.right,),
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
                                  title: const Text('تعديل المهمة' , textAlign: TextAlign.right,),
                                  content: TextField(
                                     textDirection: TextDirection.rtl,
                                    autofocus: true,
                                    onChanged: (value) {
                                      newTitle = value;
                                    },
                                    decoration: InputDecoration(
                                      hintTextDirection: TextDirection.rtl,
                                        hintText: snapshot.data![index].name),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('تراجع'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                      child: const Text('تعديل' ,),
                                      onPressed: () async {
                                        if (newTitle == "") {
                                          showMessage("الرجاء إدخال المهمة");
                                        } else {
                                          Todo todo = Todo(
                                              completed:
                                                  snapshot.data![index].completed,
                                              name: newTitle,
                                              uid: snapshot.data![index].uid);
                                          await FirebaseFirestoreHelper.instance
                                              .updateNameCompletion(
                                                  todo, "todos");
      
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        title: snapshot.data![index].name,
                        onChanged: (value) async {
                          snapshot.data![index].completed = value!;
                          await FirebaseFirestoreHelper.instance
                              .updateTodoCompletion(snapshot.data![index],
                                  snapshot.data![index].completed);
                          setState(() {});
                        },
                        value: snapshot.data![index].completed,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
