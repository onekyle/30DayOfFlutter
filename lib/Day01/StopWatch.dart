import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StopWatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Working in progress'),
        trailing: Text('test'),
      ),
      body: Container(
        child: Center(
          child: Text('Working in progress'),
        ),
      ),
    );
  }
}
