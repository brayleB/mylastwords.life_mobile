import 'package:flutter/material.dart';
import 'package:mylastwords/constants.dart';

class HeaderTabSave extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final void Function() saveFunc;
  final void Function()? delFunc;
  final Color? backgroundcolor;

  const HeaderTabSave({
    Key? key,
    this.title,
    this.backgroundcolor,
    required this.saveFunc,
    this.delFunc,
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
        
        TextButton(
          onPressed: delFunc,
          child: Text(
            "Delete",
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w400),
          ),
        ),             
      ],
    );
  }
}
