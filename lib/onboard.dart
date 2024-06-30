import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_provider.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    description: demo_data[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    demo_data.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_pageIndex == demo_data.length - 1) {
                          authProvider.setLoggedIn(true);
                          await _completeOnboarding();
                          Navigator.pushReplacementNamed(context, '/mainscreen');
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF1844FC),
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1844FC) : const Color(0xFF1844FC).withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnBoard> demo_data = [
  OnBoard(
    image: "assets/images/ADANB.png",
    title: "ADAN",
    description: "Esta aplicación ha sido creada con la intención de informar, concientizar y sensibilizar al hombre. A través de videos, mensajes y música para la violencia contra la mujer.",
  ),
  OnBoard(
    image: "assets/images/intro01.png",
    title: "Galería De Videos",
    description: "Reproduce cortos, videos reflexivos y música para la concientización de la prevención de la violencia contra la mujer.",
  ),
  OnBoard(
    image: "assets/images/intro02.png",
    title: "Ley N° 348",
    description: "Se da a conocer la prioridad nacional de la prevención dela violencia contra las mujeres. ",
  ),
  OnBoard(
    image: "assets/images/intro03.png",
    title: "Desahógate",
    description: "Una de las ventanas de desahogo para escribir lo que sientes, además de recibir frases de escritores.",
  ),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'Oswald',
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
