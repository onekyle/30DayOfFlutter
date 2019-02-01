import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'dart:core';
import 'dart:async';

class StopWatchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StopWatchState();
  }
}

// String StopWatchInitialTime = '00:00:00';

class StopWatchState extends State<StopWatchPage> {
  String intervalTime = '00:00:00';
  String totalTime = '00:00:00';
  Stopwatch _stopwatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("StopWatch"),
      ),
      body: Column(
        children: <Widget>[
          _WatchPlate(
            intervalTime: this.intervalTime,
            totalTime: this.totalTime,
          ),
          _WatchControlButton(
            clickLeftButton: _onClickShift,
            clickRightButton: _onClickStart,
            watchOn: _stopwatch.isRunning,
          )
        ],
      ),
    );
  }

  void _onClickStart() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();

      Timer.periodic(Duration(milliseconds: 10), (timer) {
        int milSecond,
            second,
            minute,
            countingTime,
            lapSecond,
            lapSecond,
            lapMinute,
            lapCountingTime;
        int countingTime = _stopwatch.elapsedMilliseconds;
        minute = (countingTime / 1000 / 60).floor();
        second = (countingTime - (minute * 60 * 1000));
        print(countingTime);
        // minute = (countingTime / 1000 / 60).floor();
        // second = countingTime - 6000 * minute

        if (!_stopwatch.isRunning) {
          timer.cancel();
        }
      });
    }
  }

  void _onClickShift() {}
}

class _WatchPlate extends StatelessWidget {
  _WatchPlate({
    Key key,
    this.intervalTime = '00:00:00',
    this.totalTime = '00:00:00',
  }) : super(key: key);

  final String intervalTime;
  final String totalTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xfff3f3f3),
          border: Border(bottom: BorderSide(color: Color(0xffdddddd)))),
      padding: EdgeInsets.only(top: 30.0),
      alignment: Alignment.center,
      height: 170,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 30.0),
            child: Text(
              this.intervalTime,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w100,
                  color: const Color(0xff555555),
                  fontFamily: "RobotoMono"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              this.totalTime,
              style: const TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.w100,
                  color: const Color(0xff222222),
                  fontFamily: "RobotoMono"),
            ),
          )
        ],
      ),
    );
  }
}

class _WatchControlButton extends StatefulWidget {
  _WatchControlButton(
      {Key key,
      @required this.clickLeftButton,
      @required this.clickRightButton,
      this.watchOn})
      : super(key: key);

  final Function clickLeftButton;
  final Function clickRightButton;
  final bool watchOn;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WatchControlBtnState();
  }

  // @override
  // final State<StatefulWidget> createState = _WatchControlBtnState();
}

class _WatchControlBtnState extends State<_WatchControlButton> {
  String startBtnText = 'Start';
  Color startBtnTextColor = Color(0xff60b644);
  // 计次/ 重置
  String shiftBtnText = 'Lap';
  Color shiftBtnTextColor = Color(0xffeeeeee);

  _clickStartBtn() {
    if (!widget.watchOn) {
      setState(() {
        this.startBtnText = 'Stop';
        this.startBtnTextColor = Color(0xffff0044);
        this.shiftBtnText = 'Lap';
        this.shiftBtnTextColor = Color(0xffeeeeee);
      });
    } else {
      setState(() {
        this.startBtnText = 'Start';
        this.startBtnTextColor = Color(0xff60b644);
        this.shiftBtnText = 'Reset';
        this.shiftBtnTextColor = Color(0xffeeeeee);
      });
    }
    widget.clickRightButton();
  }

  @override
  Widget build(BuildContext context) {
    double childWH = 70.0;
    return Ink(
      height: 100,
      decoration: BoxDecoration(color: Color(0xfff3f3f3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Ink(
            height: childWH,
            width: childWH,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.all(Radius.circular(childWH * 0.5)),
            ),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(childWH * 0.5)),
              splashColor: Colors.black,
              onTap: widget.clickLeftButton,
              child: Center(
                child: Text(
                  this.shiftBtnText,
                  style: TextStyle(color: this.shiftBtnTextColor),
                ),
              ),
            ),
          ),
          Ink(
            height: childWH,
            width: childWH,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.all(Radius.circular(childWH * 0.5)),
            ),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(childWH * 0.5)),
              splashColor: Colors.black,
              onTap: _clickStartBtn,
              child: Center(
                child: Text(
                  this.startBtnText,
                  style: TextStyle(color: this.startBtnTextColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
