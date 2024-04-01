import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:image_processing_contouring/Image/ImageContouring.dart';
import 'package:image_processing_contouring/Image/ImageDrawing.dart';
import 'package:image_processing_contouring/Image/ImageOperation.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;




class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  List<Rect> regionsOfInterest = [];
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _image = ProcessImage(_image!);
      } else {
        print('No image selected.');
      }
    });
  }

 File ProcessImage(File imageFile) {
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
    img.Image grayscaleImage = img.grayscale(image);
    img.Image blurredImage = img.gaussianBlur(grayscaleImage, radius: 2);
    img.Image edgeDetectedImage = img.sobel(blurredImage);
    img.Image binaryImage = edgeDetectedImage.threshold(128); 
    //img.Image thres= img.luminanceThreshold(edgeDetectedImage);
    var contours = image.threshold(100).detectContours();
    contours?.sort((c, b) => (b.getArea() - c.getArea()).toInt());
    image.drawContours(contours!, img.ColorFloat16.rgb(0,0,255), filled: false);
    var biggestcontour = contours?.first;
    image.drawContour(biggestcontour!, img.ColorFloat16.rgb(0,255,0), false);
     for (int i=3;i<contours.length;i++)
      image.drawContour(contours[i]!, img.ColorFloat16.rgb(0,0,255), true);
   // Adjust threshold value as needed
  // img.Image binaryImage = img.grayscaleToBinary(edgeDetectedImage, threshold: 100);
    
    File _processedImage = File(imageFile.path.substring(0, imageFile.path.lastIndexOf('.')) + '_processedImage.jpg');
    _processedImage.writeAsBytesSync(img.encodeJpg(binaryImage));
    return _processedImage;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: Column(children: [
        Container(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image!),
      ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

