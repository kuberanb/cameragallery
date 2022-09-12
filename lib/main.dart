import 'package:flutter/material.dart';
import 'package:gallery/camera_screen.dart';
import 'package:gallery/model/image_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

WidgetsFlutterBinding.ensureInitialized();

await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(ImageModelAdapter().typeId)) {
    Hive.registerAdapter(ImageModelAdapter());
  }


await Hive.openBox<ImageModel>('images');


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Private Gallery',
      theme: ThemeData(
      ),
      home: CameraScreen(),
    );
  }
}

