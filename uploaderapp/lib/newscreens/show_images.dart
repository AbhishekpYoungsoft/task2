import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowImagesScreen extends StatefulWidget {
  const ShowImagesScreen({super.key});

  @override
  State<ShowImagesScreen> createState() => _ShowImagesScreenState();
}

class _ShowImagesScreenState extends State<ShowImagesScreen> {
  List<File> imageList = [];

  //
  //FirebaseStorage storage = FirebaseStorage.instance;
  //
  //Reference ref = FirebaseStorage.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Images")),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("ImageUrls").snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Container(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: kTransparentImage,
                                  image: snapshot.data!.docs[index].get('url')),
                            ),
                          );
                        })),
                  );
          },
        ));
  }
}
