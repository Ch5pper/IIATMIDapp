import 'package:flutter/material.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final String workoutName;
  final String description;

  const WorkoutDetailsScreen({
    required this.workoutName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutName),
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
                  'assets/images/$workoutName.png',
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
                      'Workout: $workoutName',
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
            '$description',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Start the workout timer
            },
            child: Text('Start'),
          ),
        ],
      ),
    );
  }
}
