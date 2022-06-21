import 'package:flutter/material.dart';
import 'package:mylastwords/constants.dart';

class HeaderTabAdd extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final void Function() saveFunc; 
  final Color? backgroundcolor;

  const HeaderTabAdd({
    Key? key,
    this.title,
    this.backgroundcolor,
    required this.saveFunc,
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
        TextButton(
          onPressed: saveFunc,
          child: Text(
            "Save",
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w400),
          ),
        ),                
      ],
    );
  }
}
