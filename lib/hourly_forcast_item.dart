import 'package:flutter/material.dart';

class HourlyForcastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const HourlyForcastItem({
    super.key,
    required this.icon,
    required this.time,
    required this.temperature,
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Icon(icon, size: 32),
            SizedBox(height: 8),
            Text(
              temperature,
              style: TextStyle(
                // fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
