import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("مقالات", context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "تفاصيل الشهر الخامس من الحمل.. التغيرات والاحتياطات",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: const Image(
                  height: 250,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  image: NetworkImage(
                      "https://marionhealth.org/wp-content/uploads/2018/04/ThinkstockPhotos-835757744.jpg"),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0)),
                padding: const EdgeInsets.all(24),
                child: const Text(
                  "تفاصيل الشهر الخامس من الحمل مختلفة عن باقي الشهور للحامل حيث إن هناك العديد من الاختلافات التي يخبرك بها طبيبك في هذا الشهر حيث إن شكل الجنين في الشهر الخامس من الحمل يتغير بشكل كبير حيث يصبح جنينك أكثر نشاطًا هذا الشهر وقد يكون لديك المزيد من الأعراض الجسدية للحمل بسبب نمو بطنك. تغيرات علي الحامل في الشهر الخامس من الحمل في هذه الفترة سوف تتعرضي تغيرات علي الحامل في الشهر الخامس من الحمل منها التغيرات الجسدية في الشهر الخامس من الحمل وقد تشمل الأعراض الجسدية التي تعاني منها هذا الشهر ما يلي: إعياء إمساك حرقة من المعدة انتفاخ (غاز) احتقان الأنف أو نزيف الأنف نزيف اللثة زيادة الشهية كاحلين متورمين أقدام مؤلمة توسع الأوردة إفرازات مهبلية بيضاء علامات التمدد ضيق التنفس آلام الظهر تغيرات تصبغ الجلد الذهول",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
