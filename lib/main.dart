import 'package:flutter/material.dart';

void main() {
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
      initialRoute: 'home',
      routes: {

      },
    );
  }
}


