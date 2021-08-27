import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/utils/screen_utils.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingPlaceHolderImages extends StatelessWidget {
  const LoadingPlaceHolderImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: 21,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 3, mainAxisSpacing: 3, childAspectRatio: 4 / 5),
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey.shade700,
            elevation: 10,
            child: Stack(
              children: [
                Positioned.fill(
                  left: 6,
                  bottom: 6,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: SkeletonAnimation(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 12,
                        width: ScreenUtils.deviceWidth(30),
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)), shape: BoxShape.rectangle, color: Colors.grey.shade900),
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
