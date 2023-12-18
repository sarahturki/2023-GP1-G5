import 'package:ammommyappgp/models/article_model.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final ArticleModel articleModel;
  const ArticleDetailsScreen({super.key, required this.articleModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("مقالات", context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                articleModel.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image(
                  height: 250,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  image: NetworkImage(articleModel.image),
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
                child:  Text(
                  articleModel.description,
                  
                            textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
