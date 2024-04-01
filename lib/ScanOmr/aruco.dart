import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crop_your_image/crop_your_image.dart';

class Aruco extends StatefulWidget {
  
  final File image;

  const Aruco({Key? key, required this.image}) : super(key: key);

  @override
  State<Aruco> createState() => _ArucoState();
}

class _ArucoState extends State<Aruco> {
 File? image1;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    image1 = widget.image;
    double hght = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: Container(
                height: hght * 0.8,
                width: wid * 0.9,
                child: Image.file(image1!),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}


     // Directory tempDir1 = await getTemporaryDirectory();
    //Directory tempDir2 = await getTemporaryDirectory();
        //String tempPath1 = tempDir1.path;
        //String tempPath2 = tempDir2.path;


        //final imagePath = '/data/user/0/com.example.omr_reader/cache/${DateTime.now().millisecondsSinceEpoch}img.jpg';
        //String imagePath = '$tempPath1/${DateTime.now().millisecondsSinceEpoch}img.jpg';
       // File imageFile = File(imagePath);
     //   await imageFile.writeAsBytes(await pickedFile!.readAsBytes());
     
         //String scriptContent = await rootBundle.loadString('assets/script/script.py');
        // String pythonPath = '/data/user/0/com.example.omr_reader/cache/script.py';
        // File scriptFile = File(pythonPath);
        // await scriptFile.writeAsString(scriptContent);
        /*
          Future<String> _getPythonScriptPath() async {
  Directory directory = await getApplicationDocumentsDirectory();
  String assetsDirectory = '${directory.path}/assets';
  ByteData data = await rootBundle.load('assets/script/script.py');
  List<int> bytes = data.buffer.asUint8List();
  String scriptPath = '$assetsDirectory/script/script.py';
  await File(scriptPath).writeAsBytes(bytes);
  return scriptPath;
}


class OpenCV extends Flython {
  static const cmdToGray = 1;

  Future<dynamic> toGray(String inputFile,
      String outputFile,) async {
    var command = {
      "cmd": cmdToGray,
      "input": inputFile,
      "output": outputFile,
    };
    return await runCommand(command);
  }
}


Future fetchData()  async{
  var url = Uri.parse('http://10.0.2.2:5000/');
  http.Response  res =  await http.get(url);
  
  return  res.body;
}

   
      //var data = await getData('');
      //String pythonScriptPath = await _getPythonScriptPath();
      //ProcessResult result = await Process.run('python', [pythonScriptPath]);
     // print(result.stdout);
     // print(result.stderr);

final opencv = OpenCV();
        await opencv.initialize("python", "main.py", false);
        await opencv.toGray("./image.png", "./image_gray.png");
        opencv.finalize();   
        */ 