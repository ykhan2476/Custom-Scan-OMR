import 'package:flutter/material.dart';
import 'package:omr_reader/GenOmrExam/ShowOmrExam.dart';

class GenerateOmrExam extends StatefulWidget {
  const GenerateOmrExam({Key? key}) : super(key: key);

  @override
  State<GenerateOmrExam> createState() => _GenerateOmrExamState();
}

class _GenerateOmrExamState extends State<GenerateOmrExam> {
  int totalSections = 1;
  List<int> questionsInSection = [0];
  List<TextEditingController> questionsInSectionControllers = [TextEditingController()];
 
  final _formKey= GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController _RollNoController = TextEditingController();
  TextEditingController _classNameController = TextEditingController();
  TextEditingController posMarks = TextEditingController();
  TextEditingController negMarks = TextEditingController();
  
   int totalRollDigits = 0;
   String? _selectedSet;
   int totalmcq =4;



  @override
  void initState() {
    super.initState();
    // Initialize controllers for each section
    for (int i = 0; i < totalSections; i++) {
      questionsInSectionControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    for (var controller in questionsInSectionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse('http://omrapp.com/exam?id=123');
    //double hght = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Details'),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Row(children: [
                    Expanded(child: 
                    TextFormField(controller: _RollNoController,
                    decoration: InputDecoration(labelText: 'Roll No.'),
                    validator: (value) {if (value!.isEmpty) {return 'Please enter Roll No.';}return null;},),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      height: wid * 0.3,
                      width: wid * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('assets/images/onlineExam.jpeg'),
                    )
                  ],),
                 //SelectableText(url.toString(),style: TextStyle(fontSize: 16, color: Colors.blue),),
                 //  _buildCalendarDialogButton(),
                  TextFormField(controller: name,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {if (value!.isEmpty) {return 'Please Name';}return null;},),
                  TextFormField(controller: _classNameController,decoration: InputDecoration(labelText: 'Class'),),
                  Row(children: [ 
                    SizedBox(child: Text('Select Set'),),
                    SizedBox(width: 80,),
                    DropdownButton<String>(value: _selectedSet,
                       onChanged: (String? newValue) {
                                  setState(() {_selectedSet = newValue;});},
                     items: <String>['A', 'B', 'C', 'D'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value,child: Text('        $value'),);}).toList(),hint: Text('Select a set'), ),
                    ],),
                  Row(children: [ 
                    SizedBox(child: Text('total mcqs in question'),),
                    SizedBox(width: 5,),
                    DropdownButton<int>(value: totalmcq,
                       onChanged: (int? newValue) {
                                  setState(() {totalmcq = newValue!;});},
                     items: <int>[4,5].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(value: value,child: Text('        $value'),);}).toList(),hint: Text('Select a set'), ),
                    ],),
                    Row(children: [
                      Container(width: wid*0.3,child:
                           TextFormField(keyboardType:TextInputType.number,controller: posMarks,decoration: InputDecoration(labelText: 'Positive Marking',labelStyle: TextStyle(fontSize: 15) ),),),
                    SizedBox(width: 35,),
                    Container(width: wid*0.3,child:   
                       TextFormField(keyboardType:TextInputType.number,controller: negMarks,decoration: InputDecoration(labelText: 'Negative Marking',labelStyle: TextStyle(fontSize: 15)),),),
                    ],),

                   DropdownButtonFormField<int>(value: totalSections,
                        decoration: InputDecoration(labelText: 'Total Sections'),
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(value: index + 1,
                             child: Text('${index + 1}'),);
                          }),
                        onChanged: (value) {
                               setState(() {
                               totalSections = value!;
                               questionsInSection = List.generate(totalSections, (index) => index < questionsInSection.length ? questionsInSection[index] : 0);
                               questionsInSectionControllers = List.generate(totalSections, (index) => index < questionsInSectionControllers.length ? questionsInSectionControllers[index] : TextEditingController());
                                });
                                },
                      validator: (value) {
                          if (value == null) {
                               return 'Please select total sections';
                              }
                           return null;
                               },
                              ),
                      ListView.builder(
                     shrinkWrap: true,itemCount: totalSections,
                       itemBuilder: (context, index) {
                             return TextFormField(
                            controller: questionsInSectionControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Questions in Section ${index + 1}'),
                            validator: (value) {
                            if (value!.isEmpty) {
                                      return 'Please enter total questions in this section';
                                }
                               return null;
                                },
                             onChanged: (value) {
                                setState(() {
                                     questionsInSection[index] = int.tryParse(value) ?? 0;
                                  });
                              },
                             );
                               },
                            ),
                  Center(child:Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          int totalQuestions = questionsInSection.reduce((value, element) => value + element);
                          print('Class Name: ${_classNameController.text}');
                          print('Total Questions: $totalQuestions');
                          print(questionsInSection);
                          Navigator.push(context,MaterialPageRoute(builder: (context) => ShowOmrExam(
                                className: _classNameController.text,
                                totalSections: totalSections,
                                questionsInSection: questionsInSection,
                                Rollno: _RollNoController.text,
                                Name: name.text,
                                totalmcq: totalmcq, Set: _selectedSet,
                                posMarks:posMarks.text,negMarks:negMarks.text,
                              ),
                            ),
                          );
                        }
                      },
                      style:ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                      child: Text('Generate Exam',style: TextStyle(color: Colors.white),),
                    ),
                  ),)
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }


}