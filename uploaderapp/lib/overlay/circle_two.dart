import 'package:flutter/material.dart';

class Cicle extends StatefulWidget {
  //bool _isloading = false;
  const Cicle({
    super.key,
  });

  @override
  State<Cicle> createState() => _CicleState();
}

class _CicleState extends State<Cicle> {
  bool _isloading = false;

  void show() {
    setState(() {
      print("???????????????????????????????????");
      _isloading = true;
      print(_isloading);
    });
  }

  void hide() {
    setState(() {
      print("???????????????????????????????????hide");
      _isloading = false;
      print(_isloading);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_isloading);
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        show();
                      },
                      child: Text("activate")),
                  TextButton(
                      onPressed: () {
                        hide();
                      },
                      child: Text("deactivate")),
                ],
              ),
            ),
          ),
        ),
        if (_isloading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        // if (_isloading)
        //   const Opacity(
        //     opacity: 0.5,
        //     child: ModalBarrier(dismissible: false, color: Colors.black),
        //   ),
        // if (_isloading)
        //   const Center(
        //     child: CircularProgressIndicator(),
        //   ),
      ],
    );
  }
}
