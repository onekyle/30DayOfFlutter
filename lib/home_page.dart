import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/Day01/StopWatch.dart';

class HomePage extends StatelessWidget {
  Widget pageCell(
      BuildContext context, Icon icon, String title, Widget nextPage) {
    return Container(
      decoration: BoxDecoration(
          border: BorderDirectional(
        bottom: const BorderSide(color: const Color(0xffcccccc)),
        end: const BorderSide(color: const Color(0xffcccccc)),
      )),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute<bool>(builder: (context) => nextPage),
          );
        },
        child: Center(
          heightFactor: 2.0,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // icon,
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  title,
                  textScaleFactor: 1.5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Flutter Demons'),
      ),
      body: ListView(
        primary: false,
        children: <Widget>[
          pageCell(context, null, "计时器", StopWatch()),
        ],
      ),
    );
  }
}
