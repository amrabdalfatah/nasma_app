import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/features/home/presentation/screens/widgets/body_article.dart';
import 'package:nasma_app/features/home/presentation/screens/widgets/show_category.dart';
import 'package:nasma_app/models/article_model.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  List<String> categories = [];
  List<bool> activeCat = [];
  void getCategories(List<ArticleModel> all) {
    categories.clear();
    activeCat.clear();
    categories.add("All");
    activeCat.add(true);
    all.forEach((val) {
      if (categories.isEmpty) {
        categories.add(val.category!);
        activeCat.add(false);
      } else if (!categories.contains(val.category)) {
        categories.add(val.category!);
        activeCat.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(
        Uri.parse(ApiService.article),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        // List<PssResultModel> userTests = [];
        List<ArticleModel> allArticles = [];
        if (snapshot.hasData) {
          List alldata = jsonDecode(snapshot.data!.body);

          alldata.forEach((val) {
            allArticles.add(ArticleModel.fromJson(val as Map<String, dynamic>));
          });
          getCategories(allArticles);
        }
        return BodyArticle(
          categories: categories,
          allData: allArticles,
        );
      },
    );
  }
}
