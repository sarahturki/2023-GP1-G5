import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/models/weight_model.dart';
import 'package:flutter/material.dart';

import '../../core/constants/firebase_firestore_helper.dart';

Widget dateCustom(
    {Color? color = Colors.white,
    required String title,
    Color? textColor = Colors.black,
    required String subtitle,
    required String weight}) {
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
          "$title  $subtitle",
          style: TextStyle(
            fontSize: 10,
            color: textColor,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "$weight Kg",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
        ),
      ],
    ),
  );
}

class WeightControlDetails extends StatefulWidget {
  final WeightModel? weightModel;
  const WeightControlDetails({super.key, required this.weightModel});

  @override
  State<WeightControlDetails> createState() => _WeightControlDetailsState();
}

class _WeightControlDetailsState extends State<WeightControlDetails> {
  bool isEdit = false;
  WeightModel? weightModel;
  @override
  void initState() {
    setState(() {
      weightModel = widget.weightModel;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String week = currentWeeklyInfo!.forMother;

    String displayText = week.replaceAll('\\n', '\n');

    String weekforbaby = currentWeeklyInfo!.forBaby;

    String forbaby = weekforbaby.replaceAll('\\n', '\n');

    String weektitle = currentWeeklyInfo!.title;

    String titlesss = weektitle.replaceAll('\\n', '\n');

    return Scaffold(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 50),
                    child: Text(
                      textAlign: TextAlign.center,
                      "مراقبة الوزن",
                      style: TextStyle(color: Colors.white, fontSize: 35),
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
                                      element.week == indexCount.toString())
                                  .first;

                              setState(() {});
                            },
                            child: dateCustom(
                              title: "الأسبوع",
                              subtitle: arabicNumber[index].toString(),
                              weight: weightModel == null
                                  ? "-"
                                  : weightModel!.id == indexCount.toString()
                                      ? weightModel!.weight
                                      : "-",
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
            const SizedBox(
              height: 100.0,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isEdit = !isEdit;
                    });
                    print("Hwello $isEdit");
                  },
                  icon: Icon(
                    isEdit ? Icons.close : Icons.edit_calendar,
                    size: 50,
                    color: const Color(0xffE187B0),
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(40),
                width: 350,
                child: Column(
                  children: [
                    const Text(
                      ":وزنك الحالي هو  ",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    isEdit
                        ? TextFormField(
                            onFieldSubmitted: (value) async {
                              await FirebaseFirestoreHelper.instance
                                  .addWeight(remainWeeks.toString(), value);
                              setState(() {
                                if (weightModel != null) {
                                  weightModel!.weight = value;
                                }
                                isEdit = false;
                              });
                            },
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              // alignLabelWithHint: true,
                              hintText: "اضغط هنا للكتابة",
                            ),
                          )
                        : Text(
                            "${weightModel == null ? "--" : weightModel!.weight} Kg",
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
