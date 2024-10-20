import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ResultPage extends StatelessWidget {
  final double bmi;
  final String category;

  const ResultPage({super.key, required this.bmi, required this.category});

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the BMI category
    Color bmiColor;
    if (bmi < 18.5) {
      bmiColor = Colors.blue; // Underweight
    } else if (bmi >= 18.5 && bmi < 25) {
      bmiColor = Colors.green; // Normal weight
    } else if (bmi >= 25 && bmi < 30) {
      bmiColor = Colors.yellow; // Overweight
    } else {
      bmiColor = Colors.red; // Obesity
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your BMI Result'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BMI: ${bmi.toStringAsFixed(1)} kg/m²',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Category: $category',
                style: TextStyle(fontSize: 24, color: bmiColor),
              ),
              const SizedBox(height: 40),
              // BMI Gauge Chart
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 10,
                    maximum: 40,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 10,
                        endValue: 18.5,
                        color: Colors.blue,
                        label: 'Underweight',
                        sizeUnit: GaugeSizeUnit.factor,
                        labelStyle: const GaugeTextStyle(fontSize: 12),
                      ),
                      GaugeRange(
                        startValue: 18.5,
                        endValue: 25,
                        color: Colors.green,
                        label: 'Normal',
                        sizeUnit: GaugeSizeUnit.factor,
                        labelStyle: const GaugeTextStyle(fontSize: 12),
                      ),
                      GaugeRange(
                        startValue: 25,
                        endValue: 30,
                        color: Colors.yellow,
                        label: 'Overweight',
                        sizeUnit: GaugeSizeUnit.factor,
                        labelStyle: const GaugeTextStyle(fontSize: 12),
                      ),
                      GaugeRange(
                        startValue: 30,
                        endValue: 40,
                        color: Colors.red,
                        label: 'Obesity',
                        sizeUnit: GaugeSizeUnit.factor,
                        labelStyle: const GaugeTextStyle(fontSize: 12),
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: bmi,
                        needleColor: bmiColor,
                        knobStyle: KnobStyle(color: bmiColor),
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          'BMI = ${bmi.toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
