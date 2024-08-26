import 'package:flutter/material.dart';

class DoubtAndSolutionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doubt & Solutions'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Text('This is the Doubt & Solutions page'),
      ),
    );
  }
}