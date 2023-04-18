import 'package:flutter/material.dart';
import 'package:uploaderapp/newhome/about_page.dart';
import 'package:uploaderapp/newhome/creator_page.dart';
import 'package:uploaderapp/newhome/new_homescreen.dart';

enum DrawerSelection { home, creator, about }

class NavDrawer extends StatefulWidget {
  final DrawerSelection selected;
  const NavDrawer({super.key, required this.selected});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String defaultImageUrl =
      'https://media.istockphoto.com/id/491520707/photo/sample-red-grunge-round-stamp-on-white-background.jpg?s=1024x1024&w=is&k=20&c=HZ3aN-WLxmMBwTh5mGYFVXYn84xPGw-Pj0gVKwb4BOE=';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        SizedBox(
          height: 112,
          child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(2)),
              child: Center(
                child: Text("Menu"),
              )),
        ),
        ListTile(
          selected: widget.selected == DrawerSelection.home,
          leading: Icon(Icons.home),
          title: Text("Meme Of The day"),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NewHomeScreen()));
          },
        ),
        ListTile(
          selected: widget.selected == DrawerSelection.creator,
          leading: Icon(Icons.whatshot),
          title: Text("Meme Creator"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MemeCreatorPage(
                      selectedImageUrl: defaultImageUrl,
                    )));
          },
        ),
        ListTile(
          selected: widget.selected == DrawerSelection.about,
          leading: Icon(Icons.info),
          title: Text("About"),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AboutPage()));
          },
        )
      ]),
    );
  }
}
