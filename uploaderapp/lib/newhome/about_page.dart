import 'package:flutter/material.dart';
import 'package:uploaderapp/newhome/nav_drawer.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(selected: DrawerSelection.about),
      appBar: AppBar(
        title: Text("AAJ KA MEME"),
        toolbarHeight: 100,
        centerTitle: true,
      ),
    );
  }
}
