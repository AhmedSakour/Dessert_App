import 'package:flutter/material.dart';

class ItemSweet extends StatelessWidget {
  ItemSweet({
    super.key,
    required this.img,
    required this.colimg,
    required this.containerColor,
  });
  final String img;
  Color colimg = Colors.black;

  Color containerColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: containerColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Center(
          child: Image.asset(
            img,
            color: colimg,
          ),
        ),
      ),
    );
  }
}
