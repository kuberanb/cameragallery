import 'dart:io';
import 'package:gallery/gallery_screen.dart';
import 'package:gallery/model/image_model.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  String? imagePath;

  Box<ImageModel>? cameraBox;

// File? image;

@override
  void initState() {
    // TODO: implement initState

    cameraBox = Hive.box<ImageModel>('images');
    super.initState();
  }

Future<void> pickImageCamera() async{

final image = await ImagePicker().pickImage(source: ImageSource.camera);

if(image == null){
   return;
}

await GallerySaver.saveImage(image.path);

setState(() {
  imagePath = image.path;
});

addimagedatabase(context);

addalertbox(context);


}

Future addimagedatabase(BuildContext context) async{

if(imagePath == null){
  print('Some error occurs ');
  return;
}

final  _image = ImageModel(imagePath: imagePath!);

await cameraBox!.add(_image);

print('Image added to database sucessfully ');

setState(() {
  imagePath = null;
});



}

void addalertbox(BuildContext context){

showDialog(context: context, builder: ((context) {
  return AlertDialog(
  title: Column(
    children: const [
      Text('Alert'),
      SizedBox(height: 5,),
      Divider(   
        thickness: 1,   
        color: Colors.grey,
      )
    ],
    
  ),
  content: const Text('Image Added Sucessfully into Local Database'),

  actions: [

TextButton( onPressed: (){
  Navigator.pushReplacement( context, MaterialPageRoute(builder: ((context) => galleryScreen())));
}, child: const Text(' OK '))


  ],


  );
}
)

);


}



//final ImagePicker _picker = ImagePicker();

// Future addimagecamera() async{

// final image = await ImagePicker().pickImage(source: ImageSource.camera );

// if(image == null) return;

// final imagetemp = File(image.path);

// setState(() {
//   this.image = imagetemp;
// });

// }
// Future addimagegallery() async{

// final image = await ImagePicker().pickImage(source: ImageSource.gallery );

// if(image == null) return;

// final imagetemp = File(image.path);

// setState(() {

//   this.image = imagetemp;

// });


//}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          title: Text('Camera Screen'),
          centerTitle: true,
          actions: [
            IconButton(icon:Icon(Icons.format_list_bulleted_outlined),onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => galleryScreen())));
            },)
          ],
         ),
         body: Container(
          child: SingleChildScrollView(
            child: Column(
             children:  [
              SizedBox(height: 50,),
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: (imagePath == null)
                  ? const AssetImage('assets/images/avatar.jpeg')
                  : FileImage(File(imagePath!)) as ImageProvider,
                ),
                
              ),
              SizedBox(height: 30,),
          
              ElevatedButton(onPressed: (){
                 //addimagecamera();
                 pickImageCamera();
                // addimagedatabase(context);

              },
               child: Text('Add Image (Camera)'),
               ),
          
              SizedBox(height: 30,),
          
              // ElevatedButton(onPressed: (){
              //    //  addimagegallery();
              // },
              //  child: Text('Add Image (Gallery )'),
              
              //  ),
          
          
              SizedBox(height: 30,),
          
          
              // image!=null ?Image.file(image!):Text('Image not selected '),
          
             ],
            ),
          ),
         ),
    );
  }



}