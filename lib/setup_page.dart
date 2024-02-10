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
  final deckSizes = [
    {'label': 'Full Deck', 'value': 1.0},
    {'label': '3/4 Deck', 'value': 0.75},
    // ... other deck sizes
  ];

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
              ListTile(
                title: Text("Configure a new game",
                    style: TextStyle(color: Colors.grey)),
              ),
              _buildGameNumberInput(),
              _buildSymbolsDropdown(),
              _buildDeckSizeDropdown(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle navigation and pass parameters if needed
                  },
                  child: Text("Start"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // set the background color
                  ),
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
      decoration: InputDecoration(
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

  Widget _buildDeckSizeDropdown() {
    return DropdownButton<double>(
      value: selectedDeckSize,
      onChanged: (newValue) {
        setState(() {
          selectedDeckSize = newValue!;
        });
      },
      items: deckSizes.map((size) {
        return DropdownMenuItem<double>(
          value: size['value'] as double,
          child: Text(size['label'] as String),
        );
      }).toList(),
    );
  }
}
