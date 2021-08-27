import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/utils/constants.dart';

class OfflineCard extends StatelessWidget {
  const OfflineCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error,color: Colors.white,size: 100,),
        SizedBox(height: 2,),
        Container(child: Text("You are offline",style: whiteBold.copyWith(fontSize: 20),)),
      ],
    ));
  }
}
