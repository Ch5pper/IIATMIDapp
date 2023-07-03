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
    'Push-ups': 'De push-up, in het Brits ook wel press-up genoemd, is een geweldige oefening, want je kan hem overal uitvoeren. Je hebt niets anders nodig dan je eigenlijk lichaamsgewicht. Dat maakt de oefening direct heel eenvoudig of misschien juist heel uitdagend. Je kan ongelooflijk veel kracht opbouwen door de push-up regelmatig te trainen.',
    'Squats': 'Een van de meest bekende én effectieve oefeningen bij bootcamp, CrossFit en calisthenics is zonder twijfel de squat. De squat is ideaal om in te zetten bij je training om spiermassa op te bouwen en overbodig lichaamsvet af te breken. Wil je daarop richten? Dan is dit de oefening voor jou! ',
    'Sit-ups': 'Sit-ups zijn een oefening voor de buikspieren die wordt uitgevoerd door op je rug te liggen met gebogen knieën en je voeten plat op de grond te plaatsen. Bij sit-ups gebruik je je buikspieren om je bovenlichaam op te tillen en naar voren te bewegen, richting je knieën. Terwijl je je bovenlichaam omhoog brengt, span je je buikspieren aan en gebruik je ze om de beweging te controleren.',
    'Lunges': 'De lunges helpen je om je onderlichaam te versterken en het uithoudingsvermogen van de spieren te verbeteren. Het is een fijne oefening voor de beginnende sporter, doordat bij deze oefening gemakkelijk de spieren in je onderlichaam trainen zonder al teveel spanning op de gewrichten.',
    'Plank': 'De plank is een van de bekendste stabiliserende oefeningen voor je core, waarbij je alleen je eigen lichaamsgewicht gebruikt om als plank te fungeren boven de grond. Met de vele plankvarianten waaruit al diverse plank-challenges zijn ontstaan, kun je eindeloos blijven planken. Thuis, in het park of tijdens een plank-challenge op kantoor, de plank is voor beginners tot experts.',
    'Jumping Jacks': 'Met de jumping jack maak je al jouw gewrichten los, waardoor deze oefening populair is als onderdeel van de warming-up.',
    'Burpees': 'Burpees zijn een explosieve calisthenics oefening die onder high intensity training (HIT) valt, vanwege de intensieve dynamiek tussen cardio en kracht. Daarmee kan je tot 50% meer vet verbranden dan standaard krachtoefeningen binnen de sport. Je stofwisseling wordt namelijk versneld door het doen van burpees, waardoor je ook na je volledige training en gedurende de dag blijft verbranden. ',
    'Mountain Climbers': 'Het idee van de mountain climbers is dat het lijkt alsof je een berg beklimt, maar dit is niet altijd mogelijk. Daarom wordt deze oefening op de vloer gedaan. In eerste instantie is de mountain climber een beweging voor beginners, maar door enkele variaties toe te passen wordt dit al gauw een gevorderde oefening.',
    'Pull-ups': 'Een pull-up (optrekken) is een oefening binnen calisthenics voor het bovenlichaam, die specifiek arm-, schouder-, rug- en buikspieren aanspreekt. Het doel bij de oefening is om jezelf op te trekken aan een stang, ringen of ander object waar jij je aan vast houdt boven je lichaam.',
    'Pistol squat': 'Een pistol squat is een uitdagende oefening voor de benen en de kernspieren waarbij je op één been hurkt met het andere been gestrekt voor je uit. Het wordt ook wel een "pistool squat" genoemd vanwege de gelijkenis met de houding van een pistool-schutter. Om een pistol squat correct uit te voeren, begin je rechtop te staan met je voeten ongeveer op heupbreedte uit elkaar. Til één been van de grond en strek het recht voor je uit. ',
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
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final workoutName = _searchResults[index];
              final category = widget.workoutCategories[workoutName] ?? '';
              final description =
                  widget.workoutDescriptions[workoutName] ?? '';
              final iconData = _getWorkoutIconData(category);

              return ListTile(
                leading: Icon(iconData),
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

  IconData _getWorkoutIconData(String category) {
    switch (category) {
      case 'Kracht':
        return Icons.fitness_center;
      case 'Balans':
        return Icons.accessibility_new ;
      case 'Uithoudingsvermogen':
        return Icons.directions_run;
    // Add more cases for other workout categories and their respective icons
      default:
        return Icons.fitness_center; // Default icon
    }
  }
}
