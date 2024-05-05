import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omr_reader/checkSheet/pickimage.dart';

class answerkeytemplate extends StatefulWidget {

  final int totalSections;
  final int totalmcq;
  final List<int> questionsInSection;
  final String posMarks;
  final String negMarks;

  const answerkeytemplate({
    Key? key,
    required this.posMarks,
    required this.negMarks,
    required this.totalSections,
    required this.totalmcq,
    required this.questionsInSection,
  }) : super(key: key);

  @override
  State<answerkeytemplate> createState() => _answerkeytemplateState();
}

class _answerkeytemplateState extends State<answerkeytemplate> {
  late List<List<int>> selectedOptions; // List of selected options for each section
  late List<List<int>> submittedOptions; 
  late int sections;
  late List<String> optionslist;
  late List<int> questions;
  late double hght;
  late double wid;
  String date = '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

  @override
  void initState() {
    super.initState();
    sections = widget.totalSections;
    optionslist = ['A', 'B', 'C', 'D', 'E','F','G','H','I','J'];
    questions = widget.questionsInSection;
    submittedOptions = List.generate(sections, (_) => List.filled(questions.fold<int>(0, (prev, curr) => prev + curr), -1)); // Initialize with -1
    selectedOptions = List.generate(sections, (_) => List.filled(questions.fold<int>(0, (prev, curr) => prev + curr), 0));

  }

  @override
  Widget build(BuildContext context) {
    int totalQuestions = widget.questionsInSection.reduce((value, element) => value + element);
    hght = MediaQuery.of(context).size.height;
    wid = MediaQuery.of(context).size.width;
    List<String> details =[widget.posMarks,widget.negMarks,totalQuestions.toString()];
    return Scaffold(
      body: 
      SingleChildScrollView(scrollDirection: Axis.vertical,child: 
      Container(margin:EdgeInsets.all(widget.totalmcq>5?  wid*0.3/widget.totalmcq : wid*0.6/widget.totalmcq),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
    Container(child: Column(children: [
    SizedBox(height: 40,),
     Container(child: Text('Answer Key ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),),
    for (int i = 0; i < sections; i++)
     Column(children: [
      SizedBox(height: 20,),
      Container(child: Text('Column ${i + 1}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
      for (int index = 0; index < questions[i]; index++)
        Container(child: Column( children: [
              Container(height: wid * 0.13,child: Row(
                  mainAxisSize: MainAxisSize.min,children: [
                    Container(padding: EdgeInsets.only(top:10,right: 10),height: wid * 0.115,child: Text("${index+1}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                    for (int j = 0; j < widget.totalmcq; j++)
                      MaterialButton(height: wid * 0.115,minWidth: 5,
                        color: selectedOptions[i][index] == j + 1 ? Colors.black  : Colors.white,
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: selectedOptions[i][index] == j + 1? Colors.black : Colors.pink, ),),
                        onPressed: () {setState(() { selectedOptions[i][index] = j + 1; }); },
                        child: Text(optionslist[j], style: TextStyle(
                            color: selectedOptions[i][index] == j + 1? Colors.white: Colors.pink,),),)
                  ],),
              ),],),),], ),
              ElevatedButton(onPressed: (){  
                submittedOptions = List.from(selectedOptions);
                print(submittedOptions);
                Navigator.push( context,MaterialPageRoute(builder: (context) =>ImagePickerScreen()),);
              },
              style:ElevatedButton.styleFrom(backgroundColor: Colors.blue[900],foregroundColor: Colors.white), 
              child: Text('SUBMIT'))
              
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
