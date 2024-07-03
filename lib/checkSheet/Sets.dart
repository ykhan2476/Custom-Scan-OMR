import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:omr_reader/checkSheet/answerkeytemplate.dart';
import 'package:omr_reader/checkSheet/pickimage.dart';

class Sets extends StatefulWidget {
  Map<String, dynamic> Template;
  List<int> questionsInSection;
  Sets({super.key, required this.Template,required this.questionsInSection});

  @override
  State<Sets> createState() => _SetsState();
}

class _SetsState extends State<Sets> {
  String _selectedSet ='A';
  String finalSet ='A';
  List<Map<String, dynamic>> AnswerKeys = [];
  List<String> Savedsets=[];


  @override
  void initState(){
    super.initState();
    
    _loadEventsFromHive(widget.Template);
    
  }

Future<void> _loadEventsFromHive(details) async {
    var box = await Hive.openBox('Answerkey');
    List<Map<String, dynamic>> events = [];
    List<String> sets = [];
    
    for (var key in box.keys) {
      if(key.contains('${details['totalmcq']}${details['posMarks']}${details['negMarks']}${details['totalquestions']}${details['totalColumns']}')){
      events.add(Map<String, dynamic>.from(box.get(key)));}
    }

    setState(() {
     AnswerKeys = events;
    });
    for(int i=0; i<AnswerKeys.length;i++){
      sets.add(AnswerKeys[i]['Set']);
    }
    setState(() {
     Savedsets = sets;
    });
    print(AnswerKeys);
  }


  @override
  Widget build(BuildContext context) {
  Map<String, dynamic> details = widget.Template;
    return Scaffold(body:SingleChildScrollView(child:Column(children: [

       SizedBox(height: 200,),
     Container(margin: EdgeInsets.all(20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Color.fromARGB(255,13,71,161))),
             child: Column(children: [
                Row(children: [
                 SizedBox(width: 50,),
                 Text("Add new Set",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color:Color.fromARGB(255,13,71,161) ),),
                 SizedBox(width: 50,),
                 DropdownButton<String>(value: _selectedSet,
                       onChanged: (String? newValue) {
                                  setState(() {_selectedSet = newValue!;});},
                     items: <String>['A', 'B', 'C', 'D','F','G','H'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value,child: Text('        $value'),);}).toList(),hint: Text('Select a set'), ),
             ],),
             
            Center(child:
            ElevatedButton(
              style:ElevatedButton.styleFrom(backgroundColor:Color.fromRGBO(255, 0, 22, 100),foregroundColor: Colors.white),
              onPressed: () {
                _loadEventsFromHive(details);
                print(details['totalColumns'].runtimeType);
                print(details['totalquestions'].runtimeType);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                 answerkeytemplate(totalSections: details['totalColumns'],
                                   questionsInSection:widget.questionsInSection,
                                    totalmcq:details['totalmcq'], posMarks:details['posMarks'], negMarks: details['negMarks'], totalquestions:details['totalquestions'], set: _selectedSet!,)));
           
              },
              child: Text('Generate Answer Key'), ), ),
              SizedBox(height: 10,),

             
             ],),),
           // for(int i=0;i<AnswerKeys.length;i++)Text('Set ${AnswerKeys[i]['Set']} saved '),
             
            SizedBox(height: 10,),


            DropdownButton<String>(
              value: finalSet,
              onChanged: (String? newValue) {
                setState(() {
                  finalSet = newValue!;
                });
              },
              items: Savedsets.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('        $value'),
                );
              }).toList(),
              hint: Text('Select from saved sets'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
            onPressed: (){
              int index=1;
              for(int i =0;i<AnswerKeys.length;i++){
                if(AnswerKeys[i]['Set']==finalSet){
                  setState(() {
                    index=i;
                  });
                }
              }
              print(AnswerKeys[index]['AnsKey']);
              String Ans= '${finalSet}${details['totalmcq']}${details['posMarks']}${details['negMarks']}${details['totalquestions']}${details['totalColumns']}';
              Navigator.push( context,MaterialPageRoute(builder: (context) =>ImagePickerScreen(AnsKey: AnswerKeys[index]['AnsKey'], totalmcq: details['totalmcq'], posMarks: details['posMarks'], negMarks: details['negMarks'], totalquestions: details['totalquestions'], totalColumns:details['totalColumns'],)),);

            }, 
            style:ElevatedButton.styleFrom(backgroundColor:Colors.blue[900],foregroundColor: Colors.white),
            child: Text('Check OMR Sheet'))


    ],)));
  }
}

