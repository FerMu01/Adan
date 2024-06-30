import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart'; // Asegúrate de importar main.dart

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showControls = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: const Text(
          'Galería',
          style: TextStyle(
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.movie_creation_rounded),
              text: 'Cortos',
            ),
            Tab(
              icon: Icon(Icons.video_camera_front_rounded),
              text: 'Reflexiones',
            ),
            Tab(
              icon: Icon(Icons.my_library_music_rounded),
              text: 'Música',
            ),
          ],
          indicatorColor: const Color(0xFF1844FC),
          labelColor: const Color(0xFF1844FC),
          labelStyle: const TextStyle(
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
        },
        child: TabBarView(
          controller: _tabController,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: const [
                  VideoContainerItem(
                    videoPath: 'assets/videos/corto01.mp4',
                    thumbnailPath: 'assets/images/corto01.png',
                    text: '¡El Cómo Es! ',
                    width: 310,
                    imageHeight: 170,
                    imageWidth: 10,
                  ),
                  VideoContainerItem(
                    videoPath: 'assets/videos/corto02.mp4',
                    thumbnailPath: 'assets/images/corto02.png',
                    text: '¡El Cómo Debería Ser!',
                    width: 310,
                    imageHeight: 170,
                    imageWidth: 310,
                  ),
                  VideoContainerItem(
                    videoPath: 'assets/videos/corto03.mp4',
                    thumbnailPath: 'assets/images/corto03.png',
                    text: 'Superación',
                    width: 310,
                    imageHeight: 170,
                    imageWidth: 310,
                  ),
                  VideoContainerItem(
                    videoPath: 'assets/videos/corto04.mp4',
                    thumbnailPath: 'assets/images/corto04.png',
                    text: 'Comunicación Afectiva',
                    width: 310,
                    imageHeight: 170,
                    imageWidth: 310,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: const [
                  VideoContainerItem(
                    videoPath: 'assets/videos/reflexion01.mp4',
                    thumbnailPath: 'assets/images/reflexion01.png',
                    text: 'Un Mensaje Para Ti',
                    width: 310,
                    imageHeight: 170,
                    imageWidth: 310,
                  ),
                  VideoContainerItem(
                    videoPath: 'assets/videos/reflexion02.mp4',
                    thumbnailPath: 'assets/images/reflexion02.png',
                    text: 'Recuerda',
                    width: 310,
                    imageHeight: 170,
                    imageWidth: 310,
                  ),
                  VideoContainerItem(
                    videoPath: 'assets/videos/reflexion03.mp4',
                    thumbnailPath: 'assets/images/reflexion03.png',
                    text: 'El Alcohol',
                    width: 310,
                    imageHeight: 170,
                    imageWidth: 310,
                  ),
                  VideoContainerItem(
                    videoPath: 'assets/videos/reflexion04.mp4',
                    thumbnailPath: 'assets/images/reflexion04.png',
                    text: 'Los Dos Lobos',
                    width: 310,
                    imageHeight: 170,
                    imageWidth: 310,
                  ),
                  VideoContainerItem(
                    videoPath: 'assets/videos/reflexion05.mp4',
                    thumbnailPath: 'assets/images/reflexion05.png',
                    text: 'Sigue Adelante',
                    width: 310,
                    imageHeight: 170,
                    imageWidth: 310,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: const [
                  VideoContainerItem(
                    videoPath: 'assets/videos/musica01.mp4',
                    thumbnailPath: 'assets/images/musica01.png',
                    text: 'Asombroso',
                    width: 310,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class VideoContainerItem extends StatefulWidget {
  final String videoPath;
  final String thumbnailPath;
  final String text;
  final double width;
  final double imageHeight;
  final double imageWidth;

  const VideoContainerItem({
    Key? key,
    required this.videoPath,
    required this.thumbnailPath,
    required this.text,
    required this.width,
    this.imageHeight = 160,
    this.imageWidth = 160,
  }) : super(key: key);

  @override
  _VideoContainerItemState createState() => _VideoContainerItemState();
}

class _VideoContainerItemState extends State<VideoContainerItem> {
  late int viewCount;

  @override
  void initState() {
    super.initState();
    _loadViewCount();
  }

  Future<void> _loadViewCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      viewCount = prefs.getInt(widget.videoPath) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final newViewCount = viewCount + 1;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(widget.videoPath, newViewCount);

        setState(() {
          viewCount = newViewCount;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(videoPath: widget.videoPath),
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
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image(
                    image: AssetImage(widget.thumbnailPath),
                    height: widget.imageHeight,
                    width: widget.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.visibility),
                      SizedBox(width: 4),
                      Text('$viewCount'),
                    ],
                  ),
                ],
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

  const VideoPlayerScreen({Key? key, required this.videoPath})
      : super(key: key);

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
      looping: true,
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
    return Scaffold(
      body: Center(
        child: Chewie(
          controller: _chewieController,
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
