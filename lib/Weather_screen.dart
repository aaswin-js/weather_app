import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/Additional_info_item.dart';
import 'package:weather_app/hourly_forcast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      setState(() {
        isloading = true;
      });
      String location = "London";
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$location,uk&APPID=$openWeatherApi",
        ),
      );

      final data = jsonDecode(res.body);

      if (data["cod"] != "200") {
        throw "an unexpected error occured";
      }

      setState(() {
        temp = data["list"][0]['main']['temp'];
        isloading = false;
      });
    } catch (e) {
      throw e.toString();
    }
  }

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
      body: isloading
          ? const CircularProgressIndicator()
          : Padding(
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
                                  "$temp K",
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyForcastItem(
                          icon: Icons.cloud,
                          time: "00:00",
                          temperature: "301.17",
                        ),
                        HourlyForcastItem(
                          icon: Icons.sunny,
                          time: "03:00",
                          temperature: "301.17",
                        ),
                        HourlyForcastItem(
                          icon: Icons.cloud,
                          time: "00:00",
                          temperature: "301.17",
                        ),
                        HourlyForcastItem(
                          icon: Icons.cloud,
                          time: "00:00",
                          temperature: "301.17",
                        ),
                        HourlyForcastItem(
                          icon: Icons.cloud,
                          time: "00:00",
                          temperature: "301.17",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  //additional information card
                  Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  Row(
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: "91",
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: "7.61",
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: "pressure",
                        value: "1006",
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
