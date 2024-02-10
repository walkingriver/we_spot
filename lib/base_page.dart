import 'package:flutter/material.dart';
import 'package:we_spot/themed_background_container.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final String title;
  final String currentRoute;

  BasePage(
      {required this.child, required this.title, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: currentRoute != '/home'
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context))
            : null,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text('New Game'),
              onTap: () {
                Navigator.pushNamed(context, '/setup');
              },
            ),
            ListTile(
              title: Text('Image Credits'),
              onTap: () {
                Navigator.pushNamed(context, '/image-credits');
              },
            ),
            // ... other ListTiles for navigation
          ],
        ),
      ),
      body: ThemedBackgroundContainer(
        child: child,
      ),
    );
  }
}
