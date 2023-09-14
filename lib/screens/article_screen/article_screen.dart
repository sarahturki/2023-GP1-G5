import 'package:ammommyappgp/screens/article_details_screen/article_details_screen.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("مقالات", context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              ArticleWidget(),
              SizedBox(
                height: 12.0,
              ),
              ArticleWidget(),
              SizedBox(
                height: 12.0,
              ),
              ArticleWidget(),
              SizedBox(
                height: 12.0,
              ),
              ArticleWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ArticleDetailsScreen(),
        ));
      },
      child: Card(
        elevation: 2.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: const Text(
                  "تفاصيل الشهر الخامس من الحمل.. التغيرات والاحتياطات",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
                child: const Image(
                  height: 150,
                  fit: BoxFit.cover,
                  // width: 100,
                  image: NetworkImage(
                      "https://marionhealth.org/wp-content/uploads/2018/04/ThinkstockPhotos-835757744.jpg"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
