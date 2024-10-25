import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constant/app_colors.dart';

class ItemSweetVertical extends StatelessWidget {
  final String img;
  final String price;
  String titel;
  final String subtitle;
  bool isVisible = true;
  ItemSweetVertical(
      {super.key,
      required this.img,
      required this.price,
      required this.subtitle,
      required this.isVisible,
      required this.titel});

  @override
  Widget build(BuildContext context) {
    Color containerColor = Theme.of(context).scaffoldBackgroundColor;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          width: 180,
          height: 220,
          decoration: BoxDecoration(
            color: containerColor,
            boxShadow: [
              BoxShadow(
                color: isVisible
                    ? Colors.grey.withOpacity(0.5)
                    : AppColor.mainColor,
                spreadRadius: 2,
                blurRadius: 4,
                offset: isVisible ? Offset(0, 3) : Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 14),
                  child: CachedNetworkImage(
                    imageUrl: img,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    placeholder: (context, url) => Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator()),
                    ),
                    width: 90,
                    height: 90,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                titel,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColor.mainColor,
                    fontFamily: 'poppins'),
              ),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'poppins',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$price\$',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.mainColor,
                    fontSize: 12,
                    fontFamily: 'poppins'),
              ),
            ]),
          ),
        ),
        isVisible
            ? Container()
            : Positioned(
                top: 9,
                right: 9,
                child: Container(
                  width: 50,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(2),
                          bottomLeft: Radius.circular(40))),
                  child: Transform.rotate(
                    angle: 7,
                    child: Center(
                      child: Text(
                        'new',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'poppins'),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
