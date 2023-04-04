import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:uploaderapp/Config/app_colors.dart';
import 'package:uploaderapp/login/Login_with%20_phone.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //image file rrequirements
  File? image;
  ImagePicker picker = ImagePicker();

  //storage instances
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;

  //image functions

  Future getImageFromGallary() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (PickedFile != null) {
        image = File(PickedFile.path);
      } else {
        print("No image Picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: getImageFromGallary,
              child: Container(
                  height: 300,
                  width: 300,
                  color: Colors.grey,
                  // decoration: BoxDecoration(border: Border(top: BorderSide.none)),
                  child: image != null
                      ? Image.file(image!.absolute)
                      : Center(child: Icon(Icons.image))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                //FirebaseStorage reference = FirebaseStorage.instance.ref();
              },
              child: Text("UPLOAD"))
        ],
      ),
    );
  }
}
