import 'package:flutter/material.dart';
import 'package:perryapp/workout_details_screen.dart';

class SearchScreen extends StatefulWidget {
  final List<String> workouts = [
    'Push-ups',
    'Squats',
    'Sit-ups',
    'Lunges',
    'Plank',
    'Jumping Jacks',
    'Burpees',
    'Mountain Climbers',
    'High Knees',
    'Bicycle Crunches',
  ];

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  List<String> _searchResults = [];
  Map<String, String> _workoutSecondaryText = {
    'Push-ups': 'Secondary Text 1',
    'Squats': 'Secondary Text 2',
    'Sit-ups': 'Secondary Text 3',
    'Lunges': 'Secondary Text 4',
    'Plank': 'Secondary Text 5',
    'Jumping Jacks': 'Secondary Text 6',
    'Burpees': 'Secondary Text 7',
    'Mountain Climbers': 'Secondary Text 8',
    'High Knees': 'Secondary Text 9',
    'Bicycle Crunches': 'Secondary Text 10',
  };

  void _performSearch(String searchText) {
    setState(() {
      _searchText = searchText;
      _searchResults = widget.workouts
          .where((workout) =>
          workout.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void _navigateToWorkoutDetails(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutDetailsScreen(workoutName: workoutName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for a workout...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: _performSearch,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final workoutName = _searchResults[index];
              final secondaryText = _workoutSecondaryText[workoutName] ?? '';

              return ListTile(
                title: Text(workoutName),
                subtitle: Text(secondaryText),
                onTap: () {
                  _navigateToWorkoutDetails(workoutName);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
