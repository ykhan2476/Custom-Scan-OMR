
import 'package:flutter/material.dart';
import 'package:omr_reader/GenSheetUIOptional/showSheet.dart';
import 'package:omr_reader/CreateOmrPdf/CreateOmrPdf.dart';


class GenSheet extends StatefulWidget {
  const GenSheet({Key? key}) : super(key: key);

  @override
  State<GenSheet> createState() => _GenSheetState();
}

class _GenSheetState extends State<GenSheet> {
  int totalSections = 10;
  List<int> questionsInSection = [];
  late List<String> optionslist;
  final _formKey= GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController _RollNoController = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController _headingController = TextEditingController();
  TextEditingController _subheadingController = TextEditingController();
  TextEditingController _classNameController = TextEditingController();
  List<TextEditingController> questionsInSectionControllers = [];
   int totalRollDigits = 0;
   String? _selectedSet;
   CreateOmrPdf createpdf =CreateOmrPdf();



  @override
  void initState() {
    super.initState();
    optionslist = ['A', 'B', 'C', 'D', 'E'];
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
    //List<String> capitalLetters = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
    double hght = MediaQuery.of(context).size.height;
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
                    Container(
                      height: wid * 0.3,
                      width: wid * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('assets/images/b1.jpeg'),
                    ),SizedBox(width: 10,),
                    Expanded(child: 
                    TextFormField(controller: _RollNoController,
                    decoration: InputDecoration(labelText: 'Roll No.'),
                    validator: (value) {if (value!.isEmpty) {return 'Please enter Roll No.';}return null;},),
                    )
                  ],),
                  TextFormField(controller: name,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {if (value!.isEmpty) {return 'Please Name';}return null;},),
                  TextFormField(controller: _headingController,decoration: InputDecoration(labelText: 'Heading.'),),
                  TextFormField(controller: _subheadingController,decoration: InputDecoration(labelText: 'Sub heading.'),),
                  TextFormField(controller: _classNameController,decoration: InputDecoration(labelText: 'Class'),),
                  Row(children: [ 
                    SizedBox(child: Text('Select Set'),),
                    SizedBox(width: 60,),
                    DropdownButton<String>(value: _selectedSet,
                       onChanged: (String? newValue) {
                                  setState(() {_selectedSet = newValue;});},
                     items: <String>['A', 'B', 'C', 'D'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value,child: Text(value),);}).toList(),hint: Text('Select a set'), ),
                    ],),
                 
                  DropdownButtonFormField<int>(
                    value: totalSections,
                    decoration: InputDecoration(labelText: 'Total Sections'),
                    items: List.generate(10, (index) {
                      return DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      );
                    }),
                    onChanged: (value) {
                    setState(() {
                       totalSections = value!;
                       questionsInSection = List.generate(totalSections, 
                       (index) => questionsInSection.length > index ? questionsInSection[index] : 0); });},
                    validator: (value) {
                      if (value == null) {
                        return 'Please select total sections';
                      }
                      return null;
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: totalSections,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          int totalQuestions = questionsInSection.reduce((value, element) => value + element);

                          print('Main Heading: ${_headingController.text}');
                          print('Class Name: ${_classNameController.text}');
                          print('Total Questions: $totalQuestions');
                          print(questionsInSection);
                          
                         Navigator.push(context,MaterialPageRoute(
                              builder: (context) => showSheet( heading: _headingController.text,
                                subheading: _subheadingController.text,
                                className: _classNameController.text,
                                totalSections: totalSections,
                                questionsInSection: questionsInSection,),
                            ),);
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

