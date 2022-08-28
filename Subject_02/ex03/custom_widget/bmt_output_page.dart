import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiOutputPage extends StatefulWidget {
  const BmiOutputPage({Key? key, required this.bmi}) : super(key: key);

  final double bmi;

  @override
  State<BmiOutputPage> createState() => _BmiOutputPageState();
}

class _BmiOutputPageState extends State<BmiOutputPage> {
  final double max = 45;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfRadialGauge(
          axes: [
            RadialAxis(
              interval: 5,
              showLastLabel: true,
              minimum: 0,
              maximum: max,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 18.5,
                  color: Colors.lightBlue,
                  label: '저체중',
                ),
                GaugeRange(
                  startValue: 18.5,
                  endValue: 25,
                  color: Colors.green,
                  label: '정상',
                ),
                GaugeRange(
                  startValue: 25,
                  endValue: 30,
                  color: Colors.orange,
                  label: '과체중',
                ),
                GaugeRange(
                  startValue: 30,
                  endValue: 35,
                  color: Colors.pink,
                  label: '비만',
                ),
                GaugeRange(
                  startValue: 35,
                  endValue: max,
                  color: Colors.red,
                  label: '고도 비만',
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  enableAnimation: true,
                  value: widget.bmi,
                  needleColor: Colors.black,
                  knobStyle: const KnobStyle(color: Colors.black),
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Text(
                    'BMI : ${widget.bmi.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.5,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
