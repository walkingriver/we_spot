import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundCard extends StatelessWidget {
  final List<String> symbols; // Assuming symbols are identified by file names
  final Function(String) onSymbolTap;

  RoundCard({Key? key, required this.symbols, required this.onSymbolTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double cardSize = math.min(constraints.maxWidth, constraints.maxHeight);

      return Center(
        child: Container(
          width: cardSize,
          height: cardSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Stack(
            children: symbols.asMap().entries.map((entry) {
              int index = entry.key;
              String symbol = entry.value;

              return PositionedSymbol(
                symbol: symbol,
                index: index,
                totalCount: symbols.length,
                onSymbolTap: () => onSymbolTap(symbol),
                cardSize: cardSize,
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}

class PositionedSymbol extends StatelessWidget {
  final String symbol;
  final int index;
  final int totalCount;
  final double
      cardSize; // The overall size of the card to calculate symbol positions
  final VoidCallback onSymbolTap;

  PositionedSymbol({
    Key? key,
    required this.symbol,
    required this.index,
    required this.totalCount,
    required this.cardSize,
    required this.onSymbolTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the radius of the circle within which symbols will be placed
    double radius = cardSize / 2;

    // Calculate optimal size for symbols based on the number of symbols and card radius
    double symbolSize = calculateSymbolSize(radius, totalCount);

    // Determine the placement radius to evenly distribute symbols within the circle
    double placementRadius =
        radius - symbolSize; // Adjust to ensure symbols fit within the card

    // Calculate angle and position for each symbol
    double angleIncrement = 2 * math.pi / totalCount;
    double angle = angleIncrement * index;
    double offsetX =
        math.cos(angle) * placementRadius + (cardSize / 2 - symbolSize / 2);
    double offsetY =
        math.sin(angle) * placementRadius + (cardSize / 2 - symbolSize / 2);

    return Positioned(
      left: offsetX,
      top: offsetY,
      child: GestureDetector(
        onTap: onSymbolTap,
        child: SvgPicture.asset(
          'assets/symbols/$symbol',
          width: symbolSize,
          height: symbolSize,
        ),
      ),
    );
  }

  double calculateSymbolSize(double radius, int symbolCount) {
    // Constants for padding and adjustments
    const double paddingFactor = 0.1; // Adjust for more padding
    const double areaAdjustmentFactor =
        0.7; // Adjust based on layout preference

    // Calculate the total circumference available for symbols
    double totalCircumference = 2 * math.pi * radius * areaAdjustmentFactor;

    // Estimate symbol size based on circumference for a single row of symbols
    double sizeBasedOnCircumference =
        totalCircumference / symbolCount - (paddingFactor * radius);

    // Calculate the area of the circle adjusted for padding
    double adjustedCircleArea =
        (math.pi * math.pow(radius * areaAdjustmentFactor, 2)) / symbolCount;

    // Estimate symbol size based on area, assuming square symbols to simplify
    double sizeBasedOnArea =
        math.sqrt(adjustedCircleArea) - (paddingFactor * radius);

    // Use the smaller of the two sizes to ensure fitting within the circle with padding
    double optimalSize = math.min(sizeBasedOnCircumference, sizeBasedOnArea);

    return optimalSize > 0 ? optimalSize : 0; // Ensure non-negative size
  }
}
