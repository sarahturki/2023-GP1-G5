import 'package:flutter/material.dart';
class CustomAppBar {
  static getAppBar(String title,context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarHeight: 126,
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 32),
      ),
    );
  }
}
