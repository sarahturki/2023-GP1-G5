import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/article_model.dart';
import 'package:ammommyappgp/screens/article_details_screen/article_details_screen.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  final int remainWeeks;
  const ArticleScreen({super.key, required this.remainWeeks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("مقالات", context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<ArticleModel>>(
            future: FirebaseFirestoreHelper.instance.getArticle(remainWeeks),
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
                  return ArticleWidget(
                    articleModel: snapshot.data![index],
                  );
                },
              );
            }),
      ),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  final ArticleModel articleModel;
  const ArticleWidget({super.key, required this.articleModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ArticleDetailsScreen(articleModel: articleModel),
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
                child: Text(
                  articleModel.title,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Image(
                  height: 150,
                  fit: BoxFit.cover,
                  // width: 100,
                  image: NetworkImage(
                    articleModel.image,
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
