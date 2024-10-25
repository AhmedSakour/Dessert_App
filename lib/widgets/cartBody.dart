import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constant/app_colors.dart';

class CardItem extends StatelessWidget {
  const CardItem(
      {super.key,
      required this.quantity,
      required this.image,
      required this.name,
      required this.onRemove,
      required this.total});
  final String quantity;
  final String name;
  final String image;
  final String total;
  final Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    Color containerColor = Theme.of(context).scaffoldBackgroundColor;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 330,
          height: 100,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            boxShadow: const [
              BoxShadow(blurRadius: 3.0),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: containerColor,
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                      child: Text(
                    quantity,
                  )),
                ),
                SizedBox(
                  width: 20,
                ),
                CachedNetworkImage(
                  imageUrl: image,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator()),
                  ),
                  width: 90,
                  height: 90,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 140,
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'poppins'),
                      ),
                    ),
                    Text(
                      '$total\$',
                      maxLines: 3,
                      style: TextStyle(fontSize: 18, fontFamily: 'poppins'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 296,
          top: -18,
          child: IconButton(
              onPressed: onRemove,
              icon: Icon(
                Icons.cancel,
                color: AppColor.mainColor,
              )),
        )
      ],
    );
  }
}
