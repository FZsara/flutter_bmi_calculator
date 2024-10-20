import 'package:flutter/material.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _ageController = TextEditingController();
  final _heightFeetController = TextEditingController();
  final _heightInchesController = TextEditingController();
  final _heightCmController = TextEditingController();
  final _weightController = TextEditingController();
  String gender = "Male";
  bool isMetric = false; // Default to US units

  void _clearFields() {
    _ageController.clear();
    _heightFeetController.clear();
    _heightInchesController.clear();
    _heightCmController.clear();
    _weightController.clear();
  }

  void _calculateBMI() {
    double bmi;
    double weight = double.parse(_weightController.text);

    if (isMetric) {
      double heightInCm = double.parse(_heightCmController.text);
      bmi = weight / ((heightInCm / 100) * (heightInCm / 100));
    } else {
      double heightInInches = (double.parse(_heightFeetController.text) * 12) +
          double.parse(_heightInchesController.text);
      bmi = 703 * weight / (heightInInches * heightInInches);
    }

    String category;
    if (bmi < 18.5) {
      category = "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      category = "Normal weight";
    } else if (bmi >= 25 && bmi < 29.9) {
      category = "Overweight";
    } else {
      category = "Obesity";
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(bmi: bmi, category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Age',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'ages: 2 - 120',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Gender'),
            Row(
              children: [
                Radio(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                const Text('Male'),
                Radio(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                const Text('Female'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('US Units'),
                Switch(
                  value: isMetric,
                  onChanged: (value) {
                    setState(() {
                      isMetric = value;
                    });
                  },
                ),
                const Text('Metric Units'),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Height',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            if (isMetric)
              TextField(
                controller: _heightCmController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _heightFeetController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Feet',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _heightInchesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Inches',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            const Text(
              'Weight',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: isMetric ? 'Weight (kg)' : 'Weight (lbs)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.calculate),
                      SizedBox(width: 5),
                      Text(
                        'Calculate',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _clearFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.clear),
                      SizedBox(width: 5),
                      Text(
                        'Clear',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
