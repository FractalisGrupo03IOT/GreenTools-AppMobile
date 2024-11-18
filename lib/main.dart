import 'package:flutter/material.dart';

import 'package:greentools/crop/presentation/views/flowerpot_metrics_screen.dart';
import 'package:greentools/crop/presentation/views/flowerpot_detail_screen.dart';
import 'package:greentools/crop/presentation/views/home_screen.dart';
import 'package:greentools/profile/presentation/views/welcome_screen.dart';
import 'package:greentools/loan/presentation/views/add_station_screen.dart';
import 'package:greentools/loan/presentation/views/add_plant_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenTools',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: 'potdetail',
      routes: {
        'home': (context) => HomeScreen(),
        'welcome': (context) => WelcomeScreen(),
        'addStation': (context) => AddStationScreen(),
        'addPlant': (context) => AddPlantScreen(),
        'potdetail': (context) => FlowerpotDetailScreen(),
        'flowerpot_metrics': (context) => FlowerpotMetricsScreen(),
      },
    );
  }
}


