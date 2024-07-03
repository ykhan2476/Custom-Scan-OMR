import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SavedExams extends StatefulWidget {
  const SavedExams({super.key});

  @override
  State<SavedExams> createState() => _SavedExamsState();
}

class _SavedExamsState extends State<SavedExams> {
  List<List<dynamic>> ansKey =[[]];
  List<Map<String, dynamic>> Results = [];

  @override
  void initState(){
    super.initState();
    _loadEventsFromHive();
     
  }
  
Future<void> _loadEventsFromHive() async {
  var box = await Hive.openBox('ResultMap');
  List<Map<String, dynamic>> events = [];
  for (var key in box.keys) {
    Map<String, dynamic> event = Map<String, dynamic>.from(box.get(key));
    events.add(event);
  }
  setState(() {
    Results = events;
  });
  print(Results);
}

  

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        
        body: SafeArea(child:Container(margin: EdgeInsets.all(15),child: SingleChildScrollView(child:Column(children: [
          Text('Saved Exam Results',style: TextStyle(color: Colors.blue,fontSize: 25),),
          for(int i =0;i<Results.length;i++)
          GestureDetector(onTap: (){
            },child:
          Card(elevation: 5,margin: EdgeInsets.only(top:30), // Adjust elevation as needed
            child: Container(margin:EdgeInsets.all(10),
              width: wid,height: wid*0.5, 
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), // Same as card's border radius
                ),
              child: Column(children:[
                  SizedBox(height: 20),
                   Row(children: [
                    SizedBox(width: wid*0.4,child: Text('Name:  ${Results[i]['Name']}')),
                    Text('Roll_no.: ${Results[i]['Roll_no.']}'),
                   ],),
                   SizedBox(height: 20),
                   Row(children: [
                    Text('Date:  ${Results[i]['Date']}'),
                    SizedBox(width: 20),
                    Text('Set: ${Results[i]['Set']}'),
                    SizedBox(width: 20),
                    Text('Class: ${Results[i]['Class']}'),
                   ],),
                   SizedBox(height: 20),
                    Row(children: [
                    SizedBox(width: wid*0.4,child: Text('Total Marks:  ${Results[i]['Total_Marks']}')),
                    Text('Marks Obtained: ${Results[i]['MarksObtained']}'),
                   ],),
                   SizedBox(height: 20),
                   Row(children: [
                    SizedBox(width: wid*0.4,child: Text('Percentage:  ${Results[i]['Percentage']}')),
                    Text('Accuracy: ${Results[i]['Accuracy']}'),
                   ],),
                   
                    ]),

            ),),),
          
        ],))
        )
      )),
    );
  }
}