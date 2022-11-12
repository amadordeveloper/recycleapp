import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recycle/components/home/bienvenida.dart';
import 'package:http/http.dart' as http;
import 'package:recycle/config.dart';

class Recoleccion extends StatefulWidget {
  const Recoleccion({Key? key}) : super(key: key);

  @override
  _RecoleccionState createState() => _RecoleccionState();

  toJson() {}
}

class _RecoleccionState extends State<Recoleccion> {
  // initializing control variable tipo_residuo
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _dimensionController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Config config = Config();
    final String _urlApi = config.getApiUrl();
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
        // add margin top 80, left 20, right 20, bottom 20
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // add back button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Recolección',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  TextFormField(
                    controller: _tipoController,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el tipo de residuo';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(
                      labelText: '¿Qué tipo de residuo deseas disponer?',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: Papel, Plastico, Metal',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _pesoController,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa el peso aprox. de residuo';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(
                      labelText: '¿Cuánto es el peso aproximado?',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: 10, 20, 30',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _dimensionController,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa las dimensiones del residuo';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(
                      labelText: '¿Cuáles son sus dimensiones aproximadas?',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: 1.2mts ancho x 2mts alto, 30cm largo',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _direccionController,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa la dirección de recolección';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(
                      labelText:
                          '¿Cuál es la dirección donde se recojerá el residuo?',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: Calle, Avenida, Carrera',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _ciudadController,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa la ciudad de recolección';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(
                      labelText:
                          '¿Cuál es la ciudad donde se recojerá el residuo?',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: Bucaramanga, Floridablanca, Girón',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nombreController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre completo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: '¿Cuál es tu nombre completo?',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: Pedro Antonio Pérez Pérez',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _telefonoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu número de contacto';
                      }
                      // validating telefono number
                      if (value.length != 10 ||
                          !RegExp(r'^[0-9]').hasMatch(value) ||
                          !value.startsWith('3')) {
                        return 'Por favor ingresa un número de contacto válido';
                      }
                      return null;
                    },
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: '¿Cuál es el número de contacto?',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: 3123456789',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _correoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo electrónico';
                      }
                      // check if the correo is valid
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Por favor ingresa un correo electrónico válido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: '¿Cuál es el correo electrónico?',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: pedroantonioperez@micorreo.com',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Enviando solicitud...")));
                        Uri uri = Uri.parse(_urlApi + 'recoleccion/');
                        var _tipo = '';
                        var _peso = '';
                        var _dimensiones = '';
                        var _direccion = '';
                        var _ciudad = '';
                        var _nombre = '';
                        var _telefono = '';
                        var _correo = '';
                        _formKey.currentState!.save();
                        _tipo = _tipoController.text;
                        _peso = _pesoController.text;
                        _dimensiones = _dimensionController.text;
                        _direccion = _direccionController.text;
                        _ciudad = _ciudadController.text;
                        _nombre = _nombreController.text;
                        _telefono = _telefonoController.text;
                        _correo = _correoController.text;

                        http
                            .post(
                          uri,
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'tipo': _tipo,
                            'peso': _peso,
                            'dimensiones': _dimensiones,
                            'direccion': _direccion,
                            'ciudad': _ciudad,
                            'nombre': _nombre,
                            'telefono': _telefono,
                            'correo': _correo,
                          }),
                        )
                            .then((response) {
                          if (response.statusCode == 200) {
                            // If the call to the server was successful, parse the JSON
                            print(response);
                            final Map<String, dynamic> responseJson =
                                json.decode(response.body);
                            // show a success message
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(responseJson['message'])));
                          } else {
                            // If that call was not successful, throw an error.
                            throw Exception('Failed to load post');
                          }
                        });

                        // timeout 3 seconds
                        Future.delayed(const Duration(seconds: 3), () {
                          // after 3 seconds, navigate to the next page
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Envío exitoso")));
                          // _formKey.currentState!.reset();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 142, 57, 181),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: const Text(
                      "Enviar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Bienvenida()),
                      );
                    }),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 181, 76, 57),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: const Text(
                      "Volver",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
