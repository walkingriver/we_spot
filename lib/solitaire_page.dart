// In home_page.dart
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';
import 'models/card_symbol.dart';
import 'models/deck.dart';
import 'services/deck_service.dart';
import 'services/shuffle_service.dart';
import 'widgets/round_card.dart';
import 'widgets/round_card.dart';

enum Sounds { right, wrong, gameStart, gameOver }

class SolitairePage extends StatefulWidget {
  @override
  _SolitairePageState createState() => _SolitairePageState();

  const SolitairePage(
      {super.key,
      required int gameNumber,
      required int numberOfSymbols,
      required double deckSize});
}

class _SolitairePageState extends State<SolitairePage> {
  late ShuffleService _shuffleService;
  late DeckService _deckService;
  Deck _deck = [];

  // I need to get the arguments passed to this page
  int gameNumber = 0;
  int numberOfSymbols = 6;
  double deckSize = 1.0;

  final topCardSymbolsNotifier = ValueNotifier<List<CardSymbol>>([]);
  final bottomCardSymbolsNotifier = ValueNotifier<List<CardSymbol>>([]);

  int currentDeckIndex = 0;

  RoundCard? topCard;
  RoundCard? bottomCard;

  // Let's keep a running total of the time spent in the game

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _retrieveRouteArguments());

    // topCard = RoundCard(
    //     symbolsNotifier: topCardSymbolsNotifier,
    //     onSymbolTap: symbolTapped,
    //     rollDirection: RollDirection.west);
    // bottomCard = RoundCard(
    //     symbolsNotifier: bottomCardSymbolsNotifier,
    //     onSymbolTap: symbolTapped,
    //     rollDirection: RollDirection.east);

    _shuffleService = ShuffleService();
  }

  void _retrieveRouteArguments() {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
            {};

    setState(() {
      gameNumber = int.parse(args['gameNumber']);
      numberOfSymbols = int.parse(args['numberOfSymbols']);
      deckSize = double.parse(args['deckSize']);
      _shuffleService.seed(gameNumber);
      _deckService = DeckService(_shuffleService);
      _deck = _deckService.buildDeck(numberOfSymbols);
      currentDeckIndex = _deck.length - 1;

      // Set up the deck
      var currentTopCard = _deck[currentDeckIndex];
      var currentBottomCard = _deck[currentDeckIndex - 1];
      topCardSymbolsNotifier.value = currentTopCard;
      bottomCardSymbolsNotifier.value = currentBottomCard;
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
    topCard = RoundCard(
        symbolsNotifier: topCardSymbolsNotifier,
        onSymbolTap: symbolTapped,
        rollDirection: RollDirection.west);
    bottomCard = RoundCard(
        symbolsNotifier: bottomCardSymbolsNotifier,
        onSymbolTap: symbolTapped,
        rollDirection: RollDirection.east);

    return [topCard!, bottomCard!];
  }

  symbolTapped(CardSymbol symbol) async {
    // We need to check the symbol tapped to see if it appears on both cards
    var found = topCardSymbolsNotifier.value
            .any((c) => c.fileName == symbol.fileName) &&
        bottomCardSymbolsNotifier.value
            .any((c) => c.fileName == symbol.fileName);

    if (found) {
      await playAlertSound(Sounds.right);
      // This is a success, so we draw two more cards
      var index = currentDeckIndex - 2;

      if (index < 2) {
        // We are out of cards - game over
        print('Game over!');
        playAlertSound(Sounds.gameOver);
        // Navigate to a [future] game over page
      } else {
        setState(() {
          currentDeckIndex -= 2;
          var currentTopCard = _deck[currentDeckIndex];
          var currentBottomCard = _deck[currentDeckIndex - 1];
          topCardSymbolsNotifier.value = currentTopCard;
          bottomCardSymbolsNotifier.value = currentBottomCard;
        });
      }
    } else {
      // This is a failure, but we do nothing yet
      print('Not a match');

      // Play a sound and vibrate
      await playAlertSound(Sounds.wrong);
    }
  }

  Future playAlertSound(Sounds sound) async {
    const wrongSounds = [
      'cartoon-jump-6462.mp3',
      'failure-drum-sound-effect-2-7184.mp3',
      'kick-tech-5825.mp3',
      'stop-13692.mp3',
      'wrong-buzzer-6268.mp3'
          'start-13691.mp3',
    ];

    const rightSounds = [
      'collectcoin-6075.mp3',
    ];

    const startGameSound = [
      'start-computeraif-14572.mp3',
    ];

    const gameOverSound = [
      'game-over-arcade-6435.mp3',
    ];

    final player = AudioPlayer();

    var soundToPlay = '';

    switch (sound) {
      case Sounds.wrong:
        // Pick a random wrong sound
        soundToPlay = wrongSounds[Random().nextInt(wrongSounds.length)];
        break;

      case Sounds.right:
        // Pick a random right sound
        soundToPlay = rightSounds[Random().nextInt(rightSounds.length)];
        break;

      case Sounds.gameOver:
        // Pick a random game over sound
        soundToPlay = gameOverSound[Random().nextInt(gameOverSound.length)];
        break;
      case Sounds.gameStart:
        soundToPlay = startGameSound[Random().nextInt(startGameSound.length)];
        break;
    }

    return player.play(AssetSource('sounds/$soundToPlay'));
  }

  void vibratePhone() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }
  }
}
