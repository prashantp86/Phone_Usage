import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DeterminatePage(),
    );
  }
}

class DeterminatePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DeterminatePage({Key key}) : super(key: key);

  @override
  _DeterminatePageState createState() => _DeterminatePageState();
}

class _DeterminatePageState extends State<DeterminatePage> {
  Timer _timer;
  double progressValue = 0;
  double secondaryProgressValue = 0;
  // ignore: sort_constructors_first
  _DeterminatePageState() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer _timer) {
      setState(() {
        progressValue++;
        secondaryProgressValue = secondaryProgressValue + 2;
        if (progressValue == 100) {
          _timer.cancel();
        }
        if (secondaryProgressValue > 100) {
          secondaryProgressValue = 100;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Phone Usage')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //getNormalProgressStyle(),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    getThickProgressStyle(),

                  ]),
            ]));
  }



  /// Returns thick progress style circular progress bar.
  Widget getThickProgressStyle() {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.75,
            axisLineStyle: AxisLineStyle(
              thickness: 0.05,
              color: const Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: progressValue,
                width: 0.2,
                pointerOffset: -0.08,
                enableAnimation: true,
                animationDuration: 100,
                animationType: AnimationType.linear,
                sizeUnit: GaugeSizeUnit.factor,
                gradient: const SweepGradient(
                  colors: <Color>[Color(0xFF00a9b5), Color(0xFFa4edeb)],
                  stops: <double>[0.25, 0.75])),

              MarkerPointer(
                value: progressValue,
                markerType: MarkerType.circle,
                enableAnimation: true,
                animationDuration: 100,
                animationType: AnimationType.linear,
                color: const Color(0xFF87e8e8),
              )
            ],
          )
        ]));
  }



  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}