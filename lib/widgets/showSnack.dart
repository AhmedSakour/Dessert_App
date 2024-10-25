import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title, {required Color c}) {
  final snackBar = SnackBar(
    content: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: c,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(30),
    elevation: 30,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
