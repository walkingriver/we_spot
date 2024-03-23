import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:we_spot/services/shuffle_service.dart';
import 'base_page.dart'; // Import BasePage
import 'services/deck_service.dart'; // Import DeckService
import 'widgets/round_card.dart'; // Import RoundCard widget
import 'models/card_symbol.dart';
import 'models/deck.dart';
import 'constants/instructions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ShuffleService _shuffleService =
      ShuffleService(); // Assuming ShuffleService setup to work without arguments
  late DeckService _deckService;
  List<Deck> _decks = [];

  @override
  void initState() {
    super.initState();
    _deckService = DeckService(_shuffleService);
    _loadDecks();
  }

  void _loadDecks() {
    List<Deck> decks = [];
    decks.add(_deckService.buildDeck(4));
    decks.add(_deckService.buildDeck(6));
    decks.add(_deckService.buildDeck(8));
    decks.add(_deckService.buildDeck(12));

    setState(() {
      _decks = decks;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to determine the width and decide the grid layout
    var screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount =
        screenWidth < 600 ? 1 : 2; // 600px as a breakpoint for narrow devices

    return BasePage(
      title: 'Home',
      currentRoute: '/home',
      child: CustomScrollView(
        slivers: <Widget>[
          // Check if the decks are not empty to display the grid
          _decks.isNotEmpty
              ? SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var firstCardSymbols = _decks[index][0];
                      var firstCardSymbolsNotifier =
                          ValueNotifier(firstCardSymbols);
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent, // Temporary border color
                            width: 2, // Border width
                          ),
                        ),
                        child: RoundCard(
                          symbolsNotifier: firstCardSymbolsNotifier,
                          rollDirection: RollDirection.east,
                          onSymbolTap: (symbol) {
                            print('Symbol tapped: $symbol');
                          },
                        ),
                      );
                    },
                    childCount:
                        _decks.length, // Assuming there are only four decks
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                )
              : const SliverFillRemaining(
                  child: const Center(
                    child:
                        CircularProgressIndicator(), // Show loading indicator while decks are being prepared
                  ),
                ),
          // Add the Markdown description as a SliverToBoxAdapter to act as a single child scroll view
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: MarkdownBody(
                data: INSTRUCTIONS, // Your Markdown data here
              ),
            ),
          ),
        ],
      ),
    );
  }
}
