// In home_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'base_page.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final TextEditingController gameNumberController = TextEditingController();

  final validSymbols = [
    {'label': 'Easy - 13 cards, 4 symbols', 'value': 4},
    {'label': 'Medium - 31 cards, 6 symbols', 'value': 6},
    {'label': 'Hard - 57 cards, 8 symbols', 'value': 8},
    {'label': 'Extreme - 133 cards, 12 symbols', 'value': 12},
  ];
  // I'll deal with these later, after the basic game works
  // final deckSizes = [
  //   {'label': 'Full Deck', 'value': 1.0},
  //   {'label': '3/4 Deck', 'value': 0.75},
  //   // ... other deck sizes
  // ];

  int selectedNumberOfSymbols = 6;
  double selectedDeckSize = 1;
  int? gameNumber;

  @override
  void initState() {
    super.initState();
    // Initialize gameNumberController with a random value
    gameNumber = Random().nextInt(1 << 30);
    gameNumberController.text = gameNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'New Game',
      currentRoute: '/setup',
      child: SingleChildScrollView(
        child: Card(
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text("Configure a new game",
                    style: TextStyle(color: Colors.grey)),
              ),
              _buildGameNumberInput(),
              _buildSymbolsDropdown(),
              // _buildDeckSizeDropdown(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the solitaire page with the selected game settings
                    Navigator.pushNamed(context, '/solitaire', arguments: {
                      'gameNumber': gameNumber,
                      'numberOfSymbols': selectedNumberOfSymbols,
                      'deckSize': selectedDeckSize,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Start"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameNumberInput() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Game Number (optional)',
        hintText: 'Enter a number',
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          gameNumber = int.tryParse(value);
        });
      },
    );
  }

  Widget _buildSymbolsDropdown() {
    return DropdownButton<int>(
      value: selectedNumberOfSymbols,
      onChanged: (newValue) {
        setState(() {
          selectedNumberOfSymbols = newValue!;
        });
      },
      items: validSymbols.map((symbol) {
        return DropdownMenuItem<int>(
          value: symbol['value'] as int,
          child: Text(symbol['label'] as String),
        );
      }).toList(),
    );
  }

  // Widget _buildDeckSizeDropdown() {
  //   return DropdownButton<double>(
  //     value: selectedDeckSize,
  //     onChanged: (newValue) {
  //       setState(() {
  //         selectedDeckSize = newValue!;
  //       });
  //     },
  //     items: deckSizes.map((size) {
  //       return DropdownMenuItem<double>(
  //         value: size['value'] as double,
  //         child: Text(size['label'] as String),
  //       );
  //     }).toList(),
  //   );
  // }
}
