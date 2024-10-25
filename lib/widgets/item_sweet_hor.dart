import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constant/app_colors.dart';

class ItemSweetHorizintal extends StatelessWidget {
  final String img;
  final String price;
  final String titel;
  final String subtitle;
  const ItemSweetHorizintal(
      {super.key,
      required this.img,
      required this.price,
      required this.subtitle,
      required this.titel});

  @override
  Widget build(BuildContext context) {
    Color containerColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      decoration: BoxDecoration(
        color: containerColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: img,
                errorWidget: (context, url, error) => Icon(Icons.error),
                placeholder: (context, url) => Center(
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator()),
                ),
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titel,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.mainColor,
                          fontSize: 15,
                          fontFamily: 'poppins'),
                    ),
                    Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: 'poppins'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$price\$',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.mainColor,
                          fontSize: 15,
                          fontFamily: 'poppins'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
