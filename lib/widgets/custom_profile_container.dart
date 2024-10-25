import 'package:flutter/material.dart';

class CustomContainerProfile extends StatelessWidget {
  CustomContainerProfile(
      {super.key,
      required this.nameField,
      this.valueField,
      this.darkValue = false,
      this.visiblevalueField = true,
      this.suffixIconVisible = false,
      this.changeTheme,
      required this.icon});
  final String nameField;
  final String? valueField;
  final IconData? icon;
  final bool visiblevalueField;
  final bool darkValue;
  final bool suffixIconVisible;
  Function(bool)? changeTheme;
  @override
  Widget build(BuildContext context) {
    Color containerColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      width: 330,
      height: 70,
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
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            visiblevalueField
                ? Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameField,
                          style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
                        ),
                        Text(
                          valueField ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
                        )
                      ],
                    ),
                  )
                : Text(
                    nameField,
                    style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
                  ),
            SizedBox(
              width: 90,
            ),
            suffixIconVisible
                ? Switch.adaptive(value: darkValue, onChanged: changeTheme)
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
