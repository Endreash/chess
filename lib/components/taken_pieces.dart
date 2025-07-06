import 'package:flutter/material.dart';

class TakenPieces extends StatelessWidget {
  final String imgPath;
  final bool isWhite;
  final double height;
  final double width;
  const TakenPieces(this.imgPath, this.isWhite, this.height, this.width,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Image.asset(
        imgPath,
        color: isWhite ? Colors.grey[100] : Colors.grey[900],
        ),
    );
  }
}