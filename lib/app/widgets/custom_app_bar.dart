import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({required String title, super.key})
    : super(
        title: Text(title),
      );
}
