import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:uploaderapp/newhome/nav_drawer.dart';

class MemeCreatorPage extends StatefulWidget {
  String selectedImageUrl;
  MemeCreatorPage({super.key, required this.selectedImageUrl});

  @override
  State<MemeCreatorPage> createState() => _MemeCreatorPageState();
}

class _MemeCreatorPageState extends State<MemeCreatorPage> {
  TextEditingController topController = TextEditingController();
  TextEditingController bottomController = TextEditingController();

  //String selectedImageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(selected: DrawerSelection.creator),
        appBar: AppBar(
          title: Text("Meme Creator"),
          toolbarHeight: 100,
          centerTitle: true,
        ),
        body: Column(children: [
          Image.network(widget.selectedImageUrl),
          // Image.network(
          //     'https://media.istockphoto.com/id/491520707/photo/sample-red-grunge-round-stamp-on-white-background.jpg?s=1024x1024&w=is&k=20&c=HZ3aN-WLxmMBwTh5mGYFVXYn84xPGw-Pj0gVKwb4BOE='),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: TextFormField(
              controller: topController,
              decoration: InputDecoration(
                  hintText: "enter top text", border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              controller: bottomController,
              decoration: InputDecoration(
                  hintText: "enter bottom text", border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                MemeGenerator(widget.selectedImageUrl, topController.toString(),
                    bottomController.toString());
              },
              child: Text("Generate Meme"))
        ]));
  }

  void MemeGenerator(String imageUrl, String topText, String bottomText) async {
    print("meme generator called");
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetAnimationDuration: Duration(seconds: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CircularProgressIndicator(),
                Text("Creating Meme..")
              ],
            ),
          );
        });

    await Future.delayed(Duration(seconds: 2));
    //Navigator.pop(context);
    Navigator.of(context).pop();
    //dispose();
    showResult(widget.selectedImageUrl);
  }

  showResult(String ImageUrl) {
    print("///////////////////////////");
    print("showResult called");
    //Navigator.pop(context);
    return showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              insetAnimationDuration: Duration(seconds: 3),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: [
                    Title(
                        color: Colors.black, child: Text("Your meme is ready")),
                    Image.network(
                      ImageUrl,
                      fit: BoxFit.scaleDown,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            saveImageToGallery(ImageUrl);
                          },
                          child: Text("save"),
                        )
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  void saveImageToGallery(String ImageUrl) async {
    var response = await Dio()
        .get(ImageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    print(result);
    Navigator.pop(context);
    setState(() {});
  }
}
