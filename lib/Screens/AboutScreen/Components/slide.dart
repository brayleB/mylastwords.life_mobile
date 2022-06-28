import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: 'Welcome!',
    description: "Imagine you just died, no worries you felt nothing but your life on this Earth is finished. No matter how loved you were, life will still go on and the Earth will keep going round and round but you're gone.Just let that idea settle in and now I have 3 questions.",
  ), 
  Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: 'Just let that idea settle in and now I have 3 questions.',
    description: '',
  ),
  Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: 'What did you love about your life?',
    description: '',
  ),
  Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: 'Do you have any regrets?',
    description: '',
  ),
  Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: 'And if you were to be given a second chance, \nWhat Would You Change? ',
    description: '',
  ),
  Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: 'My Last Words',
    description: "You are given 60 seconds to live, what will you say?\nWill you regret not saying 'I Love You' to the persons you loved?\nAnd why do you have to wait till the very end?",
  ),
  Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: 'My Last Words',
    description: "Everyone deserve their Last Words to be made known to their love ones. Or how you feel at this every moment? Our own's pride and ego will not allow us to have the ability to share our emotions and our secrets. We all think we have the time and time to us is eternity. But expect the unexpected, when our time is up, we are gone.",
  ),
   Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: 'My Last Words',
    description: "My Last Words was founded to provide this special service to everyone upon their unexpected demise. We are focus on emotions, your every own form of your expression.",
  ),
  Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: "Subscribe now",
    description: "This app disguise as an alarm clock. Add your journals and pictures to it. It will be encrypt and only when you had stopped using the app we will give you a call to follow up with you. ",
  ),
  Slide(
    imageUrl: 'assets/images/alarm_clock.jpg',
    title: "",
    description: "In case you are un contactable after several attempts, we will extract your journals and follow up with your recipients. Only upon confirmation from them of your pre-mature demise then our management will be contacting them with your upmost last quotation.",
  ), 

];