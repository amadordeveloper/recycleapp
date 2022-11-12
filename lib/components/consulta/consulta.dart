import 'package:flutter/material.dart';
import 'package:recycle/model/residuo.dart';
import 'package:recycle/config.dart';

class Consulta extends StatefulWidget {
  final Residuo residuo;
  const Consulta({Key? key, required this.residuo}) : super(key: key);

  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  @override
  Widget build(BuildContext context) {
    Config config = Config();
    final String _urlApi = config.getApiUrl();
    return Scaffold(
      body: Center(
        child: Container(
          // add margin top 80, left 20, right 20, bottom 20
          margin:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
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
                  Text(
                    widget.residuo.nombre,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.residuo.descripcion,
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Image.network(
                          _urlApi +
                              "archivos/residuos/" +
                              widget.residuo.id.toString() +
                              ".png",
                          width: 100,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              const Text(
                                "Impacto",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.residuo.impacto,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 129, 188, 243),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Alternativas y/o disposición",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Image.network(
                          _urlApi +
                              "archivos/destinos/" +
                              widget.residuo.id.toString() +
                              ".png",
                          width: 200,
                        ),
                        Text(
                          widget.residuo.destino,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
