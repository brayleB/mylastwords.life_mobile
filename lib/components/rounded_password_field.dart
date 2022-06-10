import 'package:flutter/material.dart';
import 'package:mylastwords/components/text_field_container.dart';
import 'package:mylastwords/constants.dart';


class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final TextEditingController controller;
  const RoundedPasswordField({
    required this.hintText,
    required this.controller,
    required this.onChanged, 
    Key? key,
  }) : super(key: key);

  @override
  RoundedPasswordFieldState createState() => RoundedPasswordFieldState();
}

class RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool? showPass;
  

  @override
  void initState() {
  showPass = false;
    super.initState();
  }
 

   

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        obscureText: !showPass!,  
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(       
          icon: Icon(
            Icons.lock_outline,
            color: kPrimaryColor,
          ),
             hintText: widget.hintText,
          suffixIcon: IconButton(icon: Icon(
            showPass! ? 
            Icons.visibility_outlined :
            Icons.visibility_off_outlined,
            color: kPrimaryColor,
          ), onPressed: () { setState(() {
                   showPass = !showPass!;
               });},),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
