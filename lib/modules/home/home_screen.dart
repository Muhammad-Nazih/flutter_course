import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(Icons.menu),
        title: Text("First App"),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important),
            onPressed: () {
              debugPrint("Hello World!");
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              debugPrint("Hi");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: 200,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIMDI-nHs9LID8j_nNvfplgDwtWn56f2O0UQ&s',
                  ),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.7),
                  child: Text(
                    'Flower',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
