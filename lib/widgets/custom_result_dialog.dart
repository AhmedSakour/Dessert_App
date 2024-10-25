import 'package:flutter/material.dart';

void customResultDilogo(context,
    {required String data,
    required String dataButton,
    IconData? icon,
    double? iconSize,
    double height = 170,
    Function()? ontap,
    Color? colorIcon}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Container(
        color: Theme.of(context).colorScheme.background,
        width: 400,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                icon,
                color: colorIcon,
                size: iconSize,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                data,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'poppins'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                  onPressed: ontap,
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        color: colorIcon,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        dataButton,
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    ),
  );
}
