import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/small_text.dart';
import 'package:nasma_app/models/article_model.dart';

import 'show_category.dart';

class BodyArticle extends StatefulWidget {
  final List<ArticleModel> allData;
  final List<String> categories;
  const BodyArticle({
    super.key,
    required this.allData,
    required this.categories,
  });

  @override
  State<BodyArticle> createState() => _BodyArticleState();
}

class _BodyArticleState extends State<BodyArticle> {
  List<bool> activeCat = [];
  List<ArticleModel> insideArticles = [];
  int current = 0;
  bool showMore = false;
  @override
  void initState() {
    super.initState();
    widget.categories.forEach((_) {
      activeCat.add(false);
    });
    activeCat[0] = true;
    insideArticles = widget.allData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: 'Categories',
          color: Colors.black,
          size: Dimensions.font20,
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        SizedBox(
          height: Dimensions.height64,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeCat.clear();
                    widget.categories.forEach((_) {
                      activeCat.add(false);
                    });
                    activeCat[index] = true;
                    current = index;
                    print(current);

                    insideArticles = widget.allData
                        .where(
                            (val) => val.category == widget.categories[current])
                        .toList();
                  });
                },
                child: ShowCategory(
                  category: widget.categories[index],
                  active: activeCat[index],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        BigText(
          text: 'Articles',
          color: Colors.black,
          size: Dimensions.font20,
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Expanded(
          child: current == 0
              ? ListView.builder(
                  itemCount: widget.allData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(
                          Dimensions.height20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: widget.allData[index].title!,
                              color: Colors.black,
                              size: Dimensions.font20,
                            ),
                            // widget.allData[index].content!.length > 150 ||
                            //         !showMore
                            //     ? Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             widget.allData[index].content!
                            //                 .substring(
                            //               0,
                            //               150,
                            //             ),
                            //           ),
                            //           TextButton(
                            //             onPressed: () {
                            //               setState(() {
                            //                 showMore = !showMore;
                            //               });
                            //             },
                            //             child: Text(
                            //               'Show More',
                            //             ),
                            //           ),
                            //         ],
                            //       )
                            //     :
                            Text(
                              widget.allData[index].content!,
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : ListView.builder(
                  itemCount: insideArticles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(
                          Dimensions.height20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: insideArticles[index].title!,
                              color: Colors.black,
                              size: Dimensions.font20,
                            ),
                            Text(
                              insideArticles[index].content!,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        ),
      ],
    );
  }
}
