import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
//  UnknownScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
