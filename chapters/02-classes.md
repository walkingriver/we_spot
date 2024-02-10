# Classes We Will Need

In a Flutter project, it's common to organize such model classes in a `models` directory within the `lib` folder. This helps keep your project structure clean and intuitive. Here are the `mkdir` and `touch` commands to create the appropriate directory and files:

First, navigate to the root of your Flutter project:

```bash
cd path/to/your/flutter_project
```

Then, create the `models` directory inside the `lib` folder:

```bash
mkdir -p lib/models
```

Now, create each file within the `models` directory:

```bash
touch lib/models/card_symbol.dart
touch lib/models/card.dart
touch lib/models/deck.dart
touch lib/models/deck_info.dart
touch lib/models/playing_card.dart
```

After running these commands, you'll have a `models` directory with five Dart files, each ready for you to define the classes as per the conversions from your TypeScript interfaces.

To convert these TypeScript interfaces to their equivalent in Dart, you'll create Dart classes. Dart doesn't have an 'interface' keyword like TypeScript; instead, you use abstract classes to achieve a similar effect. However, for simple data structures like the ones you've provided, Dart's standard classes are typically used.

Here's how you can convert each TypeScript interface to Dart, with each class in its own file:

1. **CardSymbol**

   File: `card_symbol.dart`

   ```dart
   class CardSymbol {
     final String fileName;
     final String referralUrl;

     CardSymbol({required this.fileName, required this.referralUrl});
   }
   ```

2. **Card**

   File: `card.dart`

   ```dart
   import 'card_symbol.dart';

   typedef Card = List<CardSymbol>;
   ```

3. **Deck**

   File: `deck.dart`

   ```dart
   import 'card.dart';

   typedef Deck = List<Card>;
   ```

4. **DeckInfo**

   File: `deck_info.dart`

   ```dart
   import 'deck.dart';

   class DeckInfo {
     final int symbolsPerCard;
     final String slug;
     final Deck deck;

     DeckInfo({required this.symbolsPerCard, required this.slug, required this.deck});
   }
   ```

5. **PlayingCard**

   File: `playing_card.dart`

   ```dart
   import 'card.dart';

   class PlayingCard {
     final String id;
     final Card symbols;

     PlayingCard({required this.id, required this.symbols});
   }
   ```

For each of these Dart classes, constructors are defined to initialize the properties. Dart requires the `required` keyword for named parameters that are non-nullable and do not have a default value. This ensures that all necessary data is provided when an instance of the class is created.

Remember to import the dependencies accordingly in your Flutter project. For instance, `playing_card.dart` should import `card.dart` since it uses the `Card` type.
