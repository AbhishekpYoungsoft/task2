import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  String imageUrl;
  ResultPage({super.key, required this.imageUrl});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.network(widget.imageUrl),
            Positioned(
              top: 20.0,
              left: 20.0,
              child: Text(
                'Top Text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: Text(
                'Bottom Text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
