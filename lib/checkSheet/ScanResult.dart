import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ScanResult extends StatefulWidget {
  File? image;
  final List<List<dynamic>> AnsKey;
  int totalmcq;
  final String posMarks;
  final String negMarks;
  ScanResult(
      {Key? key,
      required this.posMarks,
      required this.negMarks,
      required this.AnsKey,
      required this.totalmcq,
      required this.image});

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  String? responseData;

  @override
  void initState() {
    super.initState();
    // Call your function here
    sendApiRequest();
  }

  Future<void> sendApiRequest() async {
    try {
      final ansKeyJson = jsonEncode(widget.AnsKey);
      List<int> imageBytes = await widget.image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      final Map<String, dynamic> payload = {
        'nested_list': ansKeyJson,
        'integer_value': widget.totalmcq,
        'image_bytes': base64Image,
      };
      print(payload);
      String apiUrl = 'https://ykhan2476.pythonanywhere.com/';

      // Send POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      // Check response status
      if (response.statusCode == 200) {
        // Request successful, parse response JSON
        Map<String, dynamic> responseData = jsonDecode(response.body);
        // Handle response data
        setState(() {
          this.responseData = responseData.toString();
        });
      } else {
        // Request failed with an error status code
        print('Request failed with status: ${response.statusCode}');
        setState(() {
          responseData = 'Request failed with status: ${response.statusCode}';
        });
      }
    } catch (error) {
      // Handle errors
      print('Error sending API request: $error');
      setState(() {
        responseData = 'Error sending API request: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  'Scan Results',
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: hght * 0.45,
                      width: wid * 0.7,
                      child: Image.file(widget.image!, fit: BoxFit.cover),
                    ),
                  ),
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
                  ),
                ],
              ),
              Card(
                elevation: 3,
                color: Colors.white,
                margin: EdgeInsets.all(10),
                shadowColor: Colors.grey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    if (responseData != null) Text(responseData!),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20, child: Text('Correct Answers:')),
                        SizedBox(width: 20),
                        if (responseData != null)SizedBox(height: 20,)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20, child: Text('Wrong Answers:')),
                        SizedBox(width: 20),
                        // Adjust as needed based on response
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20, child: Text('Total Marks:')),
                        SizedBox(width: 20),
                        // Adjust as needed based on response
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        SizedBox(height: 20, child: Text('Marks Obtained:')),
                        SizedBox(width: 20),
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
