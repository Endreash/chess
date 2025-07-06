import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/piece.dart';
import 'package:flutter_application_2/util/colors.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final bool isValidMove;
  final void Function()? onTap;
  final double height;
  final double width;
  const Square(this.isWhite, this.piece, this.isSelected, this.onTap, this.isValidMove, this.height, this.width, {super.key});

  @override
  Widget build(BuildContext context) {

    Color? squareColor;

    if (isSelected) {
      squareColor = const Color.fromRGBO(185, 202, 67, 1);
    } else if(isValidMove){
      squareColor = const Color.fromARGB(254, 234, 255, 95);
    }
    
    else {
      squareColor = isWhite ? lightGreen : darkGreen;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        color: squareColor,
        child: piece != null ? Image.asset(
          piece!.imgPath,
          color: piece!.isWhite ? Colors.white : Colors.black,
          ) : null
      ),
    );
  }
}