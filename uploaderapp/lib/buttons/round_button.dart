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
        height: 40,
        width: 80,
        // ignore: sort_child_properties_last
        child: Text(
          title.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.buttonColor),
      ),
    );
  }
}
