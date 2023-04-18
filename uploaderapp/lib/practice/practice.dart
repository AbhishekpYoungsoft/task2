import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  //String imageUrl
  String? imageUrl;
  //Creating firebasees references

  Future getImage() async {
    Reference ref = FirebaseStorage.instance.ref().child('foldernameimagename');
    //download url as
    var url = await ref.getDownloadURL();
    imageUrl = url.toString();
    print(imageUrl);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Practice")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  getImage();
                },
                child: Text("image")),
            Container(
              child: imageUrl != null
                  ? Image(image: NetworkImage(imageUrl!))
                  : Text("NO image Found!"),
            )
          ],
        ));
  }
}
