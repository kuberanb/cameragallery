
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:gallery/model/image_model.dart';


class singleimage extends StatelessWidget {

 // const  singleimage ({Key? key,required this.ImageModel}) : super(key: key);

   const singleimage({
    
    super.key,
    required this.imageModel, 

  });


  final ImageModel imageModel;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
            title: Text('Full Screen '),
            centerTitle: true,
           ),

           body: Center(
             child: Column(
              children: [
                
          Image(image: FileImage(File(imageModel.imagePath))),
          
              ],
             ),
           ),
    );
  }
}