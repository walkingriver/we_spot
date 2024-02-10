import '../models/card.dart';
import '../models/dobble_cards.dart';
import '../models/card_symbol.dart';
import '../models/deck.dart';
import 'shuffle_service.dart';

class DeckService {
  final ShuffleService shuffleService;
  List<CardSymbol> shuffledSymbols = [];

  // Constructor for dependency injection
  DeckService(this.shuffleService);

  /// Builds a deck of cards based on the number of cards.
  /// Shuffles the symbols and then constructs each card based on DOBBLE definitions.
  /// Throws an error if there is no predefined deck for the specified number of cards.
  Deck buildDeck(int numberOfCards, {int slug = 0}) {
    // Seed the shuffle service if the slug is not 0
    if (slug != 0) {
      shuffleService.seed(slug);
    }

    shuffledSymbols = shuffleService.shuffle(SYMBOLS);

    final rawCards = DOBBLE[numberOfCards];

    if (rawCards == null) {
      throw Exception('There is no deck of size $numberOfCards');
    }

    var deck = rawCards.map((card) => buildCard(card)).toList();
    return shuffleService.shuffle(deck);
  }

  /// Constructs a card from symbol indices, shuffling the symbols on the card.
  Card buildCard(List<int> symbols) {
    var card =
        symbols.map((cardNumber) => shuffledSymbols[cardNumber - 1]).toList();
    return shuffleService.shuffle(card);
  }
}
