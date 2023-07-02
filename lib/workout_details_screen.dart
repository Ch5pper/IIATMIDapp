import 'package:flutter/material.dart';
import 'dart:async';

class WorkoutDetailsScreen extends StatefulWidget {
  final String workoutName;
  final String description;

  const WorkoutDetailsScreen({
    required this.workoutName,
    required this.description,
  });

  @override
  _WorkoutDetailsScreenState createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  double progress = 0.0;
  int timerDuration = 0;
  Timer? timer;

  void startTimer() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Timer Duration'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                timerDuration = int.tryParse(value) ?? 0;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter duration in seconds',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (timerDuration > 0) {
                  startProgress();
                }
              },
              child: Text('Start'),
            ),
          ],
        );
      },
    );
  }

  void startProgress() {
    const updateInterval = 100; // Interval in milliseconds
    final progressIncrement = 1 / (timerDuration * 1000 / updateInterval);

    setState(() {
      progress = 0.0;
    });

    timer = Timer.periodic(Duration(milliseconds: updateInterval), (timer) {
      setState(() {
        progress += progressIncrement;
        if (progress >= 1.0) {
          timer.cancel();
        }
      });
    });
  }

  void cancelTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      setState(() {
        progress = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/${widget.workoutName}.png',
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black54,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Workout: ${widget.workoutName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            widget.description,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16.0),
          Container(
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
              title: Text(
                widget.workoutName,
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    'Progress',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: timer != null && timer!.isActive ? cancelTimer : startTimer,
            child: Text(timer != null && timer!.isActive ? 'Cancel' : 'Start'),
          ),
        ],
      ),
    );
  }
}
