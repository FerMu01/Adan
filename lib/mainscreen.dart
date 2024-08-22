import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context);

    return const Scaffold(
      backgroundColor: Color(0xFF0221CD),
      body: ConstraintLayout(),
    );
  }
}

class ConstraintLayout extends StatelessWidget {
  const ConstraintLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      },
      child: ConstraintLayoutBuilder(
        builder: (context, layout) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: const Color(0xFF1844FC),
                  alignment: Alignment.center,
                ),
              ),
              const Positioned.fill(
                bottom: 1.0,
                child: InvisibleButton(),
              ),
              Positioned(
                top: layout.maxHeight * 0.28,
                left: layout.maxWidth * 0.1,
                right: layout.maxWidth * 0.1,
                child: Image.asset(
                  'assets/images/ADAN.png',
                  width: 400,
                  height: 401,
                ),
              ),
              Positioned(
                bottom: 0,
                left: layout.maxWidth * 0.0004,
                right: layout.maxWidth * 0.0005,
                child: Container(
                  width: 480,
                  height: 307,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: layout.maxHeight * 0.62,
                right: layout.maxWidth * 0.068,
                child: Image.asset(
                  'assets/images/AdanMain.png',
                  width: 173,
                  height: 267,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class InvisibleButton extends StatelessWidget {
  const InvisibleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Container(),
    );
  }
}

class ConstraintLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints layout) builder;

  const ConstraintLayoutBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(context, constraints);
      },
    );
  }
}
