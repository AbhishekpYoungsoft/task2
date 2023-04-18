import 'package:flutter/material.dart';
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
          Image.network(
              'https://media.istockphoto.com/id/491520707/photo/sample-red-grunge-round-stamp-on-white-background.jpg?s=1024x1024&w=is&k=20&c=HZ3aN-WLxmMBwTh5mGYFVXYn84xPGw-Pj0gVKwb4BOE='),
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
          ElevatedButton(onPressed: () {}, child: Text("Generate Meme"))
        ]));
  }
}
