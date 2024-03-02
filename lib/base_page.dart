import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            Link(
                uri: Uri.parse('/home'),
                builder: (context, followLink) => ListTile(
                      title: const Text('Home'),
                      onTap: followLink,
                    )),
            Link(
                uri: Uri.parse('/setup'),
                builder: (context, followLink) => ListTile(
                      title: const Text('New Game'),
                      onTap: followLink,
                    )),
            Link(
                uri: Uri.parse('/image-credits'),
                builder: (context, followLink) => ListTile(
                      title: const Text('Image Credits'),
                      onTap: followLink,
                    )),
          ],
        ),
      ),
      body: ThemedBackgroundContainer(
        child: child,
      ),
    );
  }
}
