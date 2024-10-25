import 'package:flutter/material.dart';
import '../constant/app_colors.dart';

void customConfirmDilogo(
  context, {
  required String data,
  required String dataButton1,
  required String dataButton2,
  Function()? ontap1,
  Function()? ontap2,
  double height = 150,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      contentPadding: EdgeInsets.all(20),
      content: Container(
        color: Theme.of(context).colorScheme.background,
        width: 420,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                data,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'poppins'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                TextButton(
                    onPressed: ontap1,
                    child: Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColor.failureColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          dataButton1,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'poppins',
                              fontSize: 20),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: ontap2,
                    child: Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColor.successColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          dataButton2,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'poppins',
                              fontSize: 20),
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
