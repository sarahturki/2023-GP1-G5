import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  const FrequentlyAskedQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("اسئلة شائعة", context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              FAQWidget(
                subtitle:
                    "في الشهر الثاني من الحمل، لا يمكن تحديد جنس الجنين بالطرق التقليدية المستخدمة في الفحوصات الطبية. عادةً ما يتم تحديد جنس الجنين بدقة أكبر في وقت لاحق من الحمل، عادةً خلال الشهور الرابع أو الخامس. ",
                title: "هل يمكن تحديد جنس الجنين في الشهر الثاني من الحمل؟",
              ),
              SizedBox(
                height: 12.0,
              ),
              FAQWidget(
                subtitle:
                    "في الشهر الثاني من الحمل، لا يمكن تحديد جنس الجنين بالطرق التقليدية المستخدمة في الفحوصات الطبية. عادةً ما يتم تحديد جنس الجنين بدقة أكبر في وقت لاحق من الحمل، عادةً خلال الشهور الرابع أو الخامس. ",
                title:
                    "هل يمكن ممارسة التمارين الرياضية في الشهر الثاني من الحمل؟",
              ),
              SizedBox(
                height: 12.0,
              ),
              FAQWidget(
                subtitle:
                    "في الشهر الثاني من الحمل، لا يمكن تحديد جنس الجنين بالطرق التقليدية المستخدمة في الفحوصات الطبية. عادةً ما يتم تحديد جنس الجنين بدقة أكبر في وقت لاحق من الحمل، عادةً خلال الشهور الرابع أو الخامس. ",
                title:
                    "هل يمكن رؤية الجنين في الشهر الثاني من الحمل؟",
              ),
              SizedBox(
                height: 12.0,
              ),
              FAQWidget(
                subtitle:
                    "في الشهر الثاني من الحمل، لا يمكن تحديد جنس الجنين بالطرق التقليدية المستخدمة في الفحوصات الطبية. عادةً ما يتم تحديد جنس الجنين بدقة أكبر في وقت لاحق من الحمل، عادةً خلال الشهور الرابع أو الخامس. ",
                title:
                    "ما هي الأطعمة التي يجب تجنبها في الشهر الثاني من الحمل؟",
              ),
              SizedBox(
                height: 12.0,
              ),
              FAQWidget(
                subtitle:
                    "في الشهر الثاني من الحمل، لا يمكن تحديد جنس الجنين بالطرق التقليدية المستخدمة في الفحوصات الطبية. عادةً ما يتم تحديد جنس الجنين بدقة أكبر في وقت لاحق من الحمل، عادةً خلال الشهور الرابع أو الخامس. ",
                title:
                    "هل يمكن تناول الأدوية المسكنة للألم في الشهر الثاني من الحمل؟",
              ),
              SizedBox(
                height: 12.0,
              ),
              FAQWidget(
                subtitle:
                    "في الشهر الثاني من الحمل، لا يمكن تحديد جنس الجنين بالطرق التقليدية المستخدمة في الفحوصات الطبية. عادةً ما يتم تحديد جنس الجنين بدقة أكبر في وقت لاحق من الحمل، عادةً خلال الشهور الرابع أو الخامس. ",
                title: "هل يمكن السفر في الشهر الثاني من الحمل؟",
              ),
            ],
          ),
        ),
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
