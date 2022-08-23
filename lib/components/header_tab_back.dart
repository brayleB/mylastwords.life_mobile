import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/AlarmScreen/alarm_screen.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';

class HeaderTabBack extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundcolor;

  const HeaderTabBack({
    Key? key,
    this.backgroundcolor,
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
      elevation: 0,
      actions: [],
    );
  }
}
