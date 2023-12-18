import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/faq_model.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';


class FrequentlyAskedQuestions extends StatelessWidget {
  final int remainWeeks;
  const FrequentlyAskedQuestions({super.key, required this.remainWeeks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("اسئلة شائعة", context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<FaqModel>>(
            future: FirebaseFirestoreHelper.instance.getFaq(remainWeeks),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                // primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FAQWidget(
                      subtitle: snapshot.data![index].answer,
                      title: snapshot.data![index].question);
                },
              );
            }),
      ),
    );
  }
}

class FAQWidget extends StatelessWidget {
  final String title, subtitle;
  const FAQWidget({super.key, required this.subtitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffE187B0).withOpacity(0.7),
      child: ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        // backgroundColor: Colors.red,
        // controller: controller,
        title: Text(
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24),
            child: Text(
              subtitle,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
