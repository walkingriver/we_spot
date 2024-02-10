import 'package:flutter/material.dart';
import 'base_page.dart'; // Import BasePage

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Home',
      currentRoute: '/home',
      child: Center(
        child: Text('Home Page Content'), // Your home page content
      ),
    );
  }
}
