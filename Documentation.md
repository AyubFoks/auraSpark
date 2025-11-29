# Documentation for AuraSpark

## 1. Title and Objectives

**Title:** AuraSpark

**Objective:**

My goal with AuraSpark was to create a simple, elegant multi-platform application that displays inspiring quotes. I wanted to offer a clean interface and a refreshing user experience that delivers a moment of motivation whenever you need it.

## 2. Technology

### Tech Choice

I chose to build AuraSpark using the **Flutter** framework and the **Dart** programming language.

### Why?

As a newcomer to mobile and multi-platform development, this project was a fantastic learning opportunity. My choice of Flutter was driven by a mix of learning goals and strategic advantages:

*   **AI-Assisted Learning:** I was new to the Flutter framework and the Dart language, so I used this project as a practical exercise. AI assistance was crucial in helping me learn and apply concepts, from basic widgets to asynchronous API calls.
*   **Multi-Platform Ambition:** A key goal of mine is to build apps that run on multiple platforms (mobile, web, and desktop). Flutter's "write once, deploy anywhere" capability was the main reason I chose it, as it aligns perfectly with my future projects.
*   **Beautiful and Performant UI:** I wanted a "clean interface and a refreshing user experience." Flutter excels at creating beautiful, custom user interfaces that perform smoothly, thanks to its widget-based architecture and direct rendering engine.
*   **Fast Development:** Features like Hot Reload allowed me to experiment and see changes in real-time, which was invaluable for quickly iterating on the app's design and feel.

## 3. System Requirements

### For Developers (to build and run the project)

* **Dart SDK:** `^3.10.1`
* **Flutter SDK:** A version compatible with Dart 3.10.1
* **IDE:** Android Studio or Visual Studio Code (with the Flutter plugin)
* **Git:** For version control

### For End-Users (to run the application)

* **iOS:** Version 13.0 or later
* **Android:** Version 5.0 (Lollipop, API 21) or later
* **Web App:** A modern web browser (e.g., Chrome, Firefox, Safari, Edge)

## 4. Installation & Setup Instructions

To get a local copy up and running, follow these simple steps.

### Prerequisites

Before you begin, ensure you have met the developer system requirements outlined above. Additionally, you will need an API key:

* **API Key:** This project uses the [API Ninjas Quotes API](https://api-ninjas.com/api/quotes). You will need to create a free account on their website to get an API key.

### Instructions

1. **Clone the Repository:**
    Open your terminal, navigate to your desired directory, and clone the project repository.

    ```sh
    git clone https://github.com/AyubFoks/auraSpark.git
    cd auraSpark
    ```

2. **Create Environment File:**
    In the root directory of the project, create a new file named `.env`. Add the API key you obtained from API Ninjas to this file.

    ```
    API_KEY=YOUR_API_NINJA_KEY
    ```

3. **Install Dependencies:**
    Navigate into the project directory in your terminal and run the following command to fetch all the required packages:

    ```sh
    flutter pub get
    ```

4. **Run the Application:**
    Connect a device, start an emulator, or select a web browser. Then, run the application with:

    ```sh
    flutter run
    ```

## 5. Minimal Working Example

Here is a minimal, self-contained Dart example that demonstrates the core logic for fetching a quote from the API Ninjas service. This function can be integrated into a Flutter widget to handle the data fetching.

In a real Flutter application, you would call this function from your widget (for example, in `initState` or in response to a button press) and then use the returned `Map` to update the UI by calling `setState`.

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

/// A minimal example of fetching a quote from the API Ninjas service.
///
/// In a real Flutter app, you would call this function and use the
/// returned map to update your widget's state via `setState`.
Future<Map<String, String>> getQuoteExample(String apiKey) async {
  final url = Uri.parse('https://api.api-ninjas.com/v1/quotes');
  try {
    final response = await http.get(
      url,
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        // Successfully fetched a quote.
        return {
          'quote': data[0]['quote'] ?? 'No quote found',
          'author': data[0]['author'] ?? 'Unknown author',
        };
      } else {
        return {'error': 'API returned an empty list.'};
      }
    } else {
      // Handle server errors.
      return {'error': 'Failed to load quote. Status code: ${response.statusCode}'};
    }
  } catch (e) {
    // Handle network or other errors.
    return {'error': 'An error occurred: $e'};
  }
}

