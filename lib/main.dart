import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:binary_clock/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Clock',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(child: Clock()),
      ),
    );
  }
}

class Clock extends StatefulWidget {
  Clock({Key key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  BinaryTime _now = BinaryTime();

  // Tick the clock
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _now = BinaryTime();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 0),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: kCurrentTheme.backgroundColor,
      child: Row(
        children: [
          // Columns for the clock
          ClockColumn(
            binaryInteger: _now.hourTens,
            title: 'H',
            colorFilled: kCurrentTheme.ballColorFilled,
            colorEmpty: kCurrentTheme.ballColorEmpty,
            rows: 2,
          ),
          ClockColumn(
            binaryInteger: _now.hourOnes,
            title: 'h',
            colorFilled: kCurrentTheme.ballColorFilled,
            colorEmpty: kCurrentTheme.ballColorEmpty,
          ),
          ClockColumn(
            binaryInteger: _now.minuteTens,
            title: 'M',
            colorFilled: kCurrentTheme.ballColorFilled,
            colorEmpty: kCurrentTheme.ballColorEmpty,
            rows: 3,
          ),
          ClockColumn(
            binaryInteger: _now.minuteOnes,
            title: 'm',
            colorFilled: kCurrentTheme.ballColorFilled,
            colorEmpty: kCurrentTheme.ballColorEmpty,
          ),
          ClockColumn(
            binaryInteger: _now.secondTens,
            title: 'S',
            colorFilled: kCurrentTheme.ballColorFilled,
            colorEmpty: kCurrentTheme.ballColorEmpty,
            rows: 3,
          ),
          ClockColumn(
            binaryInteger: _now.secondOnes,
            title: 's',
            colorFilled: kCurrentTheme.ballColorFilled,
            colorEmpty: kCurrentTheme.ballColorEmpty,
          ),
          Expanded(
              flex: 6,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Lottie.network(kCurrentTheme.animationURL),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2)),
                    width: double.maxFinite,
                    padding: EdgeInsets.all(4),
                    child: FittedBox(
                      child: Text(
                        'A super funny joke comes here frequently :)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
                ],
              )),
        ],
      ),
    );
  }
}

/// Column to represent a binary integer.
class ClockColumn extends StatelessWidget {
  final String binaryInteger;
  final String title;
  final Color colorFilled;
  final Color colorEmpty;
  final int rows;
  ClockColumn(
      {this.binaryInteger,
      this.title,
      this.colorFilled,
      this.colorEmpty,
      this.rows = 4});

  @override
  Widget build(BuildContext context) {
    List bits = binaryInteger.split('');
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ...[
          //   Container(
          //     child: Text(
          //       title,
          //       style: Theme.of(context).textTheme.headline4,
          //     ),
          //   )
          // ],
          ...bits.asMap().entries.map((entry) {
            int idx = entry.key;
            String bit = entry.value;
            bool isActive = bit == '1';
            int binaryCellValue = pow(2, 3 - idx);

            return Expanded(
              child: AnimatedContainer(
                height: double.maxFinite,
                duration: Duration(milliseconds: 475),
                curve: Curves.ease,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive
                        ? colorFilled
                        : idx < 4 - rows
                            ? Colors.white.withOpacity(0)
                            : colorEmpty ?? Colors.black38),
                margin: EdgeInsets.all(4),
                // child: Center(
                //   child: isActive
                //       ? Text(
                //           binaryCellValue.toString(),
                //           style: TextStyle(
                //             color: Colors.black.withOpacity(0.2),
                //             fontSize: 20,
                //             fontWeight: FontWeight.w700,
                //           ),
                //         )
                //       : Container(),
                // ),
              ),
            );
          }),
          ...[
            Text(
              int.parse(binaryInteger, radix: 2).toString(),
              style: TextStyle(
                  fontSize: 25,
                  color: colorFilled,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              binaryInteger,
              style: TextStyle(
                  fontSize: 15,
                  color: colorFilled,
                  fontWeight: FontWeight.bold),
            )
          ]
        ],
      ),
    );
  }
}
