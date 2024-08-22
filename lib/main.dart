import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_provider.dart';
import 'onboard.dart';
import 'mainscreen.dart';
import 'second_screen.dart';
import 'third_screen.dart';
import 'fourth_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> _checkOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingComplete') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkOnboardingComplete(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final showOnboarding = !snapshot.data!;
          return MaterialApp(
            title: 'Demo',
            home: showOnboarding ? const OnBordingScreen() : const MainScreen(),
            routes: {
              '/mainscreen': (context) => const MainScreen(),
              '/homepage': (context) => const MyHomePage(),
            },
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Image.asset(
              'assets/images/ADANB.png',
              fit: BoxFit.contain,
              width: 110,
              height: 110,
            ),
          ),
          Image.asset(
            'assets/images/AdanMainMenu.png',
            width: 295,
            height: 295,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF1844FC)),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  icon: const Icon(Icons.video_camera_back_sharp),
                  label: const Text('Galería'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FourthScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF1844FC)),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  icon: const Icon(Icons.article_sharp),
                  label: const Text('Ley 348'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ThirdScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF1844FC)),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  icon: const Icon(Icons.sentiment_very_dissatisfied),
                  label: const Text('Desahogate'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
