// In home_page.dart
import 'package:flutter/material.dart';

import 'base_page.dart';

class SolitairePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Solitaire',
      currentRoute: '/solitaire',
      child: Center(
        child: Text('Solitaire Page Content'), // Your page content
      ),
    );
  }
}
