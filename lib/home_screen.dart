import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:perryapp/search_screen.dart';
import 'workout_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchScreen searchScreen = SearchScreen();

    return Column(
      children: [
        SizedBox(height: 20),
        Column(
          children: [
            Text(
              'Welkom bezoeker !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 270,
                  decoration: BoxDecoration(
                    color: Colors.red, // Color of the left widget
                    borderRadius: BorderRadius.circular(8.0), // Set the desired border radius
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
                    alignment: Alignment.topCenter, // Align the text to the top center
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Finished',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    Container(
                      width: 200,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.blue, // Color of the top right widget
                        borderRadius: BorderRadius.circular(8.0), // Set the desired border radius
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
                        alignment: Alignment.topCenter, // Align the text to the top center
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'In progress',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.green, // Color of the bottom right widget
                        borderRadius: BorderRadius.circular(8.0), // Set the desired border radius
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
                        alignment: Alignment.topCenter, // Align the text to the top center
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Time spent',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Ontdek nieuwe workouts',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Container(
          height: 200, // Set the desired height for the carousel
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
                      borderRadius: BorderRadius.circular(8.0), // Set the desired border radius
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            String workoutName = workout;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutDetailsScreen(workoutName: workoutName),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Align(
                                  alignment: Alignment.topCenter, // Align the text to the top center
                                  child: Text(
                                    workout,
                                    style: TextStyle(fontSize: 24.0, color: Colors.blue), // Set the desired label color
                                  ),
                                ),
                              ),
                              Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1eB3klkz4zfss4fwdszfl1W40sYI2vdWWPQ&usqp=CAU', // Replace with your actual thumbnail image URL
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
      ],
    );
  }
}
