import 'package:flutter/material.dart';

import 'package:mylastwords/Screens/AboutScreen/Components/slide.dart';
import 'package:mylastwords/constants.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[                
        Text(
          slideList[index].title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
            color: txtColorDark,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
            style: TextStyle(
            fontSize: 22,
            color: txtColorDark,
          ),
        ),       
      ],
    );
  }
}