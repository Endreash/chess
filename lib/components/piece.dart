enum ChessPieceType { pawn, rook, knight, bishop, queen, king}

class ChessPiece{
  final ChessPieceType name;
  final bool isWhite;
  final String imgPath;

  ChessPiece({
    required this.name, 
    required this.isWhite, 
    required this.imgPath});
}