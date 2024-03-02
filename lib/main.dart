// In main.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home_page.dart'; // import all your pages
import 'setup_page.dart';
import 'solitaire_page.dart';
import 'image_credits_page.dart';

void main() {
  runApp(MyApp());
}

final _route = GoRouter(initialLocation: '/home', routes: [
  GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
  ),
  GoRoute(
    path: '/setup',
    builder: (context, state) => SetupPage(),
  ),
  GoRoute(
    path: '/image-credits',
    builder: (context, state) => ImageCreditsPage(),
  ),
  GoRoute(
    path: '/solitaire/:gameNumber/:numberOfSymbols/:deckSize',
    builder: (context, state) => SolitairePage(
      gameNumber: int.parse(state.pathParameters['gameNumber']!),
      numberOfSymbols: int.parse(state.pathParameters['numberOfSymbols']!),
      deckSize: double.parse(state.pathParameters['deckSize']!),
    ),
  ),
]);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'We Spot!',
      routerConfig: _route,
    );
  }
}
