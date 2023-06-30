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
    'Pull-ups',
    'Pistol squat',
  ];

  final Map<String, String> workoutCategories = {
    'Push-ups': 'Kracht',
    'Squats': 'Balans',
    'Sit-ups': 'Kracht',
    'Lunges': 'Balans',
    'Plank': 'Uithoudingsvermogen',
    'Jumping Jacks': 'Uithoudingsvermogen',
    'Burpees': 'Uithoudingsvermogen',
    'Mountain Climbers': 'Uithoudingsvermogen',
    'Pull-ups': 'Kracht',
    'Pistol squat': 'Balans',
  };

  final Map<String, String> workoutDescriptions = {
    'Push-ups': 'Opdrukken, ook wel push-ups is een calisthenics krachttraining.',
    'Squats': 'Een squat is een kniebuiging, meestal met extra weerstand.',
    'Sit-ups': 'De sit-up valt onder de krachttraining op de versterking van de buikspieren.',
    'Lunges': 'De lunge is een fitness-oefening die individueel en bij groepslessen gedaan wordt.',
    'Plank': 'Planking of planken is een statische fitnessoefening om de rompstabiliteit te trainen.',
    'Jumping Jacks': 'een fysieke springoefening die wordt uitgevoerd door naar een bepaalde positie te springen.',
    'Burpees': 'De burpee is een combinatie-oefening die gebruikt wordt bij fitness.',
    'Mountain Climbers': 'De mountain climber is een fitnessoefening voor het hele lichaam, waarbij de nadruk ligt op je core. ',
    'Pull-ups': 'optrekken, een oefening om vooral de armen en de rugspieren te trainen.',
    'Pistol squat': 'Een pistol squat is een unilaterale squat op één been, waarbij je je andere been voor je uit strekt.',
  };

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  List<String> _searchResults = [];
  List<String> _selectedCategories = [];

  void _performSearch(String searchText) {
    setState(() {
      _searchText = searchText;
      _searchResults = widget.workouts.where((workout) {
        final workoutName = workout.toLowerCase();
        final category = widget.workoutCategories[workout];
        final categoryMatches =
            _selectedCategories.isEmpty || _selectedCategories.contains(category);
        return workoutName.contains(searchText.toLowerCase()) && categoryMatches;
      }).toList();
    });
  }

  void _navigateToWorkoutDetails(String workoutName) {
    final description = widget.workoutDescriptions[workoutName] ?? '';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutDetailsScreen(
          workoutName: workoutName,
          description: description,
        ),
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
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.workoutCategories.values.toSet().length,
            itemBuilder: (context, index) {
              final category =
              widget.workoutCategories.values.toSet().toList()[index];
              final isSelected = _selectedCategories.contains(category);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedCategories.add(category);
                      } else {
                        _selectedCategories.remove(category);
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: _searchResults.length,
            separatorBuilder: (context, index) => Divider(), // <-- Divider between each ListTile
            itemBuilder: (context, index) {
              final workoutName = _searchResults[index];
              final category = widget.workoutCategories[workoutName] ?? '';
              final description =
                  widget.workoutDescriptions[workoutName] ?? '';

              return ListTile(
                title: Text(workoutName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category),
                    Text(description),
                  ],
                ),
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
