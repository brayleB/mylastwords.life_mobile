import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/AlarmScreen/alarm_screen.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';
import 'package:mylastwords/constants.dart';

class HeaderTab extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final void Function() press;
  final Color? backgroundcolor;
  final IconData? iconbtn;

  const HeaderTab({
    Key? key,
    this.title,
    this.backgroundcolor,
    this.iconbtn,
    required this.press,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: (){Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AlarmScreen()),(route) => false);},
          iconSize: 30,
        ),
      backgroundColor: backgroundcolor,
      centerTitle: false,
      title: Text(title!),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(iconbtn),
          onPressed: press,
          iconSize: 30,
        ),
      ],
    );
  }
}
