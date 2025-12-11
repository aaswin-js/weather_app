import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
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
      return data;

      // data["list"][0]['main']['temp'];
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
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          print(snapshot);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          
          final data = snapshot.data!;

          final currentdata = data["list"][0];
          final currentTemp = currentdata['main']['temp'];
          final currentWeather = currentdata['weather'][0]["main"];
          final currentWind = currentdata["wind"]["speed"];
          final currentPressure = currentdata['main']["pressure"];
          final currentHumidity = currentdata['main']['humidity'];
          print(currentHumidity);
          



          return Padding(
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
                                "$currentTemp K",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Icon( currentWeather== "Clouds" || currentWeather == "Rain" ? Icons.cloud : Icons.sunny, size: 64),
                              SizedBox(height: 16),
                              Text(currentWeather, style: TextStyle(fontSize: 32)),
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
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for(int i=0; i<5; i++)
                //         HourlyForcastItem(
                //         icon: data['list'][i+1]['weather'][0]["main"] == "Clouds" || data['list'][i+1]['weather'][0]["main"] == "Rain" ? Icons.cloud : Icons.sunny,
                //         time: data["list"][i+1]['dt'].toString(),
                //         temperature: data["list"][i+1]['main']['temp'].toString(),
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index){
                      final time = DateTime.parse(data["list"][index+1]['dt_txt']);

                      return HourlyForcastItem(
                        
                        icon: data['list'][index+1]['weather'][0]["main"] == "Clouds" || data['list'][index+1]['weather'][0]["main"] == "Rain" ? Icons.cloud : Icons.sunny,

                        
                        time:DateFormat.j().format(time),
                        temperature: data["list"][index+1]['main']['temp'].toString(),
                        );
                    },
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
                      value: "$currentHumidity",
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: "Wind Speed",
                      value: "$currentWind",
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: "pressure",
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
