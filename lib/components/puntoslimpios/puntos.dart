import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recycle/api/puntosapi.dart';
import 'package:recycle/config.dart';
import 'package:recycle/model/puntolimpio.dart';

class PuntosLimpios extends StatefulWidget {
  const PuntosLimpios({Key? key}) : super(key: key);

  @override
  _PuntosLimpiosState createState() => _PuntosLimpiosState();
}

class _PuntosLimpiosState extends State<PuntosLimpios> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _center = const LatLng(7.117759171252917, -73.12621652784348);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
  }

  List<PuntoLimpio> puntosLimpios = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final listPuntos = await PuntosLimpiosApi.getPuntosLimpios("");
    setState(() => puntosLimpios = listPuntos);
  }

  @override
  Widget build(BuildContext context) {
    Config config = Config();
    final String _urlApi = config.getApiUrl();

    return Scaffold(
      body: Container(
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
                  'Puntos Limpios',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          spreadRadius: -20,
                        ),
                      ],
                    ),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 13.0,
                      ),
                      onMapCreated: _onMapCreated,
                      onCameraMove: _onCameraMove,
                      zoomGesturesEnabled: true,
                      // add mapType
                      mapType: MapType.normal,
                      // add markers
                      markers: {
                        for (final puntolimpio in puntosLimpios)
                          buildMarkers(puntolimpio, context)
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // add image box with padding
                  Expanded(
                    child: ListView(
                      children: [
                        for (final puntolimpio in puntosLimpios)
                          GestureDetector(
                            child: Card(
                              margin: const EdgeInsets.only(
                                  left: 0, right: 0, top: 0, bottom: 10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          _urlApi +
                                              "archivos/puntos/" +
                                              puntolimpio.id.toString() +
                                              ".png",
                                          width: 65,
                                          height: 65,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Flexible(
                                          child: Text(puntolimpio.nombre,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _controller.future
                                    .then((GoogleMapController controller) {
                                  controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                    target: LatLng(puntolimpio.latitud,
                                        puntolimpio.longitud),
                                    zoom: 15,
                                  )));
                                });
                              });
                            },
                          )
                      ],
                    ),
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

Marker buildMarkers(PuntoLimpio puntolimpio, context) {
  return Marker(
    markerId: MarkerId(puntolimpio.id.toString()),
    position: LatLng(puntolimpio.latitud, puntolimpio.longitud),
    infoWindow: InfoWindow(
      title: puntolimpio.nombre,
      snippet: puntolimpio.descripcion,
    ),
  );
}
