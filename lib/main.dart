// In main.dart
import 'package:flutter/material.dart';
import 'home_page.dart'; // import all your pages
import 'setup_page.dart';
import 'solitaire_page.dart';
import 'image_credits_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Spot!',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/setup': (context) => SetupPage(),
        '/solitaire': (context) => SolitairePage(),
        '/image-credits': (context) => ImageCreditsPage(),
      },
    );
  }
}
