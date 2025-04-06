import 'dart:math';
import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {
  final int result;
  final int age;
  final bool isMale;

  BmiResultScreen({
    required this.result,
    required this.age,
    required this.isMale,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('BMI Result'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender: ${isMale ? 'Male' : 'Feamle'}',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Age: $age',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   'BMI Healthy Range: 18.5 to 24.9',
            //   maxLines: 2,
            //   style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }
}
