To adapt your CSS for the dark and light themes from Ionic to Flutter, you'll need to handle theme-specific styling within your Flutter app's theme data and use conditional logic to set background images based on the theme. Flutter doesn't use CSS for styling but provides a rich set of widgets and properties to style your app.

Flutter handles dark and light themes using the `ThemeData` class, and you can specify different themes for dark and light modes. However, for dynamic theme-specific backgrounds in a single widget (like `ion-content.texture`), you would typically use a combination of `MediaQuery` and `Theme.of(context).brightness` to determine the current theme and then set the background accordingly.

Here's how you can adapt your CSS to Flutter:

### Step 1: Define the Assets

First, ensure your images are added to your Flutter project under an assets directory, and declare these assets in your `pubspec.yaml` file:

```yaml
flutter:
  assets:
    - assets/images/dark-wood.jpg
    - assets/images/light-wood.jpg
```

### Step 2: Apply Theme-Specific Backgrounds

For a widget that should display the background image, you can determine the current theme mode using `Theme.of(context).brightness` and set the background image accordingly. Here's an example using a `Container` widget to represent your `ion-content.texture`:

```dart
class ThemedBackgroundContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine if the theme is dark or light
    var brightness = Theme.of(context).brightness;
    String backgroundImage = brightness == Brightness.dark
        ? 'assets/images/dark-wood.jpg'
        : 'assets/images/light-wood.jpg';

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.contain,
          repeat: ImageRepeat.repeat,
        ),
      ),
      // Child widgets go here
    );
  }
}
```

### Using the ThemedBackgroundContainer

Whenever you need a widget with the themed background (like your `ion-content.texture`), you can use `ThemedBackgroundContainer` as the parent widget or as part of the background for your content.

### Note:

- Flutter does not directly use CSS variables like `--background`, so you need to manage theme-specific values within your Dart code.
- The `fit: BoxFit.contain` and `repeat: ImageRepeat.repeat` properties mimic the CSS `background-size: contain` and `background-repeat: repeat`.

By following these steps, you'll be able to achieve a similar effect to your Ionic app's CSS for handling light and dark theme-specific backgrounds in Flutter.

Adding the `ThemedBackgroundContainer` directly to your `BasePage` class would apply the theme-specific background across all pages that use `BasePage` as their template. This is a good approach if you want a consistent background for all such pages within your app.

Here's how you can integrate the `ThemedBackgroundContainer` within the `BasePage`:

1. **Wrap the `BasePage` Child in the `ThemedBackgroundContainer`**:

Modify the `BasePage` to include the `ThemedBackgroundContainer` as the root widget of the body. This ensures that the background is applied to all pages extending `BasePage`.

```dart
class BasePage extends StatelessWidget {
  final Widget child;
  final String title;
  final String currentRoute;

  BasePage({required this.child, required this.title, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: currentRoute != '/home'
            ? IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              )
            : null,
      ),
      body: ThemedBackgroundContainer(
        child: child, // Your original child widget now wrapped with the background
      ),
      // The rest of your BasePage layout...
    );
  }
}
```

2. **Define the `ThemedBackgroundContainer` Class**:

Ensure you've defined the `ThemedBackgroundContainer` class as previously described, which selects the background image based on the current theme.

```dart
class ThemedBackgroundContainer extends StatelessWidget {
  final Widget child;

  ThemedBackgroundContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    String backgroundImage = brightness == Brightness.dark
        ? 'assets/images/dark-wood.jpg'
        : 'assets/images/light-wood.jpg';

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.contain,
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: child,
    );
  }
}
```

By incorporating the `ThemedBackgroundContainer` into your `BasePage`, you achieve a consistent background theme across all pages using `BasePage`. This method provides a clean and centralized way to manage backgrounds, especially when dealing with theme changes (light/dark mode) across your app.

Remember, if any page requires a different background or no background, you'll need to adjust this approach accordingly, possibly by adding parameters to `BasePage` to control the background behavior.
