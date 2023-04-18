import 'package:flutter/material.dart';
import 'package:uploaderapp/newhome/creator_page.dart';
import 'package:uploaderapp/newhome/nav_drawer.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  //images
  Future<List<String>> getImageUrlsFromFirebaseStorage() async {
    List<String> imageUrls = [];

    // Get a reference to the Firebase Storage instance
    FirebaseStorage storage = FirebaseStorage.instance;

    // Get a reference to the images folder
    Reference imagesRef = storage.ref().child('images');

    // List all the items in the images folder
    ListResult result = await imagesRef.listAll();
    print('///////////////');
    print(result);
    print('///////////////');

    // Loop through each item in the result and get its download URL
    for (Reference ref in result.items) {
      String downloadUrl = await ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }

  @override
  void initState() {
    super.initState();
    //Future<List<String>> images = getImageUrlsFromFirebaseStorage();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<String>> imageUrls = getImageUrlsFromFirebaseStorage();
    // var imageUrls = [
    //   // 'gs://imageuploader-a96c3.appspot.com/images/sample1.jpg',
    //   // 'gs://imageuploader-a96c3.appspot.com/images/sample2.jpeg'
    //   'https://source.unsplash.com/user/c_v_r/1900x800',
    //   'https://source.unsplash.com/user/c_v_r/100x100'
    // ];
    return Scaffold(
      drawer: NavDrawer(selected: DrawerSelection.home),
      appBar: AppBar(
        title: Text("AAJ KA MEME"),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getImageUrlsFromFirebaseStorage(),
        builder: (context, snapshot) {
          return FutureBuilder<List<String>>(
            future: getImageUrlsFromFirebaseStorage(),
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No data found');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (() {
                        String selectedImageUrl =
                            snapshot.data![index].toString();
                        print("////////////////////");
                        print(selectedImageUrl);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MemeCreatorPage(
                                selectedImageUrl: selectedImageUrl)));
                      }),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Image.network(snapshot.data![index]),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
      //     body: ListView.builder(
      //   itemCount: imageUrls.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Container(
      //       padding: EdgeInsets.all(10.0),
      //       child: Image.network(imageUrls[index]),
      //     );
      //   },
      // )
    );
    // body: Container(
    //     child: Image.network(
    //         'https://source.unsplash.com/user/c_v_r/1900x800')));

//         body: ListView.builder(
//           itemCount: imageUrls.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               padding: EdgeInsets.all(10.0),
//               child: Image.network(
//                 imageUrls[index],
//                 fit: BoxFit.cover,
//               ),
//             );
//           },
//         ));
//   }
// }
  }
}
