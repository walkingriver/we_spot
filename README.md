# We Spot: Ionic to Flutter Challenge

Welcome to the We Spot project! This initiative is about transforming an existing Ionic Angular application into Flutter, embracing the adventure as a public challenge. The goal is to explore the capabilities, performance, and developer experience offered by Flutter, comparing and contrasting it with those of Ionic Angular.

## Original Ionic Application

The current version of the We Spot app is deployed and accessible at [https://we-spot.netlify.app](https://we-spot.netlify.app). This Ionic Angular app serves as the baseline for our conversion challenge. You can review its source code and architecture by visiting the GitHub repository: [https://github.com/walkingriver/we-spot](https://github.com/walkingriver/we-spot).

## Why Flutter?

Choosing Flutter for this challenge is motivated by its growing popularity, its promise of smooth performance across platforms, and its rich set of widgets and tools. This transition represents not only a technical migration but also an opportunity to compare development experiences across different frameworks.

## Follow the Journey

I will be documenting the entire process, sharing insights, challenges, and achievements. For real-time updates, behind-the-scenes looks, and more, follow me on Twitter: [@WalkingRiver](https://twitter.com/WalkingRiver).

## How to Contribute or Follow Along

### Prerequisites

Before you can run the Flutter version of We Spot, ensure you have the following prerequisites installed on your system:

1. **Flutter SDK**: The core Flutter framework. Visit the [Flutter installation guide](https://flutter.dev/docs/get-started/install) for detailed instructions.
2. **Visual Studio Code (VS Code)**: A lightweight code editor with excellent Flutter support. Download from [here](https://code.visualstudio.com/).
3. **Flutter and Dart plugins for VS Code**: Essential for Flutter app development. Install these from the VS Code Extensions Marketplace.

### Cloning the Repository and Running the App

1. **Clone the Repository**: Open your terminal or command prompt and run one of the following commands to clone the Flutter version of the project.

   ```bash
   git clone https://github.com/walkingriver/we_spot.git

   git clone git@github.com:walkingriver/we_spot.git
   ```

   Replace `we-spot-flutter` with the correct repository if different.

2. **Open the Project in VS Code**: Launch VS Code, go to `File > Open Folder`, and select the cloned project directory.

3. **Get Dependencies**: Open the terminal in VS Code (`Terminal > New Terminal`) and run the following command to fetch the project's dependencies:

   ```bash
   flutter pub get
   ```

4. **Run the App**: With an emulator running or a device connected, execute the following command in the terminal:

   ```bash
   flutter run -d chrome
   ```

   This command compiles the app and launches it in Chrome, allowing you to see the latest progress. I will eventually run it on a device, but this will be sufficient for my initial challenge.

   I may tackle device emulation in the future as a stretch goal.

### Stay Updated

- **Star and Watch the GitHub Repo**: Stay up-to-date with the latest code changes and discussions.
- **Follow on Twitter**: Get insights, updates, and more on the conversion process.
- **Feedback and Contributions**: Whether you're an expert in Flutter, Ionic, or Angular, your feedback and contributions are welcome. Let's make this challenge a collaborative learning experience.

## What to Expect

Throughout this challenge, I aim to cover various aspects of the transition, including but not limited to:

- Comparing UI component libraries between Ionic and Flutter.
- Migrating services and state management solutions.
- Performance benchmarks and comparisons.
- Cross-platform capabilities and limitations.

Join me on this exciting journey from Ionic Angular to Flutter, and let's explore the future of cross-platform app development together.
