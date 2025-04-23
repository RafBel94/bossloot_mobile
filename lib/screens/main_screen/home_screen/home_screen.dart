import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF270140), Color.fromARGB(255, 141, 24, 112)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Add your widgets here
              Container(
                height: 200,
                color: Colors.blue,
                child: Center(child: Text('Header')),
              ),
              Container(
                height: 600,
                color: Colors.red,
                child: Center(child: Text('Main Content')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}