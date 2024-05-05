import 'package:flutter/material.dart';
import 'package:omr_reader/widget/animation.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   //cawait initUniLinks();
   //Flython.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:animation(),
    );
  }
}

