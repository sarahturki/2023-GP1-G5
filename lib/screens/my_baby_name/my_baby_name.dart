// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/firebase_firestore_helper.dart';
import '../../models/todos_model.dart';
import '../../widgets/custom_appbar.dart';

class MyBabyName extends StatelessWidget {
  const MyBabyName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("القائمة المفضلة", context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                String newTitle = '';
                return AlertDialog(
                  title: const Text('أضيفي اسم طفلك الخاص ', textAlign: TextAlign.right,),
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
                      child: const Text('تراجع'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text('إضافة'),
                      onPressed: () async {
                        if (newTitle == "") {
                          showMessage("الرجاء أدخال الاسم");
                        } else {
                          Todo todo = Todo(
                              completed: true, name: newTitle, uid: "213");
                          FirebaseFirestoreHelper.instance
                              .addName(todo, "addName");
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestoreHelper.instance.getNameList("addName"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center();
                }
                return snapshot.data == null || snapshot.data!.isEmpty
                    ? const Center()
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return CustomNameFavorite(
                            onDelete: () {
                              Widget cancelButton = TextButton(
                                child: const Text("تراجع"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              );
                              Widget continueButton = TextButton(
                                child: const Text("حذف"),
                                onPressed: () async {
                                  FirebaseFirestoreHelper.instance
                                      .daleteNameCompletion(
                                          snapshot.data![index], "addName");
                                  Navigator.of(context).pop();
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: const Text("حذف  الأسم" , textAlign: TextAlign.right,),
                                content: const Text("هل انتي متأكدة؟" , textAlign: TextAlign.right,),
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
                                      title: const Text('تعديل الأسم' , textAlign: TextAlign.right,),
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
                                              showMessage("الرجاء أدخال الاسم");
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
                                                      todo, "addName");

                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            title: snapshot.data![index].name,
                            color: Theme.of(context).primaryColor,
                            value: snapshot.data![index].completed,
                            onPressed: () {
                              snapshot.data![index].completed =
                                  !snapshot.data![index].completed;
                              Todo todo = Todo(
                                  completed: snapshot.data![index].completed,
                                  name: snapshot.data![index].name,
                                  uid: snapshot.data![index].uid);

                              FirebaseFirestoreHelper.instance
                                  .addFavourite(todo, "addName");
                            },
                          );
                        },
                      );
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestoreHelper.instance.getFavoriteList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center();
                }
                return snapshot.data == null || snapshot.data!.isEmpty
                    ? const Center()
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return CustomNameFavorite(
                            onDelete: () {
                              Widget cancelButton = TextButton(
                                child: const Text("تراجع"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              );
                              Widget continueButton = TextButton(
                                child: const Text("حذف"),
                                onPressed: () async {
                                  Todo todo = Todo(
                                      completed: false,
                                      name: snapshot.data![index].name,
                                      uid: snapshot.data![index].uid);
                                  await FirebaseFirestoreHelper.instance
                                      .updateSuggestionFavourte(
                                    todo,
                                  );
                                  FirebaseFirestoreHelper.instance
                                      .daleteNameCompletion(
                                          snapshot.data![index], "favName");
                                  Navigator.of(context).pop();
                                },
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: const Text("حذف  الأسم" , textAlign: TextAlign.right,),
                                content: const Text("هل انتي متأكدة؟" , textAlign: TextAlign.right,),
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
                                      title: const Text('تعديل الأسم' , textAlign: TextAlign.right,),
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
                                              showMessage("الرجاء أدخال الاسم");
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
                                                      todo, "favName");

                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            title: snapshot.data![index].name,
                            color: Theme.of(context).primaryColor,
                            value: snapshot.data![index].completed,
                            onPressed: () {
                              snapshot.data![index].completed =
                                  !snapshot.data![index].completed;
                              Todo todo = Todo(
                                  completed: snapshot.data![index].completed,
                                  name: snapshot.data![index].name,
                                  uid: snapshot.data![index].uid);
                              FirebaseFirestoreHelper.instance
                                  .updateSuggestionFavourte(
                                todo,
                              );
                              FirebaseFirestoreHelper.instance
                                  .addFavourite(todo, "favName");
                            },
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNameFavorite extends StatefulWidget {
  final String title;
  final Color color;
  final bool value;
  final void Function()? onPressed, onEdit, onDelete;
  const CustomNameFavorite({
    super.key,
    required this.color,
    required this.title,
    required this.value,
    required this.onPressed,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<CustomNameFavorite> createState() => _CustomNameFavoriteState();
}

class _CustomNameFavoriteState extends State<CustomNameFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(3, 3),
            color: Colors.grey,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Spacer(),

          IconButton(
            icon: const Icon(
              Icons.delete,
              color:  Color.fromARGB(205, 162, 33, 33),
            ),
            onPressed: widget.onDelete,
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.grey,
            ),
            onPressed: widget.onEdit,
          ),
          const Spacer(),
          const Spacer(),
          Text(
            widget.title,
            style: TextStyle(
                color: widget.color, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: widget.value ? Colors.pink : Colors.grey,
            ),
            onPressed: widget.onPressed,
          ),
        ],
      ),
    );
  }
}
