import 'package:flutter/material.dart';
import 'package:weather_app/presentation/resources/assets_manager.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          //child: Image.asset(ImageAssets.meteors, fit: BoxFit.fill),
        )
      ],
    );
  }
}