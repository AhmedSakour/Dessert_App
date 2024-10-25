import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.width,
      this.height,
      this.color,
      this.radius,
      this.data,
      this.sizeData,
      this.colorData});
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final String? data;
  final double? sizeData;
  final Color? colorData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius ?? 10)),
      child: Center(
          child: Text(
        data ?? '',
        style: TextStyle(
          fontSize: sizeData ?? 15,
          fontFamily: 'poppins',
          color: colorData ?? Colors.white,
        ),
      )),
    );
  }
}
