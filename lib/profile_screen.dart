import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> completedInformation = [
    'Hartslag',
    'Slaap',
    'Stappen',
  ];

  final List<String> dataValues = [
    '80 bpm',
    '7 uur',
    '10,000 stappen',
  ];

  String stepCount = '0';
  StreamSubscription<int>? _subscription;

  @override
  void initState() {
    super.initState();
    startListening();
  }

  void startListening() {
    Pedometer.stepCountStream.listen((stepCountValue) {
      setState(() {
        stepCount = stepCountValue.toString();
      });
    }).onError((error) {
      print("Pedometer Error: $error");
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Container(
                width: 400, // Set the desired width for the upper widget
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'progressie: haal 10.000 stappen',
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                      SizedBox(height: 16),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: double.parse(stepCount) / 10000,
                              strokeWidth: 10,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Text(
                            '${(double.parse(stepCount) / 10000 * 100).toStringAsFixed(0)}%',
                            style: TextStyle(fontSize: 24, color: Colors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 400, // Set the desired width for the lower widget
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text('Stappen'),
                  subtitle: Text('$stepCount stappen'),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 400, // Set the desired width for the lower widget
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Uitleg',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'De stappenteller registreert het aantal stappen dat je neemt gedurende de dag. Het is belangrijk om dagelijks meer dan 5000 stappen te zetten. Probeer 10.000 stappen te halen.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
