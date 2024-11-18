import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:greentools/firebase_options.dart';

import 'package:greentools/crop/presentation/views/home_screen.dart';

import 'package:greentools/profile/presentation/views/welcome_screen.dart';
import 'package:greentools/profile/presentation/views/login_screen.dart';
import 'package:greentools/profile/presentation/views/register_screen.dart';
import 'package:greentools/profile/presentation/views/profile_screen.dart';

import 'package:greentools/loan/presentation/views/add_station_screen.dart';
import 'package:greentools/loan/presentation/views/add_plant_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: 'welcome',
      routes: {
        'home': (context) => HomeScreen(),
        'profile': (context) => ProfileScreen(),

        'welcome': (context) => WelcomeScreen(),
        'login': (context) => LoginScreen(),
        'register': (context) => SignUpScreen(),

        'addStation': (context) => AddStationScreen(),
        'addPlant': (context) => AddPlantScreen(),
      },
    );
  }
}


