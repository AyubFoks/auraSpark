# AuraSpark

AuraSpark is a simple, elegant multi-platform application that displays inspiring quotes. With a clean interface and a refreshing user experience, it aims to deliver a moment of motivation whenever you need it.

![AuraSpark Screenshot](assets/images/as_color.png)

## Description

This project is a Flutter-based application that fetches random quotes from an API and presents them to the user. It features a refresh button to load new quotes and is designed to run on multiple platforms, including Android, iOS, web, and desktop.

## Features

* **Random Quotes:** Get inspired with a new quote every time.
* **Refresh On-the-Go:** Tap a button to fetch a new quote instantly.
* **Multi-Platform:** Runs on Android, iOS, Web, Windows, macOS, and Linux from a single codebase.
* **Sleek UI:** Aesthetically pleasing design with a video background and custom fonts.

## Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** [Dart](https://dart.dev/)
* **Packages:**
  * `http`: For making API requests.
  * `video_player`: For the animated background.
  * `flutter_dotenv`: For managing environment variables (API keys).

## Project Structure

The project follows the standard Flutter project structure.

```
aura_spark/
├── android/          # Android specific files
├── ios/              # iOS specific files
├── web/              # Web specific files
├── lib/
│   └── main.dart     # Main application code
├── assets/
│   ├── fonts/        # Custom fonts
│   └── images/       # Application assets
├── pubspec.yaml      # Project dependencies and configuration
└── README.md         # This file
```

## Installation

To get a local copy up and running, follow these simple steps.

### Prerequisites

* **Flutter SDK:** Make sure you have the Flutter SDK installed. For installation instructions, see the [official Flutter documentation](https://flutter.dev/docs/get-started/install).
* **API Key:** This project uses the [API Ninjas Quotes API](https://api-ninjas.com/api/quotes). You will need to create an account and get a free API key.

### Instructions

1. **Clone the repository:**

    ```sh
    git clone https://github.com/AyubFoks/auraSpark.git
    cd auraspark
    ```

2. **Create a `.env` file:**
    In the root of the project, create a new file named `.env` and add your API key to it:

    ```
    API_KEY=YOUR_API_NINJA_KEY
    ```

3. **Install dependencies:**
    Run the following command to get all the required packages:

    ```sh
    flutter pub get
    ```

4. **Run the application:**

    ```sh
    flutter run
    ```

    This command will run the app on your connected device, emulator, or browser.

## Usage

Once the application is running, you will see a random quote. To get a new quote, simply tap the "New Quote" button.

## Configuration

The primary configuration required is the API key for the quotes API. This is handled via the `.env` file as described in the installation section. No other configuration is required.

## Troubleshooting

* **Failed to load quote:**
  * Ensure you have a valid API key in your `.env` file.
  * Check your internet connection.
  * The API service might be temporarily down.
* **App does not build:**
  * Run `flutter doctor` to check for any issues with your Flutter installation.
  * Ensure all dependencies are correctly installed by running `flutter pub get`.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

---
*Copyright © 2025 Ayub Karanja | All rights reserved.*
