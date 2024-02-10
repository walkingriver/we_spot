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
        // Determine the total available height
        double availableHeight = MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top;
        double availableWidth = MediaQuery.of(context).size.width;

        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: orientation == Orientation.portrait
                ? _buildPortrait(availableHeight)
                : _buildLandscape(availableWidth));
      }),
    );
  }

  Widget _buildPortrait(double availableHeight) {
    List<Widget> cards = _getTopTwoCards();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(height: availableHeight * 0.4, child: cards[0]),
        Container(height: availableHeight * 0.4, child: cards[1])
      ],
    );
  }

  _buildLandscape(double availableWidth) {
    List<Widget> cards = _getTopTwoCards();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(width: availableWidth * 0.4, child: cards[0]),
        Container(width: availableWidth * 0.4, child: cards[1])
      ],
    );
  }

  List<Widget> _getTopTwoCards() {
    List<Widget> cards = [
      topCard != null
          ? RoundCard(
              symbols: topCard!.map((e) => e.fileName).toList(),
              onSymbolTap: symbolTapped)
          : Container(),
      bottomCard != null
          ? RoundCard(
              symbols: bottomCard!.map((e) => e.fileName).toList(),
              onSymbolTap: symbolTapped)
          : Container(),
    ];
    return cards;
  }

  symbolTapped(symbol) {
    // We need to check the symbol tapped to see if it appears on both cards
    var found = topCard!.any((c) => c.fileName == symbol) &&
        bottomCard!.any((c) => c.fileName == symbol);

    if (found) {
      // This is a success, so we draw two more cards
      setState(() {
        currentDeckIndex -= 2;
        topCard = _deck[currentDeckIndex];
        bottomCard = _deck[currentDeckIndex - 1];
      });
    } else {
      // This is a failure, but we do nothing yet
    }
  }
}
