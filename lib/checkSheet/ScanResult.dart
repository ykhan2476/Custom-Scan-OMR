import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ScanResult extends StatefulWidget {
  File? image;
  final List<List<dynamic>> AnsKey;
  int totalmcq;
  int totalquestions;
  final String posMarks;
  final String negMarks;
  ScanResult(
      {Key? key,
      required this.posMarks,
      required this.negMarks,
      required this.AnsKey,
      required this.totalmcq,
      required this.image,
      required this.totalquestions});

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
 
  String? responseData2;
  int correctAnswers=0;
  int wrongAnswers=0;
  Map<String, dynamic>? responseData;
  String processed_image="";

  @override
  void initState() {
    super.initState();
    // Call your function here
    sendApiRequest();
  }
  
 Future<void> fetchData() async {
  try {
    String apiUrl2 = 'https://ykhan2476.pythonanywhere.com/books';
    http.Response response2 = await http.get(Uri.parse(apiUrl2));
    if (response2.statusCode == 200) {
      setState(() {
          Map<String, dynamic> responseData2 = jsonDecode(response2.body);
          print('Response: $responseData2');
      });
     
    } else {
      print('Request failed with status: ${response2.statusCode}');
    }
  } catch (error) {
    print('Error fetching data: $error');
  }
}
  

    Future<void> sendApiRequest() async {
    try {
      List<int> imageBytes = await widget.image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      final Map<String, dynamic> payload = {
        'nested_list': widget.AnsKey,
        'integer_value': widget.totalmcq,
        'image_bytes': base64Image,
      };
      String apiUrl = 'https://ykhan2476.pythonanywhere.com/book';

      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseData = jsonDecode(response.body);
        setState(() {
          correctAnswers = responseData?['correct_answers'];
          wrongAnswers = responseData?['wrong_answers'];
          processed_image= responseData?['processed_image'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        setState(() {
          responseData = null;
        });
      }
    } catch (error) {
      print('Error sending API request: $error');
      setState(() {
        responseData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalmarks=int.parse(widget.posMarks) *(widget.totalquestions);
    int marksobtained =int.parse(widget.posMarks) * correctAnswers - int.parse(widget.negMarks) * wrongAnswers;
    double wid = MediaQuery.of(context).size.width;
    double hght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              SizedBox(
                height: 30,
                child: Text(
                  'Results',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 20),
              
              Stack(
                children: [
                  Container(
                    height: hght * 0.6,
                    width: wid,
                    child: Image.asset('assets/images/c.jpg'),
                  ),
                  (responseData==null)?
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: hght * 0.45,
                      width: wid * 0.7,
                      child: Image.file(widget.image!, fit: BoxFit.cover),
                    ),
                  )
                  :Center(child:Container(height: hght * 0.6,width: wid*0.8,child: Image.memory(base64Decode(processed_image),fit: BoxFit.contain,),)),
                  (responseData==null)?
                  Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.transparent,
                      highlightColor: const Color.fromARGB(255, 119, 232, 122),
                      direction: ShimmerDirection.ttb,
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        height: hght * 0.45,
                        width: wid * 0.7,
                        color: Colors.grey[50],
                      ),
                    ),
                  ):SizedBox(),
                ],
              ),
              Card(
                elevation: 3,
                color: Colors.white,
                margin: EdgeInsets.all(10),
                shadowColor: Colors.grey,
                child: Column(
                  children: [
                   /* SizedBox(height: 10),
                    if (responseData != null) Text('${responseData!}'),
                    SizedBox(height: 10),
                    if (responseData2 != null) Text(responseData2!),*/
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Correct Answers:',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold))),
                        SizedBox(width: 20),
                        if (responseData != null)SizedBox(height: 20,child: Text('${correctAnswers}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Wrong Answers:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
                        SizedBox(width: 20),
                        if (responseData != null)SizedBox(height: 20,child: Text('${wrongAnswers}',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)))
                        // Adjust as needed based on response
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Total Marks:')),
                        SizedBox(width: 20),
                        SizedBox(height: 20,child: Text('${totalmarks}'))
                        // Adjust as needed based on response
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20,width: wid*0.6, child: Text('Marks Obtained:')),
                        SizedBox(width: 20),
                        if (responseData != null)SizedBox(height: 20,child: Text('${marksobtained}'))
                        // Adjust as needed based on response
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 45),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        foregroundColor: Colors.white),
                    child: const Text("Save"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 0, 22, 100),
                          foregroundColor: Colors.white),
                      child: Text("Generate Report")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
