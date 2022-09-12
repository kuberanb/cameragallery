import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery/Single_image.dart';
import 'package:gallery/model/image_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class galleryScreen extends StatefulWidget {
  const galleryScreen({Key? key}) : super(key: key);

  @override
  State<galleryScreen> createState() => _galleryScreenState();
}

class _galleryScreenState extends State<galleryScreen> {
  Box<ImageModel>? cameraBox;

  @override
  void initState() {
    // TODO: implement initState
    cameraBox = Hive.box('images');

    super.initState();
  }

    void deletedAlertBox(int key) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog( 
            backgroundColor: Color(0xFFFDEEDC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Column(
              children: const [
                Text('Alert'),
                Divider(
                  color: Color(0xFFE38B29),
                ),
              ],
            ),
            content: Text('Do you want to confirm the deletion'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFFE38B29),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await cameraBox!.delete(key);
                  Navigator.pop(ctx);
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: Color(0xFFE38B29),
                  ),
                ),
              ),
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Screen'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ValueListenableBuilder(
          valueListenable: cameraBox!.listenable(),
          builder:
              (BuildContext context, Box<ImageModel> images, Widget? child) {
            return GridView.builder(
              itemCount: images.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: ((context, index) {

                final key = images.keys.toList()[index];
                final _image = images.get(key);
                return GestureDetector(
                  onLongPress: () {
                  
                  deletedAlertBox(key);

                  },
                  onTap: () {

                    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => singleimage( imageModel: _image! ) )),

                //  singleimage(ImageModel: ImageModel);

                    );

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(_image!.imagePath),
                          ),
                        )),
                  ),
                );
              }),
            );
          }),
    );
  }
}
