import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_auth_helper.dart';
import 'package:ammommyappgp/models/user_model.dart';
import 'package:ammommyappgp/screens/profile_screen/profile_screen.dart';
import 'package:ammommyappgp/screens/welcome_screen/welcome_screen.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String week = currentWeeklyInfo!.forMother;

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
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            endDrawer: customDraver(context,snapshot.data!),
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
                                /////////////////////////////////////////////////////////////////////////////////////////
                                ///
                                ///
                                ///
                                ///
                                ///
                                /// weeks view
                                return GestureDetector(
                                  onTap: () {
                                    currentWeeklyInfo = weeklyInfo
                                        .where((element) =>
                                            element.week ==
                                            indexCount.toString())
                                        .first;

                                    setState(() {});
                                  },
                                  child: dateCustom(
                                    title: "الأسبوع",
                                    subtitle: arabicNumber[index].toString(),
                                    textColor: indexCount == remainWeeks
                                        ? Colors.white
                                        : Colors.black,
                                    color: indexCount == remainWeeks
                                        ? const Color(0xffD66095)
                                        : Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                titlesss,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff8C8A8A),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 24.0,
                            ),
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: const Color(0xffFFCDD2),
                              child: Image.asset(currentWeeklyInfo!.image),
                              //////////////////////////////////////////////////////////
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text("طول الطفل",
                                  textAlign: TextAlign.center),
                              subtitle: Text(
                                "${currentWeeklyInfo!.forHeight}سم",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Expanded(
                              child: ListTile(
                                title: const Text("وزن الطفل",
                                    textAlign: TextAlign.center),
                                subtitle: Text(
                                  "${currentWeeklyInfo!.forWeight} جم",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text(
                                "الايام المتبقية",
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                " $remainDays ",
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(top: 15, right: 10),
                    color: Theme.of(context).primaryColor,
                    child: const Center(
                        child: Text(
                      " :معلومات هامة في هذا الاسبوع ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "حالة الام",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            displayText,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "حالة الجنين",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            forbaby,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "معلومات إضافية",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (currentWeeklyInfo!.forMoreInfo != "No Data") {
                              if (!await launchUrl(
                                  Uri.parse(currentWeeklyInfo!.forMoreInfo),
                                  mode: LaunchMode
                                      .externalNonBrowserApplication)) {
                                throw Exception(
                                    'تحقق من اتصالك ${currentWeeklyInfo!.forMoreInfo}');
                              }
                            }
                          },
                          child: Text(
                            currentWeeklyInfo!.forMoreInfo,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget customDraver(context,UserModel newMo) {
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
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          newMo.firstName + newMo.lastName,
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
                Expanded(
                    child: Image.asset("assets/logo-removebg-preview 4.png"))
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      "التذكيرات",
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
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
