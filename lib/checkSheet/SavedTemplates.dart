import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:omr_reader/checkSheet/pickimage.dart';

class SavedTemplates extends StatefulWidget {
  const SavedTemplates({Key? key}) : super(key: key);

  @override
  _SavedTemplatesState createState() => _SavedTemplatesState();
}

class _SavedTemplatesState extends State<SavedTemplates> {
 List<List<dynamic>> ansKey =[[]];
  List<Map<String, dynamic>> AnswerKeys = [];

  @override
  void initState(){
    super.initState();
    _loadEventsFromHive();
     
  }
  

  
Future<void> _loadEventsFromHive() async {
  var box = await Hive.openBox('Answerkey');
  List<Map<String, dynamic>> events = [];
  for (var key in box.keys) {
    Map<String, dynamic> event = Map<String, dynamic>.from(box.get(key));
    List<dynamic> ansKey = event['AnsKey'];
    event['AnsKey'] = ansKey.map((e) => e as List<dynamic>).toList();
    
    events.add(event);
  }
  setState(() {
    AnswerKeys = events;
  });
  print(AnswerKeys);
}

  

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hght = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        
        body: SafeArea(child:Container(margin: EdgeInsets.all(30),child: SingleChildScrollView(child:Column(children: [
          Text('Saved Templates',style: TextStyle(color: Colors.blue,fontSize: 25),),
          for(int i =0;i<AnswerKeys.length;i++)
          GestureDetector(onTap: (){
            if (AnswerKeys[i]['AnsKey'].runtimeType!= List<List<dynamic>>){
              setState(() {
                List<dynamic> dynamicList = AnswerKeys[i]['AnsKey'];
                ansKey = dynamicList.cast<List<dynamic>>();
              });
            }
            else{
               ansKey =AnswerKeys[i]['AnsKey'];
            }
            Navigator.push( context,MaterialPageRoute(builder: (context) =>ImagePickerScreen(AnsKey: ansKey, totalmcq: AnswerKeys[i]['totalmcq'], posMarks: AnswerKeys[i]['posMarks'], negMarks: AnswerKeys[i]['negMarks'], totalquestions: AnswerKeys[i]['totalquestions'], totalColumns:AnswerKeys[i]['totalColumns'],)),);
            },child:
          Card(elevation: 5, // Adjust elevation as needed
            child: Container(margin:EdgeInsets.all(10),
              width: wid,height: wid*0.36, 
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), // Same as card's border radius
                ),
              child: Column(children:[
                  SizedBox(height: 20),
                   Row(children: [
                
                    SizedBox(width: wid*0.4,child: Text('Set:  ${AnswerKeys[i]['Set']}')),
                    Text('Total mcqs ${AnswerKeys[i]['totalmcq']}'),
                   ],),
                   Row(children: [
                    
                    SizedBox(width: wid*0.4,child: Text('+ Marking : ${AnswerKeys[i]['posMarks']}')),
                    Text('- Marking : ${AnswerKeys[i]['negMarks']}'),
                   ],),
                   Row(children: [
                  
                    SizedBox(width: wid*0.4,child: Text('Total Questions :${AnswerKeys[i]['totalquestions']}')),
                    Text('Total Columns :${AnswerKeys[i]['totalColumns']}'),
                   ],),
                    Row(children:[
                      SizedBox(width: wid*0.5,),
                      IconButton(onPressed: (){}, icon:Icon(Icons.arrow_forward_rounded,color: Color.fromRGBO(255, 0, 22, 100),))
                    ])
                    ]),

            ),),),
          
        ],))
        )
      )),
    );
  }
}

 