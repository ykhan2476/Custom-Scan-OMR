import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omr_reader/GenOmrExam/GenerateOmrExam.dart';
import 'package:omr_reader/GenOmrExam/ShowOmrExam.dart';
import 'package:omr_reader/home.dart';
import 'package:omr_reader/ScanOmr/pickimage.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException, MethodChannel;
import 'package:flython/flython.dart';

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
      home:home(),
    );
  }
}

