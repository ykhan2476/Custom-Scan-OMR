import 'package:flutter/material.dart';
import 'package:omr_reader/GenOmrExam/ResultPage.dart';

class generateAnsKey extends StatefulWidget {
  final List<List<int>> submittedOptions;
  final int totalSections2;
  final List<int> questionsInSection2;
  final List<String> details;
  final int totalmcq;

  const generateAnsKey({Key? key, 
    required this.submittedOptions,
    required this.totalmcq,
    required this.details,
    required this.totalSections2,
    required this.questionsInSection2,}) : super(key: key);

  @override
  State<generateAnsKey> createState() => _generateAnsKeyState();
}

class _generateAnsKeyState extends State<generateAnsKey> {
  late List<List<int>> selectedAnsOptions; // List of selected options for each section
  late List<List<int>> submittedAnsOptions; //List of submitted options of answer key
  late int sections;
  late List<String> optionslist;
  late List<int> questions;
  late double hght;
  late double wid;
  late List<List> FinalAnsKey=[];
  int score=0; 
  

  @override
  void initState() {
    super.initState();
    sections = widget.totalSections2;
    optionslist = ['A', 'B', 'C', 'D', 'E','F','G','H'];
    questions = widget.questionsInSection2;
    selectedAnsOptions = List.generate(sections, (_) => List.filled(questions.fold<int>(0, (prev, curr) => prev + curr), 0));
    submittedAnsOptions = List.generate(sections, (_) => List.filled(questions.fold<int>(0, (prev, curr) => prev + curr), 0)); // Initialize with -1
  
  }

  checkResult(posMarks, negMarks) {
    int correctAnswers = 0;
  int wrongAnswers = 0;
  print(questions);
  for (int i = 0; i < submittedAnsOptions.length; i++) {
    for (int j = 0; j < submittedAnsOptions[i].length; j++) {
      if (widget.submittedOptions[i][j] != submittedAnsOptions[i][j] &&
          widget.submittedOptions[i][j] != 0) {
        setState(() {
          score -= negMarks as int;
          wrongAnswers++; // Increment wrong answer count
        });
      }
      if (widget.submittedOptions[i][j] == submittedAnsOptions[i][j] &&
          widget.submittedOptions[i][j] != 0) {
        setState(() {
          score += posMarks as int;
          correctAnswers++; // Increment correct answer count
        });
      }
    }
  }
  setState(() {
    widget.details[9] = score.toString();
    widget.details[10]=correctAnswers.toString();
    widget.details[11]=wrongAnswers.toString();
      });
  print("Score: $score");
  print("Correct Answers: $correctAnswers");
  print("Wrong Answers: $wrongAnswers");
}


AnsKey(oldAnsKey){
     late List<List> FinalAnsKey=[];
    print("questions${questions}");
    for (int i=0; i<questions.length;i++){
      List<int> newAnsKey = oldAnsKey[i].sublist(0, questions[i]);
      List<int> modifiedList = newAnsKey.map((element) => element - 1).toList();
      FinalAnsKey.add(modifiedList);
    }
    print(FinalAnsKey);
    return FinalAnsKey;
  }


bool allQuestionsAnswered() {
  for (int i = 0; i < FinalAnsKey.length; i++) {
   
      if (FinalAnsKey[i].contains(-1)) {
        return false;
      }}
  
    return true;
  }

  void showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Incomplete Submission"),
          content: Text("Please fill  each answer in the AnswerKey "),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
   Widget build(BuildContext context) {
    widget.details.add(submittedAnsOptions.length.toString());
    hght = MediaQuery.of(context).size.height;
    wid = MediaQuery.of(context).size.width;
    int posMarks= int.parse(widget.details[5]);
    int negMarks= int.parse(widget.details[6]);
    //List<int> quesDetails=[];
    return Scaffold(
     appBar: AppBar(title: Text('Answer Key'),),
      body: 
      SingleChildScrollView(scrollDirection: Axis.vertical,child: 
      Container(
          margin: EdgeInsets.all((10)),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              for (int i = 0; i < sections; i++)
              Center(child:
                  Column(
                  children: [
                    Container(
                      child: Text('SECTION ${i + 1}',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18)),
                    ),
                    
                    
               for (int index = 0; index < questions[i]; index++)
                Container(child: Column( children: [
                  Container(height: wid * 0.13,child: Row(
                  mainAxisSize: MainAxisSize.min,children: [
                    Container(padding: EdgeInsets.only(top:10,right: 10),height: wid * 0.115,child: Text("${index+1}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                    for (int j = 0; j < widget.totalmcq; j++)
                      MaterialButton(height: wid * 0.115,minWidth: 5,
                        color: selectedAnsOptions[i][index] == j + 1 ? Colors.black  : Colors.white,
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: selectedAnsOptions[i][index] == j + 1? Colors.black : Colors.pink, ),),
                        onPressed: () {setState(() { selectedAnsOptions[i][index] = j + 1; }); },
                        child: Text(optionslist[j], style: TextStyle(
                            color: selectedAnsOptions[i][index] == j + 1? Colors.white: Colors.pink,),),)
                  ],),
              ),],),),



                  ],
                ), ),
              ElevatedButton(onPressed: (){
                //selectedAnsOptions = List.from(submittedAnsOptions);
                submittedAnsOptions = List.from(selectedAnsOptions);
                print(widget.submittedOptions);
                print(submittedAnsOptions);
                FinalAnsKey= AnsKey(submittedAnsOptions);
                print(FinalAnsKey);
                checkResult(posMarks,negMarks);
               print(widget.details);
                setState(() {
                  score=0;
                });
               

                if (allQuestionsAnswered()) {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>ResultPage(details: widget.details) ));

              }
              else{
                  showWarningDialog(context);
              }

              }, 
              style:ElevatedButton.styleFrom(backgroundColor: Colors.blue[900],foregroundColor: Colors.white),
              child: Text('CHECK RESULT'))
            ],
          ),
        ),
      ),
    );
  }
}