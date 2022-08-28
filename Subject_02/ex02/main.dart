import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final title = 'Fluent Gauge';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double gauge = 0;
  @override
  Widget build(BuildContext context) {
    const double max = 150;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[900]),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SfRadialGauge(
                axes: [
                  RadialAxis(
                    interval: 10,
                    showLastLabel: true,
                    axisLabelStyle: const GaugeTextStyle(color: Colors.white70),
                    majorTickStyle: const MajorTickStyle(
                      length: 8,
                      color: Colors.white70,
                      thickness: 2,
                    ),
                    minorTickStyle:
                        const MinorTickStyle(length: 4, color: Colors.white70),
                    minimum: 0,
                    maximum: max,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0, endValue: 50, color: Colors.green),
                      GaugeRange(
                          startValue: 50, endValue: 100, color: Colors.orange),
                      GaugeRange(
                          startValue: 100, endValue: max, color: Colors.red)
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        enableAnimation: true,
                        value: gauge,
                        needleColor: Colors.white,
                        knobStyle: const KnobStyle(color: Colors.white),
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          gauge.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.white),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      )
                    ],
                  ),
                ],
              ),
              Slider(
                max: max,
                value: gauge,
                onChanged: (value) => setState(() {
                  gauge = value;
                }),
                activeColor: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
