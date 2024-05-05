import 'package:flutter/material.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

//Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListViewExample(transformMatrix: TransformMatrices.scaleDown,),),);

class ListViewExample extends StatelessWidget {
  const ListViewExample({
    super.key,
    required this.transformMatrix,
  });

  final TransformMatrixCallback transformMatrix;

  @override
  Widget build(BuildContext context) {
    double hght = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
     List Cardname =['Take Exam','Create OMR','Scan OMR','Details'];
     List CardImage=['assets/images/card1.jpg','assets/images/card2.jpg','assets/images/scan.png','assets/images/card4.jpg'];
     List CardFunction =[];

    return Scaffold( body: 
      TransformableListView.builder(padding: EdgeInsets.zero,
        getTransformMatrix: transformMatrix,itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(onTap: () {
          },child: Card(  margin: const EdgeInsets.symmetric( horizontal: 40,vertical: 8,),elevation: 5, // Adjust elevation as needed
            child: Container(width: wid,height: wid*0.35, 
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.blueAccent ,
               image: DecorationImage(image: AssetImage(CardImage[index]), fit: BoxFit.cover, ),),
            alignment: Alignment.topLeft,child:
            Padding(
                padding: const EdgeInsets.all(8.0), 
                child: Text(Cardname[index],
                  style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold,),),),
            )));
        },),
    );
  }
}
class TransformMatrices {
  static Matrix4 scaleDown(TransformableListItem item) {
    /// final scale of child when the animation is completed
    const endScaleBound = 0.3;
    /// 0 when animation completed and [scale] == [endScaleBound]
    /// 1 when animation starts and [scale] == 1
    final animationProgress = item.visibleExtent / item.size.height;
    /// result matrix
    final paintTransform = Matrix4.identity();
    /// animate only if item is on edge
    if (item.position != TransformableListItemPosition.middle) {
      final scale = endScaleBound + ((1 - endScaleBound) * animationProgress);
      paintTransform
        ..translate(item.size.width / 2)
        ..scale(scale)
        ..translate(-item.size.width / 2);
    }
    return paintTransform;
  }
}