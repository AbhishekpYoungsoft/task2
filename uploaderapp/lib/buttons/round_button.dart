import 'package:flutter/material.dart';
import 'package:uploaderapp/Config/app_colors.dart';

class RoundButton extends StatelessWidget {
  //required inputs
  final String title;
  final VoidCallback onTap;

  //construstor
  RoundButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Text(title.toString()),
      ),
    );
  }
}
