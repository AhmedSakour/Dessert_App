import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constant/app_colors.dart';

class DeleteItemSweet extends StatelessWidget {
  const DeleteItemSweet({
    Key? key,
    required this.img,
    required this.price,
    required this.name,
    this.onpree,
  }) : super(key: key);
  final String img;
  final String price;
  final String name;
  final Function()? onpree;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 330,
      height: 130,
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(blurRadius: 3.0)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: img,
            errorWidget: (context, url, error) => Icon(Icons.error),
            placeholder: (context, url) => Center(
              child: SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator()),
            ),
            width: 100,
            height: 100,
          ),
          SizedBox(
            width: 30,
          ),
          SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: AppColor.mainColor,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '$price \$',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: onpree,
              icon: Icon(
                Icons.cancel_outlined,
                size: 30,
                color: AppColor.mainColor,
              ))
        ],
      ),
    );
  }
}
