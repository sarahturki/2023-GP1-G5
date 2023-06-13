// ignore_for_file: use_build_context_synchronously

import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/todos_model.dart';
import 'package:ammommyappgp/screens/my_baby_name/my_baby_name.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BabyNames extends StatefulWidget {
  const BabyNames({
    super.key,
  });

  @override
  State<BabyNames> createState() => _BabyNamesState();
}

class _BabyNamesState extends State<BabyNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: CustomAppBar.getAppBar("أسماء الطفل", context),
      body: 
      
      
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: kToolbarHeight * 2.0,
            ),
            Text(
              "اختاري جنس الجنين ",
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BabyFemaleNames(),
                    ));
                  },

                  padding: EdgeInsets.zero,
                  child: Image.asset("assets/icons8-babys-room-64-2 1.png"),
                ),
                const SizedBox(
                  width: kTextTabBarHeight * 3,
                ),
                CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BabyMaleNames(),
                      ));
                    },
                    padding: EdgeInsets.zero,
                    child: Image.asset("assets/icons8-babys-room-64 1.png")),
              ],
            ),
            const SizedBox(
              height: 100.0,
            ),
            SizedBox(
              width: 300,
              child: PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyBabyName(),
                  ));
                },
                title: "القائمة المفضلة",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BabyMaleNames extends StatefulWidget {
  const BabyMaleNames({super.key});

  @override
  State<BabyMaleNames> createState() => _BabyMaleNamesState();
}

class _BabyMaleNamesState extends State<BabyMaleNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: CustomAppBar.getAppBar("أسماء الأولاد", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            StreamBuilder(
              stream: FirebaseFirestoreHelper.instance
                  .getNameList("maleNameSuggestion"),
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
                          return CustomFavoriteOne(
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
                                  .updateNameCompletion(
                                      todo, "maleNameSuggestion");
                              FirebaseFirestoreHelper.instance
                                  .addFavourite(todo, "favName");
                            },
                          );
                        },
                      );
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}

class BabyFemaleNames extends StatefulWidget {
  const BabyFemaleNames({super.key});

  @override
  State<BabyFemaleNames> createState() => _BabyFemaleNamesState();
}

class _BabyFemaleNamesState extends State<BabyFemaleNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      appBar: CustomAppBar.getAppBar(" أسماء البنات", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            StreamBuilder(
              stream: FirebaseFirestoreHelper.instance
                  .getNameList("femaleNameSuggestion"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return snapshot.data == null || snapshot.data!.isEmpty
                    ? const Center()
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return CustomFavoriteOne(
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
                                  .updateNameCompletion(
                                      todo, "femaleNameSuggestion");
                              FirebaseFirestoreHelper.instance
                                  .addFavourite(todo, "favName");
                            },
                          );
                        },
                      );
              },
            ),
  
            const SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
// ignore_for_file: must_be_immutable

class CustomFavoriteOne extends StatefulWidget {
  final String title;
  final Color color;
  final bool value;
  final void Function()? onPressed;
  const CustomFavoriteOne({
    super.key,
    required this.color,
    required this.title,
    required this.value,
    required this.onPressed,
  });

  @override
  State<CustomFavoriteOne> createState() => _CustomFavoriteOneState();
}

class _CustomFavoriteOneState extends State<CustomFavoriteOne> {
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
