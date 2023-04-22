import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uploaderapp/newhome/nav_drawer.dart';
import 'package:uploaderapp/newhome/result.dart';
import 'package:flutter/widgets.dart';

//import 'package:flutter_image_meme/flutter_image_meme.dart';
// import 'package:flutter_screenshot/flutter_screenshot.dart';
class MemeCreatorPage extends StatefulWidget {
  String selectedImageUrl;
  MemeCreatorPage({super.key, required this.selectedImageUrl});

  @override
  State<MemeCreatorPage> createState() => _MemeCreatorPageState();
}

class _MemeCreatorPageState extends State<MemeCreatorPage> {
  TextEditingController topController = TextEditingController();
  TextEditingController bottomController = TextEditingController();

  Widget buidMyStack(String ImageUrl) {
    return Stack(
      children: [
        Image.network(
          ImageUrl,
          fit: BoxFit.scaleDown,
        ),
        Positioned(
          top: 10.0,
          //left: ,
          // left: 20.0,
          child: Text(
            "toptext",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 240,
          //left: 100,
          bottom: 10,
          // bottom: 300.0,
          // right: 20.0,
          child: Text(
            "bottomtext",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  //String selectedImageUrl;
  @override
  Widget build(BuildContext context) {
    ///buidMyStack _buildstack =buidMyStack;
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
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => ResultPage(
                //           imageUrl: widget.selectedImageUrl,
                //         )));
                MemeGenerator(widget.selectedImageUrl, topController.toString(),
                    bottomController.toString());
              },
              child: const Text("Generate Meme"))
        ]));
  }

  MemeGenerator(String imageUrl, String topText, String bottomText) async {
    print("meme generator called");
    print(imageUrl);

    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetAnimationDuration: const Duration(seconds: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CircularProgressIndicator(),
                Text("Creating Meme..")
              ],
            ),
          );
        });

    await Future.delayed(
        const Duration(seconds: 2)); // ignore: use_build_context_synchronously
    Navigator.pop(context);

    getmeme(widget.selectedImageUrl, topText, bottomText);
    //showResult(widget.selectedImageUrl);
  }

  getmeme(String ImageUrl, String toptext, String bottomtext) {
    return showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //insetAnimationDuration: Duration(seconds: 3),
            content: RepaintBoundary(child: buidMyStack(ImageUrl)),

            actions: [
              TextButton(
                  onPressed: () async {
                    Uint8List imageBytes = await captureWidgetToImage(
                        context, RepaintBoundary(child: buidMyStack(ImageUrl)));
                    print(imageBytes);
                  },
                  child: const Text("save"))
            ],
            title: const Text("your meme "),
          );
        });
  }

  Future<Uint8List> captureWidgetToImage(
      BuildContext context, Widget widget) async {
    RenderRepaintBoundary boundary = RenderRepaintBoundary();
    await Future.delayed(Duration(milliseconds: 20));
    boundary = boundary..attach(PipelineOwner());
    boundary.layout(BoxConstraints.tight(context.size!));
    await Future.delayed(Duration(milliseconds: 20));
    ui.Image image = await boundary.toImage(pixelRatio: 1.0);
    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    print("????????????????????????????-------");
    return pngBytes;

    // Future<Uint8List> captureWidgetToImage(
    //     BuildContext context, Widget widget) async {
    //   RenderRepaintBoundary boundary =
    //       context.findRenderObject() as RenderRepaintBoundary;
    //   ui.Image image = await boundary.toImage();
    //   ByteData byteData =
    //       await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    //   print("///////////////////////////-------------------");
    //   print(byteData.buffer.asUint8List());
    //   return byteData.buffer.asUint8List();
  }

  showResult(String ImageUrl) {
    print("///////////////////////////");
    print("showResult called");
    //Navigator.pop(context);
  }

  void saveImageToGallery(String ImageUrl) async {
    //String finalmemeUrl = ImageUrl;
    final response = await http.get(Uri.parse(ImageUrl));

    print(response.bodyBytes);
    Uint8List image = response.bodyBytes;

    var appDocumentsDir = await getApplicationDocumentsDirectory();
    //final Directory? downloadsDir = await getDownloadsDirectory();
    var firstPath = '${appDocumentsDir.path}/images';
    var filePathAndName = "${appDocumentsDir.path}/images/meme.jpeg";

    await Directory(firstPath).create(recursive: true);
    File file = File(filePathAndName);
    file.writeAsBytesSync(image);

    await GallerySaver.saveImage(file.path);

    SnackBar(content: Text("saved to Gallry"));
  }
}
