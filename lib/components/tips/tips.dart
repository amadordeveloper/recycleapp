import 'dart:math';

import 'package:flutter/material.dart';

import '../../api/tipsapi.dart';
import '../../model/tip.dart';

class Tips extends StatefulWidget {
  const Tips({Key? key}) : super(key: key);

  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  List<Tip> tips = [];
  String _currentTip = 'Cargando...';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final listTips = await TipsApi.getTips("");
    setState(() => tips = listTips);
    _currentTip = tips[getRandomTip()].tip;
  }

  // get random number from 0 to tips.length
  int getRandomTip() => Random().nextInt(tips.length);

  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    'Tips',
                    style: TextStyle(
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
                        const Text(
                          "Consejos útiles para cuidar el Medio Ambiente mediante el aprovechamiento o la correcta disposición de los residuos",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        const Image(
                          image: AssetImage('assets/images/bombilla.png'),
                          height: 200,
                        ),
                        const SizedBox(height: 40),
                        Text(
                          _currentTip,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          child: const Text(
                            'Siguiente',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _currentTip = tips[getRandomTip()].tip;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 88, 150, 73),
                            padding: const EdgeInsets.all(20),
                          ),
                        ),
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
