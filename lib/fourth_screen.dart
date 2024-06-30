import 'package:flutter/material.dart';
import 'main.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  runApp(const FourthScreen());
}

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              icon: Image.asset(
                'assets/images/ADANB.png', // Ruta de la imagen en los assets
                width: 82, // Ancho de la imagen
                height: 82, // Alto de la imagen
              ),
            ),
          ],
          title: const Text('Ley N°348'),
        ),
        body: Center(
          child: SizedBox(
            width: 310,
            child: ListView(
              children: const [
                VideoContainerItem(
                  videoPath: 'assets/videos/ley01.mp4',
                  thumbnailPath: 'assets/images/ley01.png',
                  text: 'Objetivo y Finalidad',
                  width: 300,
                ),
                VideoContainerItem(
                  videoPath: 'assets/videos/ley02.mp4',
                  thumbnailPath: 'assets/images/ley02.png',
                  text: 'Prevenciones',
                  width: 300,
                ),
                VideoContainerItem(
                  videoPath: 'assets/videos/ley03.mp4',
                  thumbnailPath: 'assets/images/ley03.png',
                  text: 'Sanciones',
                  width: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoContainerItem extends StatelessWidget {
  final String videoPath;
  final String thumbnailPath;
  final String text;
  final double width;

  const VideoContainerItem({
    super.key,
    required this.videoPath,
    required this.thumbnailPath,
    required this.text,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(videoPath: videoPath),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage(thumbnailPath),
              height: 160,
              width: width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Oswald', // Fuente Oswald
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  const VideoPlayerScreen({super.key, required this.videoPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath);

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: false,
      allowPlaybackSpeedChanging: false,
      allowedScreenSleep: false,
      showControls: true,
      fullScreenByDefault: true,
      placeholder: Container(
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
