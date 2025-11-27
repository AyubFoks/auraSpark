import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:video_player/video_player.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import flutter_dotenv
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg

Future<void> main() async {
  // Make main async
  await dotenv.load(fileName: ".env"); // Load the .env file
  runApp(const AuraSparkApp());
}

class AuraSparkApp extends StatelessWidget {
  const AuraSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuraSpark',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Outfit', // Set Outfit as the default font
      ),
      home: const QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String quote = "Loading...";
  String author = "";
  bool isLoading = false;
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  // Fetch quote from API
  Future<void> fetchQuote() async {
    final String apiKey = dotenv.env['API_KEY']!; // Access API key from .env

    setState(() {
      isLoading = true;
    });

    try {
      // API Ninjas free tier: random quotes only (no category filtering)
      final url = 'https://api.api-ninjas.com/v1/quotes';

      // Make HTTP GET request with API key in headers
      final response = await http.get(
        Uri.parse(url),
        headers: {'X-Api-Key': apiKey},
      );

      // Check if request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse JSON response - API Ninjas returns an array
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          setState(() {
            quote = data[0]['quote'];
            author = data[0]['author'];
            isLoading = false;
          });
        }
      } else {
        setState(() {
          quote = "Failed to load quote. Status: ${response.statusCode}";
          author = "";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        quote = "Error: $e";
        author = "";
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();

    // Fetch a quote when the app starts
    fetchQuote();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse('assets/background.mp4'),
    );
    try {
      await _videoController.initialize();
      await _videoController.setVolume(0.0);
      await _videoController.setLooping(true);

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
        // Defer playing the video until after the first frame.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _videoController.value.isInitialized) {
            _videoController.play();
          }
        });
      }
    } catch (e) {
      print("Error initializing video: $e");
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Video Background
          if (_isVideoInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            )
          else
            // Black background while video loads
            Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),

          // Dark overlay for better text readability
          Container(color: Colors.black.withOpacity(0.3)),

          // Quote Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Quote Display with Card Background
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                      ), // Max width for quotes box
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                            0.3,
                          ), // 30% transparency
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            if (isLoading)
                              const CircularProgressIndicator()
                            else ...[
                              Text(
                                '"$quote"',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                  fontWeight:
                                      FontWeight.bold, // Make quote bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '- $author',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.w300, // Make author light
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Custom Title Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Theme(
                  data: ThemeData(
                    iconTheme: IconThemeData(color: Colors.transparent),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/as_color.svg',
                    height: 40.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : fetchQuote,
        tooltip: 'New Quote',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
