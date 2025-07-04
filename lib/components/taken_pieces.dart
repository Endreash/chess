import 'package:flutter/material.dart';

class TakenPieces extends StatelessWidget {
  final String imgPath;
  final bool isWhite;
  const TakenPieces(this.imgPath, this.isWhite,{super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imgPath,
      color: isWhite ? Colors.grey[100] : Colors.grey[900],
      );
  }
}