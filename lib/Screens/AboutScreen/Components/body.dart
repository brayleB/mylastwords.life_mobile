// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/AboutScreen/Components/detail.dart';
import 'package:mylastwords/components/header_tab_back.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/constants.dart';
import 'package:just_audio/just_audio.dart';

final details = [
  AllDetails(
    image: "assets/aboutUsImages/about1.jpeg",
    details: Detail(heading: "Welcome!", des: "Imagine you just died, no worries you felt nothing but your life on this Earth is finished. No matter how loved you were, life will still go on and the Earth will keep going round and round but you're gone."),
  ),
  AllDetails(
    image: "assets/aboutUsImages/about2.jpeg",
    details: Detail(heading: "Just let that idea settle in and now I have 3 questions.", des: ""),
  ),
  AllDetails(
    image: "assets/aboutUsImages/about3.jpeg",
    details: Detail(heading: "What did you love about your life?", des: ""),
  ),
  AllDetails(
    image: "assets/aboutUsImages/about4.jpeg",
    details: Detail(heading: "Do you have any regrets?", des: ""),
  ),
  AllDetails(
    image: "assets/aboutUsImages/about5.jpeg",
    details: Detail(heading: "And if you were to be given a second chance, \nWhat Would You Change?", des: ""),
  ),
  AllDetails(
    image: "assets/aboutUsImages/about6.jpeg",
    details: Detail(heading: "", des: "You are given 60 seconds to live, what will you say?\nWill you regret not saying 'I Love You' to the persons you loved?\nAnd why do you have to wait till the very end?"),
  ),
  AllDetails(
    image: "assets/aboutUsImages/about7.jpeg",
    details: Detail(heading: "", des: "Everyone deserve their Last Words to be made known to their love ones. Or how you feel at this every moment? Our own's pride and ego will not allow us to have the ability to share our emotions and our secrets. We all think we have the time and time to us is eternity."),
  ),
  AllDetails(
    image: "assets/aboutUsImages/about8.jpeg",
    details: Detail(heading: "", des: "My Last Words was founded to provide this special service to everyone upon their unexpected demise. We are focus on emotions, your every own form of your expression."),
  ),
  AllDetails(
    image: "assets/aboutUsImages/about9.jpeg",
    details: Detail(heading: "My Last Words", des: "This app disguise as an alarm clock. Add your journals and pictures to it. It will be encrypt and only when you had stopped using the app we will give you a call to follow up with you."),
  ),
  AllDetails(
    image: "assets/aboutUsImages/about10.jpeg",
    details: Detail(heading: "My Last Words", des: "In case you are un contactable after several attempts, we will extract your journals and follow up with your recipients. Only upon confirmation from them of your pre-mature demise then our management will be contacting them with your upmost last quotation."),
  ),
];
final colorList = [
  Colors.green.shade200,
  Colors.pink.shade200,
  Colors.blue.shade100,
  Colors.deepPurple.shade100,
  Colors.green.shade200,
  Colors.pink.shade200,
  Colors.blue.shade100,
  Colors.deepPurple.shade100,
  Colors.green.shade200,
  Colors.pink.shade200,
];

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PageController? _controller;
  int currentPage = 0;
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.8,
    );    
  }

   @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: HeaderTabBack(
        backgroundcolor: headerBackgroundColor ),
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(microseconds: 500),
            color: lightBackground,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: size.height  * 0.5,
                child: PageView.builder(
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return item(index);
                  },
                  itemCount: details.length,
                  controller: _controller,
                  pageSnapping: true,
                  onPageChanged: _onPageChange,
                ),
              ),
              _details(currentPage),           
            ],
          ),
        ],
      ),
    );
  }

  Widget item(index) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        double value = 1;
        if (_controller!.position.haveDimensions) {
          value = _controller!.page! - index;
          value = (1 - value.abs() * 0.5);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn.transform(value) * 500,
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              child: Material(
                color: headerBackgroundColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2.0, right: 2.0, bottom: 2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Container(                    
                      child: Image.asset(
                        details[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height:
                  Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                      500,
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      details[index].image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _details(index) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        double value = 1;
        if (_controller!.position.haveDimensions) {
          value = _controller!.page! - index;
          value = (1 - value.abs() * 0.5);
        }

        return Expanded(
          child: Transform.translate(
            offset: Offset(0, 500 - (value * 500)),
            child: Opacity(
              opacity: value,
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      details[index].details.heading,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      details[index].details.des,
                      style: TextStyle(fontSize: 18.0),textAlign: TextAlign.center,
                    ),                                      
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _onPageChange(int index) {
    setState(() {
      print("CurrentIndex => $index");
      currentPage = index;
    });
  }
}