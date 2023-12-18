// ignore_for_file: unnecessary_null_comparison

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
  final List<WeightModel> weightList;
  const WeightControlDetails(
      {super.key, required this.weightModel, required this.weightList});

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
    getMessage();
    super.initState();
  }

  WeightModel? getWeightModelById(
    String id,
  ) {
    for (var weightModel in widget.weightList) {
      if (weightModel.id == id) {
        return weightModel;
      }
    }
    return null;
  }

  String message = "";
  // double gainWeight = 0.0;
  double calculateDifference(double initialWeight, double finalWeight) {
    return finalWeight - initialWeight;
  }

  double totalGainLoss = 0.0;
  void getMessage() {
    WeightModel? lastNonNullValue;
    WeightModel? secondToLastNonNullValue;
    for (WeightModel? value in widget.weightList.reversed) {
      if (value != null) {
        if (lastNonNullValue == null) {
          lastNonNullValue = value;
        } else if (secondToLastNonNullValue == null) {
          secondToLastNonNullValue = value;
          break; // Found the second non-null value
        }
      }
    }

    if (lastNonNullValue != null && secondToLastNonNullValue != null) {
      double firstSecondDifference = calculateDifference(
        double.parse(widget.weightList.first.weight),
        double.parse(secondToLastNonNullValue.weight),
      );
      double firstThirdDifference = calculateDifference(
        double.parse(widget.weightList.first.weight),
        double.parse(lastNonNullValue.weight),
      );

      totalGainLoss = firstThirdDifference - firstSecondDifference ;
      int currentMonth = getMonth(remainWeeks!);
      double currentWeight = double.parse(lastNonNullValue.weight);
      double previousWeight = double.parse(widget.weightList.first.weight);
      double gainWeight = currentWeight - previousWeight;

      if (gainWeight < -2) {
        message = "فقدان وزن غير طبيعي";
      } else if (currentMonth <= 3) {
        if (gainWeight > 2) {
          message = "وزن زائد";
        } else {
          message = "وزن طبيعي";
        }
      } else if (currentMonth > 3 && currentMonth <= 5) {
        if (gainWeight > 4) {
          message = "وزن زائد";
        } else {
          message = "وزن طبيعي";
        }  if (gainWeight < -4) {
        message = "فقدان وزن غير طبيعي";
      }
      } else if (currentMonth == 6) {
        if (gainWeight > 6) {
          message = "وزن زائد";
        } else {
          message = "وزن طبيعي";
        }if (gainWeight < -6) {
        message = "فقدان وزن غير طبيعي";
      }
      } else if (currentMonth >= 7) {
        if (gainWeight > 8) {
          message = "وزن زائد";
        } else {
          message = "وزن طبيعي";
        } if (gainWeight < -8) {
        message ="فقدان وزن غير طبيعي";
      }
      }
    }
    setState(() {});
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: EdgeInsets.only(right: 3),
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

                          return dateCustom(
                            title: "الأسبوع",
                            subtitle: arabicNumber[index].toString(),
                            weight: getWeightModelById(indexCount.toString()) ==
                                    null
                                ? "-"
                                : getWeightModelById(indexCount.toString())!
                                            .id ==
                                        indexCount.toString()
                                    ? getWeightModelById(indexCount.toString())!
                                        .weight
                                    : "-",
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
            const SizedBox(
              height: 56.0,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: (){
                  print(widget.weightList.length);
                  print(widget.weightList.first.weight);
                },

                
                child: Center(
                  child: Text(
                    totalGainLoss < 0
                        ? "لقد فقدتي  ${totalGainLoss.toString().replaceAll("-", "")}  كجم من الوزن"
                        : "لقد اكتسبتي $totalGainLoss  كجم من الوزن",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
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
                  },
                  icon: Icon(
                    isEdit ? Icons.close : Icons.edit_calendar,
                    size: 50,
                    color: const Color(0xffE187B0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  width: 350,
                  child: Column(
                    children: [
                      const Text(
                        ": وزنك الحالي هو ",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      isEdit
                          ? TextFormField(

                                                    maxLength: 5 ,

                              onFieldSubmitted: (value) async {
                                await FirebaseFirestoreHelper.instance
                                    .addWeight(remainWeeks.toString(), value);
                                setState(() {
                                  if (weightModel != null) {
                                    weightModel!.weight = value;
                                  } else {
                                    weightModel = WeightModel(
                                      weight: value,
                                      id: remainWeeks.toString(),
                                    );
                                    widget.weightList.add(weightModel!);
                                  }
                                  isEdit = false;
                                });
                                getMessage();
                              },
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                                          counterText: "الحد الأقصى 5 ارقام",

                                border: InputBorder.none,
                                // alignLabelWithHint: true,
                                hintText: "انقر هنا للكتابة",
                              ),
                            )
                          : Text(
                              "${weightModel == null ? "انقر على العلامة اعلاها " : weightModel!.weight} ",
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            message.isEmpty
                ? const Center()
                : Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      width: 250,
                      decoration: BoxDecoration(
                        color:
                            message == "وزن طبيعي" ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        message,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
