// In home_page.dart
import 'package:flutter/material.dart';

import 'base_page.dart';
import 'models/card_symbol.dart';
import 'models/deck.dart';
import 'services/deck_service.dart';
import 'services/shuffle_service.dart';
import 'widgets/round_card.dart';

class SolitairePage extends StatefulWidget {
  @override
  _SolitairePageState createState() => _SolitairePageState();
}

class _SolitairePageState extends State<SolitairePage> {
  late ShuffleService _shuffleService;
  late DeckService _deckService;
  Deck _deck = [];

  // I need to get the arguments passed to this page
  int gameNumber = 0;
  int numberOfSymbols = 6;
  double deckSize = 1.0;

  // I need to keep track of the deck and the two cards on the table
  int currentDeckIndex = 0;
  List<CardSymbol>? topCard;
  List<CardSymbol>? bottomCard;

  // Let's keep a running total of the time spent in the game

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _retrieveRouteArguments());

    _shuffleService = ShuffleService();
  }

  void _retrieveRouteArguments() {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
            {};

    setState(() {
      gameNumber = args['gameNumber'] ?? 0;
      numberOfSymbols = args['numberOfSymbols'] ?? 6;
      deckSize = args['deckSize'] ?? 1.0;
      _shuffleService.seed(gameNumber);
      _deckService = DeckService(_shuffleService);
      _deck = _deckService.buildDeck(numberOfSymbols);
      currentDeckIndex = _deck.length - 1;
      topCard = _deck[currentDeckIndex];
      bottomCard = _deck[currentDeckIndex - 1];
    });
  }

  Widget build(BuildContext context) {
    return BasePage(
      title: 'Solitaire',
      currentRoute: '/solitaire',
      child: OrientationBuilder(builder: (context, orientation) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: orientation == Orientation.portrait
                ? _buildPortrait()
                : _buildLandscape());
      }),
    );
  }

  Widget _buildPortrait() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[],
    );
  }

  _buildLandscape() {}
}
