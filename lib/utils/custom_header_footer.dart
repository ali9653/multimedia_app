import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multimedia_app/utils/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget loadingIndicator() {
  return Lottie.asset("assets/images/loading_indicator.json", height: 40, width: 40, fit: BoxFit.cover, alignment: Alignment.center);
}

CustomFooter customFooter() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;

      if (mode == LoadStatus.idle) {
        body = Text(
          "",
          style: whiteW500.copyWith(fontSize: 16),
        );
      } else if (mode == LoadStatus.loading) {
        body = loadingIndicator();
      } else if (mode == LoadStatus.failed) {
        body = body = Text("Loading failed");
      } else if (mode == LoadStatus.canLoading) {
        body = Text("Release to load more");
      } else {
        body = Text("No more Data");
      }
      return Container(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}

CustomHeader customHeader() {
  return CustomHeader(
    builder: (context, mode) {
      return Container(alignment: Alignment.center, color: Colors.transparent, height: 55, child: loadingIndicator());
    },
  );
}