/*
// Example usage (e.g., inside a Flutter widget's method):

final yourApiKey = 'YOUR_API_NINJA_KEY'; // Loaded from .env or elsewhere
final result = await getQuoteExample(yourApiKey);

if (result.containsKey('error')) {
  // Handle the error in your UI
  print(result['error']);
} else {
  // Update your state:
  // setState(() {
  //   _quote = result['quote'];
  //   _author = result['author'];
  // });
}
*/
```

## 6. Common Issues and Fixes

This section details some common issues encountered during development and how to resolve them.

### Issue 1: API Key is Null or Not Loaded

* **Symptom:** The app throws a `Null check operator used on a null value` error when trying to fetch a quote. The error points to the line where `dotenv.env['API_KEY']!` is used.
* **Resolution:** This happens when the `.env` file is not properly loaded before the app needs the key. I fixed this by ensuring two things:
    1. The `main` function in `lib/main.dart` is marked as `async` and `await dotenv.load(fileName: ".env");` is called before `runApp()`.
    2. The `.env` file is declared as an asset in `pubspec.yaml` so it gets bundled with the app.
* **Helpful Link:** [Stack Overflow: Flutter - How to use .env files](https://stackoverflow.com/questions/68952019/flutter-how-to-use-env-files)
* **Example AI Prompt:** "I'm using flutter_dotenv and my API key is null at runtime. My code is `dotenv.env['API_KEY']!`. I have the `.env` file in my root directory. What am I missing?"

### Issue 2: Video Background Doesn't Play on Web

* **Symptom:** The video background works on mobile emulators but shows a black screen or loading indicator indefinitely when running the app in a web browser.
* **Resolution:** Flutter's web build handles assets differently. The video file path needed to be adjusted for the web. Initially, I used `VideoPlayerController.asset()`, but for the web version to find the `background.mp4` file, I had to place it in the `web/assets/` directory and reference it from there. The path in the code became `Uri.parse('assets/background.mp4')`.
* **Helpful Link:** [Flutter Docs: Adding assets and images](https://docs.flutter.dev/ui/assets/assets-and-images)
* **Example AI Prompt:** "My Flutter video_player works on Android but not on the web. I'm using a local .mp4 file from my assets folder. How do I correctly set up video assets for Flutter web?"

### Issue 3: Custom Font 'Outfit' Is Not Applied

* **Symptom:** The app displays a default system font instead of the custom 'Outfit' font, even though the font files are in the `assets/fonts` folder.
* **Resolution:** The problem was a simple but easy-to-miss indentation error in `pubspec.yaml`. The `fonts` section must be correctly aligned under the `flutter` section. After fixing the indentation and running `flutter clean` followed by `flutter pub get`, the fonts loaded correctly.
* **Helpful Link:** [Flutter Docs: Use a custom font](https://docs.flutter.dev/ui/text/use-a-custom-font)
* **Example AI Prompt:** "I added a custom font to my `pubspec.yaml` and put the .ttf files in my assets folder. I set the `fontFamily` in my `ThemeData`, but the app is still using the default font. Can you show me the correct `pubspec.yaml` format for fonts?"

### Issue 4: "Failed to load quote" Message Appears

* **Symptom:** The app displays "Failed to load quote" instead of a quote from the API.
* **Resolution:** This is a general error that can have a few causes:
    1. **Invalid API Key:** The key in the `.env` file is incorrect or has expired.
    2. **No Internet Connection:** The device or browser cannot reach the internet.
    3. **API Service Down:** The API Ninjas service might be temporarily unavailable.
    I checked my internet connection first, then double-checked that the API key was copied correctly into the `.env` file.
* **Helpful Link:** [API Ninjas - My Account](https://api-ninjas.com/account) (To check API key status)
* **Example AI Prompt:** "My Flutter app is getting a 403 Forbidden or 401 Unauthorized error when making an HTTP request to an API, but it works in Postman. My code uses the `http` package and adds an `X-Api-Key` header. What could be wrong?"

### Issue 5: Video Autoplay is Blocked on Web Browsers

*   **Symptom:** The background video loads but does not start playing automatically on web browsers. It remains as a static image.
*   **Resolution:** Modern browsers block the automatic playing of videos that contain audio to improve user experience. AI helped me figure out that the standard workaround is to mute the video before playing it. The fix was to programmatically mute the `VideoPlayerController` by calling `_videoController.setVolume(0.0)` right before calling `_videoController.play()`.
*   **Helpful Link:** [Stack Overflow: Flutter video_player web autoplay](https://stackoverflow.com/questions/66328796/flutter-video-player-web-autoplay)
*   **Example AI Prompt:** "My Flutter video background won't autoplay in Chrome. The video loads but just sits on the first frame. How can I force a video to autoplay on web, and do I need to mute it?"

## 7. References

This section provides links to the official documentation and resources for the technologies, services, and packages used in the AuraSpark application.

* **Flutter Official Website:** [https://flutter.dev/](https://flutter.dev/)
* **Dart Programming Language:** [https://dart.dev/](https://dart.dev/)
* **API Ninjas Quotes API:** [https://api-ninjas.com/api/quotes](https://api-ninjas.com/api/quotes)
* **http package (pub.dev):** [https://pub.dev/packages/http](https://pub.dev/packages/http)
* **video_player package (pub.dev):** [https://pub.dev/packages/video_player](https://pub.dev/packages/video_player)
* **flutter_dotenv package (pub.dev):** [https://pub.dev/packages/flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
* **Outfit Font (Google Fonts):** [https://fonts.google.com/specimen/Outfit](https://fonts.google.com/specimen/Outfit)
