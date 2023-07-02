import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:perryapp/search_screen.dart';
import 'workout_details_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Map<String, int> workoutDurations = {
    'Push-ups': 5,
    'Squats': 7,
    'Sit-ups': 3,
    'Lunges': 8,
    'Plank': 4,
    'Jumping Jacks': 6,
    'Burpees': 9,
    'Mountain Climbers': 7,
    'Pull-ups': 10,
    'Pistol squat': 12,
  };

  List<String> completedWorkouts = [];
  String timeSpent = '0 minuten';
  List<String> quotes = [];
  String currentQuote = '';

  @override
  void initState() {
    super.initState();
    fetchAndSetQuotes();
    setupQuoteTimer();
  }

  Future<void> fetchAndSetQuotes() async {
    try {
      final response = await http.get(Uri.parse('https://type.fit/api/quotes'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          quotes = data.map((item) => item['text']).cast<String>().toList();
          currentQuote = quotes.isNotEmpty ? quotes[0] : '';
        });
      } else {
        throw Exception('Failed to fetch quotes');
      }
    } catch (error) {
      print('Error fetching quotes: $error');
    }
  }

  void updateTimeSpent() {
    int totalTime = completedWorkouts.fold(0, (total, workout) => total + workoutDurations[workout]!);
    setState(() {
      timeSpent = '$totalTime minuten';
    });
  }

  void setupQuoteTimer() {
    Timer.periodic(Duration(hours: 24), (timer) {
      if (quotes.isNotEmpty) {
        setState(() {
          currentQuote = quotes[DateTime.now().day % quotes.length];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final SearchScreen searchScreen = SearchScreen();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Welkom bezoeker!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        width: 180,
                        height: 270,
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Planning',
                                style: TextStyle(fontSize: 20, color: Colors.blue),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: completedWorkouts.length,
                                itemBuilder: (context, index) {
                                  final workout = completedWorkouts[index];
                                  return ListTile(
                                    title: Text(workout),
                                    subtitle: Text('${workoutDurations[workout]} minuten'),
                                  );
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (completedWorkouts.length < 4) {
                                  final remainingWorkouts = workouts.where((workout) => !completedWorkouts.contains(workout)).toList();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Kies een oefening.'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: remainingWorkouts.map((workout) {
                                              return ListTile(
                                                title: Text(workout),
                                                onTap: () {
                                                  setState(() {
                                                    completedWorkouts.add(workout);
                                                    updateTimeSpent();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Gefeliciteerd !'),
                                        content: Text('Je hebt vandaag 4 oefeningen gepland.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                completedWorkouts.clear();
                                                updateTimeSpent();
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text('Toevoegen'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      children: [
                        Container(
                          width: 180,
                          height: 130,
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
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Quote van vandaag',
                                    style: TextStyle(fontSize: 20, color: Colors.blue),
                                  ),
                                  SizedBox(height: 8),
                                  Expanded(
                                    child: Text(
                                      currentQuote,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: 180,
                          height: 120,
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
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Trainings tijd',
                                    style: TextStyle(fontSize: 20, color: Colors.blue),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    timeSpent,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Ontdek nieuwe workouts',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: searchScreen.workouts.map((workout) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Card(
                              color: Colors.blue,
                              child: InkWell(
                                onTap: () {
                                  String workoutName = workout;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkoutDetailsScreen(
                                        workoutName: workoutName,
                                        description: 'Description of $workoutName',
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          workout,
                                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1eB3klkz4zfss4fwdszfl1W40sYI2vdWWPQ&usqp=CAU',
                                      width: MediaQuery.of(context).size.width,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
