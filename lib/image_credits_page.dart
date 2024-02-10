// In home_page.dart
import 'package:flutter/material.dart';
import 'base_page.dart';

class ImageCreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Image Credits',
      currentRoute: '/image-credits',
      child: Center(
        child: Text('Image Credits'), // Your page content
      ),
    );
  }
}
