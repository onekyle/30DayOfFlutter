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
  int _recordTime = 0;
  List<String> _recordList = List();
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
          ),
          Expanded(
              child: _WatchRecord(
            recordList: _recordList,
          ))
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
            lapMilSecond,
            lapSecond,
            lapMinute,
            lapCountingTime;
        countingTime = _stopwatch.elapsedMilliseconds;
        minute = (countingTime / 1000 / 60).floor();
        second = ((countingTime - (minute * 60 * 1000)) / 1000).floor();
        milSecond = ((countingTime % 1000) / 10).floor();

        lapCountingTime = countingTime - _recordTime;
        lapMinute = (lapCountingTime / 1000 / 60).floor();
        lapSecond = ((lapCountingTime - (minute * 60 * 1000)) / 1000).floor();
        lapMilSecond = ((lapCountingTime % 1000) / 10).floor();
        // print(countingTime);

        setState(() {
          totalTime = (minute % 60).toString().padLeft(2, '0') +
              ":" +
              (second % 60).toString().padLeft(2, '0') +
              "." +
              (milSecond % 60).toString().padLeft(2, '0');

          intervalTime = (lapMinute % 60).toString().padLeft(2, '0') +
              ":" +
              (lapSecond % 60).toString().padLeft(2, '0') +
              "." +
              (lapMilSecond % 60).toString().padLeft(2, '0');
        });
        // minute = (countingTime / 1000 / 60).floor();
        // second = countingTime - 6000 * minute

        if (!_stopwatch.isRunning) {
          timer.cancel();
        }
      });
    }
  }

  void _onClickShift() {
    if (_stopwatch.isRunning) {
      _recordTime = _stopwatch.elapsedMilliseconds;
      _recordList.add(intervalTime);
    } else {
      setState(() {
        intervalTime = '00:00.00';
        totalTime = '00:00.00';
        _recordList.clear();
        _recordTime = 0;
      });

      _stopwatch.reset();
    }
  }
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

class _WatchRecord extends StatelessWidget {
  _WatchRecord({Key key, this.recordList}) : super(key: key);

  final List<String> recordList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recordList.length,
      itemBuilder: (context, index) {
        int targetIndex = recordList.length - index;
        return Container(
          height: 40.0,
          padding:
              EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0, bottom: 5.0),
          decoration: BoxDecoration(
              border: BorderDirectional(
                  bottom: BorderSide(color: Color(0xFFBBBBBB)))),
          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  '计次 $targetIndex',
                  style: TextStyle(color: Color(0xFF777777)),
                ),
              ),
              Expanded(
                child: Text(
                  recordList[targetIndex - 1],
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Color(0xFF222222), fontFamily: "RobotoMono"),
                ),
              )
            ],
          ),
        );
      },
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
  Color shiftBtnTextColor = Color(0xff60b644);

  _clickStartBtn() {
    if (!widget.watchOn) {
      setState(() {
        this.startBtnText = 'Stop';
        this.startBtnTextColor = Color(0xffff0044);
        this.shiftBtnText = 'Lap';
        this.shiftBtnTextColor = Color(0xff60b644);
      });
    } else {
      setState(() {
        this.startBtnText = 'Start';
        this.startBtnTextColor = Color(0xff60b644);
        this.shiftBtnText = 'Reset';
        this.shiftBtnTextColor = Color(0xffff0044);
      });
    }
    widget.clickRightButton();
  }

  _clickShiftBtn() {
    if (widget.watchOn) {
    } else {
      setState(() {
        this.shiftBtnText = 'Lap';
        this.shiftBtnTextColor = Color(0xff60b644);
      });
    }
    widget.clickLeftButton();
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
              onTap: _clickShiftBtn,
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
