import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mylastwords/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppleIcon extends StatelessWidget {
  final String? iconSrc;
  final void Function() press;
  const AppleIcon({
    Key? key,
    this.iconSrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return GestureDetector(
      onTap: press,
      child: Container(        
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(          
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc!,
          height: 25,
          width: 25,
        ),
      ),
    );
    }  
    return SizedBox();
  }
}
