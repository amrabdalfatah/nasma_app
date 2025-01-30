import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/small_text.dart';
import 'package:nasma_app/models/user_session.dart';
import 'package:http/http.dart' as http;

class ShowDuration extends StatefulWidget {
  final List<UserSession> sessions;

  const ShowDuration({
    super.key,
    required this.sessions,
  });

  @override
  State<ShowDuration> createState() => _ShowDurationState();
}

class _ShowDurationState extends State<ShowDuration> {
  int duration = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondColor,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BigText(
                  text: 'Num. Sessions',
                  size: Dimensions.font16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                SmallText(
                  text: widget.sessions.length.toString(),
                  color: Colors.grey[500],
                  size: Dimensions.font32,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BigText(
                  text: 'Count Minutes',
                  size: Dimensions.font16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                FutureBuilder(
                  future: http.get(
                    Uri.parse(ApiService.breathingSession),
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
                    if (snapshot.hasData) {
                      List alldata = jsonDecode(snapshot.data!.body);
                      // List<PssResultModel> allTests = [];
                      // alldata.forEach((val) {
                      //   print(val["duration"]);
                      // });

                      List results = [];
                      for (int i = 0; i < widget.sessions.length; i++) {
                        var result = alldata.firstWhere(
                          (item) => item["id"] == widget.sessions[i].id,
                        );
                        results.add(result);
                      }

                      results.forEach((elem) {
                        print(elem["duration"]);
                        print(elem["id"]);
                        print(widget.sessions[0].id);
                        duration += elem["duration"] as int;
                      });
                      // userTests = allTests
                      //     .where(
                      //         (val) => val.userId == AppConstants.userModel!.id)
                      //     .toList()
                      //     .reversed
                      //     .toList();
                    }

                    return SmallText(
                      text: (duration / 60).toInt().toString(),
                      color: Colors.grey[500],
                      size: Dimensions.font32,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
