import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notas.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  bool _showTextInput = true;
  bool _showMenuButton = false;
  bool _showNotesButton = true;
  bool _showAuthorName = false; // Nueva variable para controlar la visibilidad del nombre del autor
  final TextEditingController _textController = TextEditingController(); // Controlador del TextField

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        // Puedes hacer algo aquí si el teclado se muestra o se oculta
      });
    });
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
      ),
      body: GestureDetector(
        onTap: () {
          // Oculta el teclado cuando se toca fuera de un TextField
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(), // Evita el desplazamiento
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 200.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _showTextInput ? 200 : 0,
                curve: Curves.easeInOut,
                child: _showTextInput
                    ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFDFE3FE),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _textController, // Asigna el controlador al TextField
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Escribe Lo Que Sientes...',
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF7E7878),
                        fontSize: 20.0,
                      ),
                      filled: true,
                      fillColor: Color(0xFFDFE3FE),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 7,
                    maxLines: null,
                  ),
                )
                    : const SizedBox(),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: _showTextInput,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_textController.text.isNotEmpty) {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      List<String> notasGuardadas = prefs.getStringList('notas') ?? [];
                      notasGuardadas.add(_textController.text);
                      prefs.setStringList('notas', notasGuardadas);
                      setState(() {
                        _showTextInput = false;
                        _showMenuButton = true;
                        _showNotesButton = true;
                        _showAuthorName = true; // Mostrar el nombre del autor
                      });
                    } else {
                      // Mostrar un mensaje de error si el texto está vacío
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Debes ingresar un texto antes de guardar.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF1844FC),
                  ),
                  icon: const Icon(Icons.sentiment_satisfied_sharp),
                  label: const Text('Me Siento Mejor'),
                ),

              ),
              const SizedBox(height: 5),
              _showTextInput
                  ? const SizedBox()
                  : Stack(
                children: [
                  Container(
                    width: 320,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFE3FE),
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 16,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Cuando la comunicación apoya la compasión, el dar y recibir, la felicidad reemplaza la violencia.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF000000),

                          fontSize: 24,
                          fontFamily: 'Alegreya',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Visibility(
                      visible: _showAuthorName,
                      child: const Text(
                        '-Marshall Rosenberg', // Nombre del autor
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Alegreya',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _showMenuButton,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1844FC),
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_forward_sharp),
                  label: const Text('Menu Principal'),
                ),
              ),
              Visibility(
                visible: _showNotesButton,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Notas()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1844FC),
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.library_books_rounded),
                  label: const Text('Mis Notas'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
