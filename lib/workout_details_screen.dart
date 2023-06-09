import 'package:flutter/material.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final String workoutName;

  const WorkoutDetailsScreen({required this.workoutName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutName),
      ),
      body: Center(
        child: Text(
          'Workout details voor $workoutName',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
