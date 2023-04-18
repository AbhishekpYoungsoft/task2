import 'package:flutter/material.dart';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: Stack(
        children: [
          // Background widget
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dimming container
          Visibility(
            visible: _isLoading,
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Content widget
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                      // Perform some time-consuming operation here
                    });
                  },
                  child: Text('Start Loading'),
                ),
                SizedBox(height: 16.0),
                // Show the CircularProgressIndicator when loading
                Visibility(
                  visible: _isLoading,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
