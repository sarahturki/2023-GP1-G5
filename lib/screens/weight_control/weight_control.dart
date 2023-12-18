import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_auth_helper.dart';
import 'package:ammommyappgp/models/user_model.dart';
import 'package:ammommyappgp/models/weight_model.dart';
import 'package:ammommyappgp/screens/contractions_calculator/contractions_calculator.dart';
import 'package:ammommyappgp/screens/profile_screen/profile_screen.dart';
import 'package:ammommyappgp/screens/welcome_screen/welcome_screen.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/firebase_firestore_helper.dart';
import '../../core/utils/color_constant.dart';
import '../../theme/app_decoration.dart';
import '../check_list/check_list.dart';
import '../weight_details/weight_details.dart';

Widget dateCustom(
    {Color? color = Colors.white,
    required String title,
    Color? textColor = Colors.black,
    required String subtitle}) {
  return Container(
    height: 100,
    width: 60,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 250, 179, 207).withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
        ),
      ],
      border: Border.all(
        color: const Color.fromARGB(255, 250, 179, 207),
        width: 1,
      ),
      color: color!,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
        ),
      ],
    ),
  );
}

class WeightControl extends StatefulWidget {
  const WeightControl({super.key});

  @override
  State<WeightControl> createState() => _WeightControlState();
}

class _WeightControlState extends State<WeightControl> {
  WeightModel? getWeightModelById(
      String id, List<WeightModel> weightModelList) {
    for (var weightModel in weightModelList) {
      if (weightModel.id == id) {
        return weightModel;
      }
    }
    return null; // Return null if no matching id is found
  }

  @override
  Widget build(BuildContext context) {
    String week = currentWeeklyInfo == null ? "" : currentWeeklyInfo!.forMother;

    String displayText = week.replaceAll('\\n', '\n');

    String weekforbaby = currentWeeklyInfo!.forBaby;

    String forbaby = weekforbaby.replaceAll('\\n', '\n');

    String weektitle = currentWeeklyInfo!.title;

    String titlesss = weektitle.replaceAll('\\n', '\n');

    return StreamBuilder<UserModel>(
        stream: FirebaseFirestore.instance
            .collection("user")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots()
            .map((event) => UserModel.fromJson(event.data()!)),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder<List<WeightModel>>(
              stream: FirebaseFirestoreHelper.instance.getAllWeight(),
              builder:
                  (context, AsyncSnapshot<List<WeightModel>> weightSnapshot) {
                if (!weightSnapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0.0,
                    iconTheme: const IconThemeData(color: Colors.white),
                  ),
                  endDrawer: customDraver(context, snapshot.data!),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    "${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 36),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "أنتي في الأسبوع  ${arabicNumber[remainWeeks! - 1]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Transform.translate(
                            offset: const Offset(0, 0),
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
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        SingleItemWeightControl(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ContractionsCalculator(),
                            ));
                          },
                          title: "حاسبة الانقباضات",
                        ),
                        SingleItemWeightControl(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => WeightControlDetails(
                                weightList: weightSnapshot.data!,
                                weightModel: getWeightModelById(
                                    remainWeeks.toString(),
                                    weightSnapshot.data!),
                              ),
                            ));
                          },
                          title:
                              "مراقبة الوزن \n ${getWeightModelById(remainWeeks.toString(), weightSnapshot.data!) == null ? "-" : getWeightModelById(remainWeeks.toString(), weightSnapshot.data!)!.weight} ${getWeightModelById(remainWeeks.toString(), weightSnapshot.data!) != null ? "kg" : ""} ",
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget customDraver(context, UserModel newMo) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, right: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${newMo.firstName} ${newMo.lastName}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            newMo.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img_group56.png'),
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/img_logoremovebgpreview_293x252.png'),
                                fit: BoxFit.contain))),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        "تعديل الملف الشخصي",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.person,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: PrimaryButton(
              onPressed: () async {
                await FirebaseAuthHelper.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                    (route) => false);
                setState(() async {

                                          await Future.delayed(const Duration(seconds:2 ));

                  currentWeeklyInfo = null;
                  selectedWeekOfDetails = 0;
                });
                showMessage("تم تسجيل الخروج بنجاح");
              },
              title: "تسجيل الخروج",
            ),
          ),
        ],
      ),
    );
  }
}

class SingleItemWeightControl extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const SingleItemWeightControl(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 140,
        width: 300,
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
