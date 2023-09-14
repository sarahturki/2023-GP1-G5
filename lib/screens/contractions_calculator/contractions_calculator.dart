import 'dart:async';

import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/contractions_model.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';

class ContractionsCalculator extends StatefulWidget {
  const ContractionsCalculator({super.key});

  @override
  State<ContractionsCalculator> createState() => _ContractionsCalculatorState();
}

class _ContractionsCalculatorState extends State<ContractionsCalculator>
    with TickerProviderStateMixin {
  CustomTimerController? _controller;
  bool isFirstTime = true;
  int _counter = 0;
  ContractionsModel? contractionsModel;

  Timer? _timer;
  List<ContractionsModel> list = [];
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
      });
    });
  }

  String formatTime(int seconds) {
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    return '$minutes:$remainingSeconds';
  }

  void stopTimer() {
    _timer!.cancel();
  }

  @override
  void initState() {
    _controller = CustomTimerController(
        vsync: this,
        begin: const Duration(hours: 1),
        end: const Duration(hours: 24),
        initialState: CustomTimerState.reset,
        interval: CustomTimerInterval.milliseconds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("حاسبة الانقباضات", context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              CustomTimer(
                controller: _controller!,
                builder: (state, time) {
                  // Build the widget you want!🎉
                  return Center(
                    child: Text(
                      "${time.minutes}:${time.seconds}",
                      style: const TextStyle(fontSize: 50.0),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              const Text(
                "لحساب مدة الانقباض اضغطي الزر",
                style: TextStyle(fontSize: 22.0),
              ),
              const SizedBox(
                height: 36.0,
              ),
              SizedBox(
                width: 100,
                child: PrimaryButton(
                  onPressed: () async {
                    if (_controller!.state.value == CustomTimerState.counting) {
                      // print("HEHHHE")
                      if (isFirstTime) {
                        contractionsModel = ContractionsModel(
                          durationContraction:
                              "${_controller!.remaining.value.minutes}:${_controller!.remaining.value.seconds}",
                          intervalContractions: "-",
                        );
                        isFirstTime = false;
                      } else {
                        contractionsModel = ContractionsModel(
                          durationContraction:
                              "${_controller!.remaining.value.minutes}:${_controller!.remaining.value.seconds}",
                          intervalContractions: formatTime(_counter),
                        );
                      }
                      await FirebaseFirestoreHelper.instance
                          .addContractionsCalculator(contractionsModel!);
                      _controller!.reset();
                      _controller!.pause();
                      startTimer();
                    } else {
                      _controller!.start();
                      if (_timer != null) {
                        stopTimer();
                      }
                    }

                    setState(() {});
                  },
                  title: "يبدأ",
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF1F1F1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(24.0),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "الفاصل بين\nالإنقباضات",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "مدةالإنقباض",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 12.0,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestoreHelper.instance
                            .getContractionCal(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.data!.isEmpty ||
                              snapshot.data == null) {
                            return const Center(
                              child: Text("No Data Found"),
                            );
                          }
                          List<ContractionsModel> conList =
                              snapshot.data!.reversed.toList();
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount:conList.length,
                            itemBuilder: (context, index) {
                              ContractionsModel contractionsModel =
                                  conList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                                  // textBaseline: TextBaseline.alphabetic,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        contractionsModel.intervalContractions,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: CircleAvatar(
                                        radius: 22,
                                        backgroundColor:
                                            const Color(0xffE187B0),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.white,
                                          child: Text("${index + 1}"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        contractionsModel.durationContraction,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 36.0,
              ),
              SizedBox(
                width: 100,
                child: PrimaryButton(
                    onPressed: () async {
                      await FirebaseFirestoreHelper.instance.clearContraction();

                      // print(formatTime(_counter));
                    },
                    title: "واضح"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
