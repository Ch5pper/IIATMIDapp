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
              hintText: 'Zoek voor een workout...',
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
              return ListTile(
                title: Text(_searchResults[index]),
                onTap: () {
                  String workoutName = _searchResults[index];
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
