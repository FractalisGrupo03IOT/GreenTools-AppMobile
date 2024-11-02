import 'package:flutter/material.dart';

import 'package:greentools/crop/presentation/views/flowerpot_metrics_screen.dart';
import 'package:greentools/crop/presentation/views/flowerpots_screen.dart';
import 'package:greentools/crop/presentation/views/crop_screen.dart';
import 'package:greentools/crop/presentation/views/flowerpot_detail_screen.dart';
import 'package:greentools/crop/presentation/widgets/card_crop_simple.dart';


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
      initialRoute: 'flowerpots',
      routes: {
        'home': (context) => CropsScreen(),
        'flowerpots': (context) => FlowerpotsScreen(),
        'potdetail': (context) => FlowerpotDetailScreen(),
        'flowerpot_metrics': (context) => FlowerpotMetricsScreen(),
      },
    );
  }
}


