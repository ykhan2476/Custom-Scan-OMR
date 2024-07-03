import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omr_reader/checkSheet/CreateTemplate.dart';
import 'package:omr_reader/checkSheet/SavedTemplates.dart';

class ShowTemplates extends StatefulWidget {
  const ShowTemplates({super.key});

  @override
  State<ShowTemplates> createState() => _ShowTemplatesState();
}

class _ShowTemplatesState extends State<ShowTemplates> {

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hght = MediaQuery.of(context).size.height;
    return Scaffold(body: 
    SafeArea(child:
    Container(width: wid,
              height: hght,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg1.png'), // replace with your image path
                  fit: BoxFit.cover,
                ),
              ),child: 
    Column(children: [
      SizedBox(height: 250,),
      ElevatedButton(
        onPressed: (){
          Navigator.push( context,MaterialPageRoute(builder: (context) =>CreateTemplate()),);
        },
        style:ElevatedButton.styleFrom(backgroundColor:Color.fromARGB(255,13,71,161),foregroundColor: Colors.white), 
        child: Text('Create New Template')),
        SizedBox(height: 20),
        ElevatedButton(
        onPressed: (){
          Navigator.push( context,MaterialPageRoute(builder: (context) =>SavedTemplates()),);
        },
        style:ElevatedButton.styleFrom(backgroundColor:Color.fromARGB(255,13,71,161),foregroundColor: Colors.white), 
        child: Text('Use Saved Templates')),
        SizedBox(height: 20),

    ],)),),);
  }
}



