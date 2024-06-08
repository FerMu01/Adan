import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'third_screen.dart';
// import 'fourth_screen.dart'; // Corregido el nombre del import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
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
          // Aquí agregamos la primera imagen en la parte superior
          Container(
            width: double.infinity, // Ocupa todo el ancho disponible
            padding: EdgeInsets.symmetric(vertical: 60), // Espaciado interno
            child: Image.asset(
              'assets/images/ADANB.png', // Ruta de la imagen
              fit: BoxFit.contain, // Ajuste de la imagen para que quepa dentro del contenedor
              width: 120, // Ancho deseado de la imagen
              height: 120, // Alto deseado de la imagen
            ),
          ),
          // Aquí agregamos la segunda imagen debajo de la primera
          Image.asset(
            'assets/images/AdanMainMenu.png', // Ruta de la segunda imagen
            width: 120, // Ancho deseado de la segunda imagen
            height: 120, // Alto deseado de la segunda imagen
          ),
          // Aquí está el resto del contenido
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1844FC)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  icon: Icon(Icons.video_camera_back_sharp),
                  label: Text('Galería'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => FourthScreen()),
                    //);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1844FC)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  icon: Icon(Icons.article_sharp),
                  label: Text('Ley 348'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThirdScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1844FC)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  icon: Icon(Icons.sentiment_very_dissatisfied),
                  label: Text('Desahogate'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
