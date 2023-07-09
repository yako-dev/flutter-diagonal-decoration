import 'package:flutter/material.dart';
import 'package:diagonal_decoration/diagonal_decoration.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text('Diagonal Decoration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            diagonalContainer(),
            const SizedBox(height: 40),
            const Text('Matrix Decoration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            matrixContainer(),
          ],
        ),
      )),
    );
  }

  Container diagonalContainer() {
    Widget tile(String title, String subtitle, IconData icon) {
      return Row(
        children: [
          Icon(icon),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(height: 5),
              Text(subtitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          )
        ],
      );
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 36),
        padding: const EdgeInsets.all(25),
        decoration: const DiagonalDecoration(
          lineColor: Colors.black,
          backgroundColor: Colors.grey,
          radius: Radius.circular(20),
          lineWidth: 1,
          distanceBetweenLines: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Main features',
                style: TextStyle(fontSize: 15, color: Colors.grey.shade600)),
            const SizedBox(height: 20),
            tile('Multi-currency account', '29 currencies', Icons.wallet),
            const SizedBox(height: 20),
            tile('Free cards', '1 virtual + 1 physical',
                Icons.currency_exchange),
          ],
        ));
  }

  Container matrixContainer() {
    return Container(
      width: 240,
      height: 160,
      padding: const EdgeInsets.all(20),
      decoration: const MatrixDecoration(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Temperature',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'in Ukraine 🇺🇦',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '32°C',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
