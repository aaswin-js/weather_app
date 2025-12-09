import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather app",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter.grouped(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "300°F",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Icon(Icons.cloud, size: 64),
                          SizedBox(height: 16),
                          Text("Rain", style: TextStyle(fontSize: 32)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Weather Forcast
            Text("Weather Forcast", style: TextStyle(fontSize: 24)),
            SizedBox(height: 16),
            Row(
              children: [
                Card(
                  elevation: 6,
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "9:30",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Icon(Icons.cloud, size: 32),
                        SizedBox(height: 8),
                        Text(
                          "301.17",
                          style: TextStyle(
                            // fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 6,
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "9:30",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Icon(Icons.cloud, size: 32),
                        SizedBox(height: 8),
                        Text(
                          "301.17",
                          style: TextStyle(
                            // fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 6,
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "9:30",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Icon(Icons.cloud, size: 32),
                        SizedBox(height: 8),
                        Text(
                          "301.17",
                          style: TextStyle(
                            // fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //weather forcast cards
            const Placeholder(fallbackHeight: 150),
            SizedBox(height: 20),

            //additional information card
            const Placeholder(fallbackHeight: 150),
          ],
        ),
      ),
    );
  }
}
