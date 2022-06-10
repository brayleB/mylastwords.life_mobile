import 'package:flutter/material.dart';
import 'package:mylastwords/components/confirmation_dialogue.dart';
import 'package:mylastwords/components/header_tab.dart';
import 'package:mylastwords/components/header_tab_back.dart';
import 'package:mylastwords/constants.dart';

class ViewImage extends StatelessWidget {
  final String img;

  ViewImage({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderTab(
        backgroundcolor: headerBackgroundColor,
        title: '',
        iconbtn: Icons.delete_outline_rounded,
        press: () {
          showDialog(
              context: context,
              builder: (context) {
                return ConfirmationDialogue(
                  title: 'Confirmation',
                  subtitle: 'Do you really want to remove this image?',
                  press: () {},
                );
              });
        },
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  image: DecorationImage(
                      image: NetworkImage(img), fit: BoxFit.contain),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
