import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final List<String> completedInformation = [
    'Heart Rate',
    'Sleep Duration',
    'Step Count',
  ];

  final List<String> dataValues = [
    '80 bpm',
    '7 hours',
    '10,000 steps',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Container(
                width: 400, // Set the desired width for the upper widget
                height: 200,
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
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Dashboard',
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                      SizedBox(height: 16),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: 0.6, // Set the progress value (between 0.0 and 1.0)
                              strokeWidth: 10,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Text(
                            '60%',
                            style: TextStyle(fontSize: 24, color: Colors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 400, // Set the desired width for the lower widget
                height: 200,
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

              ),
              SizedBox(height: 16),
              Container(
                width: 400, // Set the desired width for the lower widget
                height: 200,
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: completedInformation.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(completedInformation[index]),
                      subtitle: Text(dataValues[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
