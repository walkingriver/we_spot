import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:we_spot/models/card_symbol.dart';

enum RollDirection { east, west }

class RoundCard extends HookWidget {
  final ValueNotifier<List<CardSymbol>> symbolsNotifier;
  final Function(CardSymbol) onSymbolTap;
  final RollDirection rollDirection;

  const RoundCard(
      {Key? key,
      required this.symbolsNotifier,
      required this.onSymbolTap,
      required this.rollDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(milliseconds: 500));
    final animation = Tween<double>(
            begin: 0, end: rollDirection == RollDirection.west ? -1 : 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    final externalSymbolsNotifier = symbolsNotifier;
    final internalSymbolsNotifier =
        useState<List<CardSymbol>>(externalSymbolsNotifier.value);

    useEffect(() {
      listener() {
        controller.forward().then((_) {
          Future.delayed(Duration(milliseconds: 250), () {
            internalSymbolsNotifier.value = externalSymbolsNotifier.value;
            controller.reverse();
          });
        });
      }

      externalSymbolsNotifier.addListener(listener);
      return () {
        externalSymbolsNotifier.removeListener(listener);
      };
    }, [externalSymbolsNotifier]);

    List<CardSymbol> symbols = internalSymbolsNotifier.value;

    return LayoutBuilder(builder: (context, constraints) {
      double cardSize = math.min(constraints.maxWidth, constraints.maxHeight);

      return AnimatedBuilder(
          animation: controller,
          child: Center(
            child: Container(
              width: cardSize,
              height: cardSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Stack(
                children: symbols.asMap().entries.map((entry) {
                  int index = entry.key;
                  CardSymbol symbol = entry.value;

                  return PositionedSymbol(
                    symbol: symbol.emoji,
                    index: index,
                    totalCount: symbols.length,
                    onSymbolTap: () => onSymbolTap(symbol),
                    cardSize: cardSize,
                  );
                }).toList(),
              ),
            ),
          ),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                  animation.value * MediaQuery.of(context).size.width, 0),
              child: Transform.rotate(
                angle: animation.value * 2 * math.pi,
                child: child,
              ),
            );
          });
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
    // Generate a random rotation angle
    double randomRotation = math.Random().nextDouble() * 2 * math.pi;

    // Calculate the radius of the circle within which symbols will be placed
    double radius = cardSize / 2;
    double symbolSize = calculateSymbolSize(radius, totalCount);
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
        child: Transform.rotate(
          angle: randomRotation, // Apply random rotation
          child: Text(
            symbol,
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: symbolSize,
                fontWeight: FontWeight.w500),
          ),
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
