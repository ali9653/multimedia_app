import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/utils/screen_utils.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingPlaceholderVideo extends StatelessWidget {
  const LoadingPlaceholderVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: 10,
        itemBuilder: (context, index) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.grey.shade700,
        elevation: 10,
        child: Stack(
          children: [
            Container(
              height: ScreenUtils.deviceHeight(25),
            ),
            Positioned.fill(
              bottom: 3,
              right: 5,
              left: 5,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SkeletonAnimation(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  child: Container(
                    height: 20,
                    width: ScreenUtils.deviceWidth(100),
                    decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)), shape: BoxShape.rectangle, color: Colors.grey.shade900),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              right: 6,
              top: 6,
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  CupertinoIcons.heart,
                  size: 30,
                  color: Colors.grey.shade900,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
