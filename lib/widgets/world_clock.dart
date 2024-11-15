// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class WorldClock extends StatefulWidget {
  const WorldClock({super.key});

  @override
  _WorldClockState createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  late Timer _timer;
  String _time = '';
  String _date = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));
    final timeFormat = DateFormat('hh:mm:ss a');
    final dateFormat = DateFormat('EEEE, d MMMM yyyy');
    final formattedTime = timeFormat.format(now);
    final formattedDate = dateFormat.format(now);

    setState(() {
      _time = formattedTime;
      _date = formattedDate;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _time,
            style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 151, 11, 48), // Color of the time text
              fontWeight: FontWeight.bold, // Make the text bold
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 0.0), // Space between time and date
          Text(
            _date,
            style: const TextStyle(
              fontSize: 20, // Reduced font size for date
              color: Color.fromARGB(255, 29, 7, 90),// Color of the date text
              fontWeight: FontWeight.bold, 
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

