import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:uploaderapp/home_screen.dart';

class AddImagesScreen extends StatefulWidget {
  const AddImagesScreen({super.key});

  @override
  State<AddImagesScreen> createState() => _AddImagesScreenState();
}

class _AddImagesScreenState extends State<AddImagesScreen> {
  List<File> imageList = []; //image lists

  late CollectionReference imageRef;
  Reference ref = FirebaseStorage.instance.ref();

  ImagePicker picker = ImagePicker(); //for piking from gallery

  @override
  void initState() {
    super.initState();
    imageRef = FirebaseFirestore.instance.collection('ImageUrls');
  }

  Future uploadImages() async {
    for (var image in imageList) {
      ref = FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(image.path)}');
      await ref.putFile(image).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imageRef.add({'url': value});
        });
      });
    }
  }

  void selectImages() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageList.add(File(pickedfile!.path));
      print("///////////////////////////////////");
      print(imageList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Images")),
      body: GridView.builder(
          itemCount: imageList.length + 1,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return index == 0
                ? Center(
                    child: IconButton(
                        onPressed: () {
                          selectImages();
                        },
                        icon: const Icon(Icons.add_a_photo)))
                : Container(
                    child: Image(
                      image: FileImage(imageList[index - 1]),
                      fit: BoxFit.cover,
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            uploadImages().whenComplete(() {
              Get.snackbar("upload success", "");
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => (MyHomePage())))
                  .onError((error, stackTrace) {
                Get.snackbar("Upload Failed", error.toString());
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => (MyHomePage())));
              });
            });
          },
          label: const Text("Upload")),
    );
  }
}
