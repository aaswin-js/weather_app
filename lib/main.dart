import 'package:flutter/material.dart';
import 'package:weather_app/Weather_screen.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData.dark(useMaterial3: true ).copyWith(
        appBarTheme: AppBarTheme()
      ),
      home: const WeatherScreen(),
    );
  }
}