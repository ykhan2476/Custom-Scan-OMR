import 'package:flutter/material.dart';
import 'package:omr_reader/Home/splash.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


//red Color.fromRGBO(255, 0, 22, 100)
//blue Color.fromARGB(255,13,71,161)

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory= await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
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
      
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
  
      home:splash(),
    );
  }
}

