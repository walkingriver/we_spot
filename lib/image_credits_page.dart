// Assuming BasePage, CardSymbol, and SYMBOLS are properly imported
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'base_page.dart';
import 'models/card_symbol.dart'; // Adjust the path as necessary

class ImageCreditsPage extends StatelessWidget {
  void openImageCredits(String url) async {
    // convert string url to Uri
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CardSymbol> allSymbols = SYMBOLS
        .map((symbol) => CardSymbol(
              emoji: symbol.emoji,
              fileName: symbol.fileName,
              referralUrl: '',
            ))
        .toList();

    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate crossAxisCount based on screen width. Adjust the division factor as needed.
    int crossAxisCount = screenWidth ~/ 100; // Example: for 100px per item

    return BasePage(
      title: 'Image Credits',
      currentRoute: '/image-credits',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total Images: ${allSymbols.length}',
              style: const TextStyle(
                fontSize: 64.0, // Adjust the size as needed
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2.0,
                        2.0), // Horizontal and vertical offset of the shadow
                    blurRadius: 3.0, // How much the shadow is blurred
                    color: Color.fromARGB(255, 0, 0, 0), // Shadow color
                  ),
                  // You can add more Shadow objects if you want multiple shadows
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // Dynamic cross axis count
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: allSymbols.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () =>
                        openImageCredits(allSymbols[index].referralUrl),
                    child: SvgPicture.asset(
                        'assets/symbols/${allSymbols[index].fileName}',
                        semanticsLabel:
                            'A vector image'), // Use semanticsLabel as needed
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
