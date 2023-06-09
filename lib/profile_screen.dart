import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final List<String> completedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Stappenteller profiel',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 30),
        Text(
          'Aantal stappen gezet: ',
          style: TextStyle(fontSize: 16),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: completedWorkouts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(completedWorkouts[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
