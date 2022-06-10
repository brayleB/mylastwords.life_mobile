import 'package:flutter/material.dart';
import 'package:mylastwords/constants.dart';

class HeaderTabGallery extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final void Function() takePicture;
  final void Function() addPicture;
  final Color? backgroundcolor;

  const HeaderTabGallery({
    Key? key,
    this.title,
    this.backgroundcolor,
    required this.takePicture,
    required this.addPicture,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundcolor,
      centerTitle: false,
      title: Text(title!),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.camera_alt_outlined),
          onPressed: takePicture,
          iconSize: 25,
        ),
        IconButton(
          icon: Icon(Icons.image_outlined),
          onPressed: addPicture,
          iconSize: 26,
        ),
      ],
    );
  }
}
