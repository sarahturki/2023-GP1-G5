import 'package:ammommyappgp/screens/hospital_bag/hospital-bag.dart';
import 'package:ammommyappgp/screens/to_do_list/to_do_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../baby_names/baby_names.dart';
import '../home/home_page.dart';

class CheckList extends StatefulWidget {
  const CheckList({super.key});

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: customDraver(context),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      userData!.firstName + userData!.lastName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      textAlign: TextAlign.center,
                      "أنتي في الأسبوع ${arabicNumber[remainWeeks! - 1]}",
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 100),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: 40,
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          int indexCount = index + 1;

                          return dateCustom(
                            title: "أسبوع",
                            subtitle: arabicNumber[index].toString(),
                            textColor: indexCount == remainWeeks
                                ? Colors.white
                                : Colors.black,
                            color: indexCount == remainWeeks
                                ? const Color(0xffD66095)
                                : Colors.white,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.090,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleItemOfCheckList(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HospitalBag(),
                    ));
                  },
                  title: "حقيبة المستشفى",
                ),
                const SizedBox(
                  width: 10,
                ),
                SingleItemOfCheckList(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ToDoList(),
                    ));
                  },
                  title: "قائمة المهام",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleItemOfCheckList(
                        onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BabyNames(),
                    ));
                  },
                  title: "قائمة أسماء\n الطفل ",
                ),
                const SizedBox(
                  width: 10,
                ),
                SingleItemOfCheckList(
                  onPressed: () {
                 
                  },
                  title: "المعلومات الحيويه",
                ),
              ],
            ),
 Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleItemOfCheckList(
                        onPressed: () {
                  
                  },
                  title: "المقالات",
                ),
                const SizedBox(
                  width: 10,
                ),
                SingleItemOfCheckList(
                  onPressed: () {
                 
                  },
                  title: "الأسئلة الشائعة",
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }
}

class SingleItemOfCheckList extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const SingleItemOfCheckList(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 190,
        width: 190,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder28,
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,

            // begin: const Alignment(
            //   -0.04,
            //   -0.83,
            // ),
            // end: const Alignment(
            //   0.8,
            //   1.68,
            // ),
            colors: [
              ColorConstant.pinkA100Ba,
              ColorConstant.red50,
            ],
          ),
        ),
        // decoration: AppDecoration.outlineIndigoA70033.copyWith(
        //   borderRadius: BorderRadiusStyle.roundedBorder28,

        // ),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        )),
      ),
    );
  }
}
