import 'package:flutter/material.dart';

class ThemedBackgroundContainer extends StatelessWidget {
  final Widget child;

  const ThemedBackgroundContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    // Determine if the theme is dark or light
    var brightness = Theme.of(context).brightness;
    String backgroundImage = brightness == Brightness.dark
        ? 'assets/images/dark-wood.jpg'
        : 'assets/images/light-wood.jpg';

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
          ),
        ),
        // Child widgets go here
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Container(
              color: Colors.transparent,
            )),
            Align(
              alignment: Alignment.center,
              child: child,
            )
          ],
        ));
  }
}
