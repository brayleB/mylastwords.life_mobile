import 'package:flutter/material.dart';
class Detail{
  String heading;
  String des;

  Detail({required this.heading,required this.des});
}

class AllDetails{
  String image;
  Detail details;

  AllDetails({required this.image,required this.details});
}