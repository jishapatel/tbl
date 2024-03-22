import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../base/constants/app_images.dart';
import '../../base/widgets/image_view.dart';

class InfoAlertDialog extends StatelessWidget {
  const InfoAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        //overflow: Overflow.visible,
        alignment: Alignment.topRight,
        children: [
          Container(
            height: 160,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 10),
              child: Column(
                children: [
                  Text(
                    'Sorry!!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  Text(
                    'Bookings are full for the day.Please choose another date.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 5.0,
            top: 5.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.white,
                child: ImageView(
                  image: AppImages.icClose,
                  imageType: ImageType.svg,
                ),
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
