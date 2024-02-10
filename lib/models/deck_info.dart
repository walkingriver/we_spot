import 'deck.dart';

class DeckInfo {
  final int symbolsPerCard;
  final String slug;
  final Deck deck;

  DeckInfo(
      {required this.symbolsPerCard, required this.slug, required this.deck});
}
