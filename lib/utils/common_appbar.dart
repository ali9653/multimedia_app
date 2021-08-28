import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'constants.dart';

PreferredSize commonAppbar(String title) {
  return PreferredSize(
    preferredSize: Size.fromHeight(56),
    child: AppBar(
      elevation: 2,
      brightness: Brightness.dark,
      backgroundColor: scaffoldColor,
      title: Text(
        title,
        style: whiteW500.copyWith(fontSize: 22),
      ),
    ),
  );
}
