import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  int workoutDuration = 0;
  int restDuration = 0;
  int numReps = 0;
  Timer? timer;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void startTimer() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Zet de tijd duratie'),
          content: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    workoutDuration = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Vul de workout tijd in secondes',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    restDuration = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Vul de rust tijd in secondes',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    numReps = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Vul de aantal herhalingen',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (workoutDuration > 0 && restDuration > 0 && numReps > 0) {
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
    final workoutProgressIncrement =
        1 / (workoutDuration * 1000 / updateInterval);
    final restProgressIncrement = 1 / (restDuration * 1000 / updateInterval);
    int currentDuration = workoutDuration;
    bool isWorkout = true;
    int currentRep = 1;

    setState(() {
      progress = 0.0;
    });

    timer = Timer.periodic(Duration(milliseconds: updateInterval), (timer) {
      setState(() {
        progress += isWorkout ? workoutProgressIncrement : restProgressIncrement;
        if (progress >= 1.0) {
          if (isWorkout) {
            progress = 0.0;
            currentDuration = restDuration;
            isWorkout = false;
            showNotification('Rust', 'Rust tijd is voorbij!');
          } else {
            currentRep++;
            if (currentRep > numReps) {
              timer.cancel();
            } else {
              progress = 0.0;
              currentDuration = workoutDuration;
              isWorkout = true;
              showNotification('Workout', 'Volgende herhaling gaat van start!');
            }
          }
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
  void initState() {
    super.initState();
    initializeNotifications();
  }

  void initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'workout_channel_id',
      'Workout Channel',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
          Stack(
            children: [
              Container(
                height: 200,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${widget.workoutName}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            widget.description,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16.0),
          Text(
            'Workout timer',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Hieronder bevindt zich de workout timer. Stel jouw timer in op basis van hoe lang jij wilt trainen aan de gewilde workout. Test uit hoeveel herhalingen jij doet en daag jezelf uit!',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(height: 8.0),
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
