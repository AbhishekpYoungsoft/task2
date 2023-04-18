import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uploaderapp/newscreens/Add_images.dart';
import 'package:uploaderapp/newscreens/show_images.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HomeScreen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Get.to(const AddImagesScreen());
                },
                child: const Text("Add Images")),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Get.to(const ShowImagesScreen());
                },
                child: const Text("Get Photos"))
          ],
        ),
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   //image file rrequirements
//   File? image; // for storing image path
//   ImagePicker picker = ImagePicker(); //for image picking from gallary or camera

//   //storage instances
//   FirebaseStorage storage = FirebaseStorage.instance;
//   DatabaseReference databaseref = FirebaseDatabase.instance.ref(
//       'POSTS'); //creates an instance in Realtime database (like a table named Pots)

//   //image functions
//   //pick image from gallary

//   Future getImageFromGallary() async {
//     final PickedFile = await picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (PickedFile != null) {
//         image = File(PickedFile
//             .path); //setting the path of the image once image is picked, so set state
//       } else {
//         print("No image Picked");
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("HomeScreen"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: InkWell(
//               onTap: getImageFromGallary,
//               child: Container(
//                   height: 300,
//                   width: 300,
//                   color: Colors.grey.shade200,
//                   // decoration: BoxDecoration(border: Border(top: BorderSide.none)),
//                   child: image != null
//                       ? Image.file(image!.absolute)
//                       : const Center(child: Icon(Icons.image))),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//               onPressed: () async {
//                 Reference reference = FirebaseStorage.instance
//                     .ref(DateTime.now().microsecondsSinceEpoch.toString());
//                 UploadTask uploadtask = reference.putFile(image!.absolute);
//                 await Future.value(uploadtask);
//                 var newUrl = await reference.getDownloadURL();

//                 //store url in realtime database
//                 databaseref.child('1').set({
//                   //'id': '2345',
//                   'title': newUrl.toString() // a string under title is stored
//                 }).then((value) {
//                   Get.snackbar(
//                       "UPLOAD successful", "image uploaded successfull");
//                   setState(() {});
//                 }).onError((error, stackTrace) {
//                   Get.snackbar("Upload Fialed", error.toString());
//                 });
//                 //FirebaseStorage reference = FirebaseStorage.instance.ref();
//               },
//               child: const Text("UPLOAD")),
//           const SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 Get.to(PracticePage());
//               },
//               child: Text("image list"))
//         ],
//       ),
//     );
//   }
// }
