import 'package:flutter/material.dart';
import 'bienvenida.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Bienvenida()));
              },
              child: const Text('INGRESAR'),
              style: ElevatedButton.styleFrom(
              primary: const Color(0xFF29ABE2),
              textStyle: const TextStyle(color: Colors.white),
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              elevation: 10,
              ),
              ),
          ],
        ),
      ),
    );
  }
}
