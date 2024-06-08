import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notas extends StatefulWidget {
  const Notas({Key? key}) : super(key: key);

  @override
  _NotasState createState() => _NotasState();
}

class _NotasState extends State<Notas> {
  List<String> notas = [];

  @override
  void initState() {
    super.initState();
    cargarNotas();
  }

  void cargarNotas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notas = prefs.getStringList('notas') ?? [];
    });
  }

  void agregarNota(String nuevaNota) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notas.add(nuevaNota);
      prefs.setStringList('notas', notas);
    });
  }

  void eliminarNota(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notas.removeAt(index);
      prefs.setStringList('notas', notas);
    });
  }

  void editarNota(int index, String nuevaNota) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notas[index] = nuevaNota;
      prefs.setStringList('notas', notas); // Actualizar notas en SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Notas'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
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
      body: ListView.builder(
        itemCount: notas.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 4.0,
            child: ListTile(
              title: Text(
                notas[index],
                style: TextStyle(fontSize: 16.0),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController controller = TextEditingController(text: notas[index]);
                          return AlertDialog(
                            title: Text('Editar nota'),
                            content: TextField(
                              controller: controller,
                              onChanged: (value) {
                                // Actualizar el texto de la nota mientras se edita (opcional)
                              },
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  editarNota(index, controller.text); // Pasar el valor actualizado del campo de texto
                                  Navigator.of(context).pop();
                                },
                                child: Text('Guardar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Eliminar nota'),
                          content: Text('¿Estás seguro de eliminar esta nota?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                eliminarNota(index);
                                Navigator.of(context).pop();
                              },
                              child: Text('Eliminar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
