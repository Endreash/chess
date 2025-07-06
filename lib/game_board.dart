import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/components/piece.dart';
import 'package:flutter_application_2/components/square.dart';
import 'package:flutter_application_2/components/taken_pieces.dart';
import 'package:flutter_application_2/util/on_board.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // 2-dimentional list representing the chess board
  late List<List<ChessPiece?>> board;

  // the current selected piece 
  // if no piece is selected, this is null
  ChessPiece? selectedPiece;

  // the row and col of the selected piece
  // default -1 indicates no piece is selected
  int selectedRow = -1;
  int selectedCol = -1;

  // A list of valid moves for the current selected piece
  // each move is represented with 2 elements: row and col
  List<List<int>> validMoves = [];

  // list of white pieces that black have captured
  List<ChessPiece> whitePieceTaken = [];

  // list of black pieces that black have captured 
  List<ChessPiece> blackPiecetaken = [];

  // a bool value to indicate whose turn is it
  bool isWhiteTurn = true;

  // keeping track of the initial kings position to make it easier to see if the king is in checkmated
  List<int> whiteKingPosition = [7, 4]; 
  List<int> blackKingPosition = [0, 4];
  
  // checkmate status
  bool checkStatus = false;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
    // _easternBlock();
  }

  _easternBlock(){
    late List<List<ChessPiece?>> newBoard = 
        List.generate(8, (index) => List.generate(8, (index) => null));

      //soviets
      for(int i=0; i<8; i++){
        newBoard[7][i] = ChessPiece(name: ChessPieceType.pawn, isWhite: true, imgPath: 'lib/images/black_pawn.png');
      }
      for(int i=0; i<8; i++){
        newBoard[6][i] = ChessPiece(name: ChessPieceType.pawn, isWhite: true, imgPath: 'lib/images/black_pawn.png');
      }
      for(int i=0; i<8; i++){
        newBoard[5][i] = ChessPiece(name: ChessPieceType.pawn, isWhite: true, imgPath: 'lib/images/black_pawn.png');
      }
      for(int i=0; i<8; i++){
        newBoard[4][i] = ChessPiece(name: ChessPieceType.pawn, isWhite: true, imgPath: 'lib/images/black_pawn.png');
      }

      //third riech
      newBoard[0][0] = ChessPiece(
          name: ChessPieceType.rook, 
          isWhite: false, 
          imgPath: 'lib/images/black_rook.png');

      newBoard[0][7] = ChessPiece(
        name: ChessPieceType.rook, 
        isWhite: false, 
        imgPath: 'lib/images/black_rook.png');

        newBoard[0][1] = ChessPiece(
        name: ChessPieceType.bishop, 
        isWhite: false, 
        imgPath: 'lib/images/black_bishop.png');

        newBoard[0][6] = ChessPiece(
        name: ChessPieceType.bishop, 
        isWhite: false, 
        imgPath: 'lib/images/black_bishop.png');

        newBoard[0][2] = ChessPiece(
          name: ChessPieceType.knight, 
          isWhite: false, 
          imgPath: 'lib/images/black_knight.png');
        newBoard[0][4] = ChessPiece(
          name: ChessPieceType.knight, 
          isWhite: false, 
          imgPath: 'lib/images/black_knight.png');

        newBoard[0][3] = ChessPiece(
          name: ChessPieceType.knight, 
          isWhite: false, 
          imgPath: 'lib/images/black_knight.png');
        newBoard[0][5] = ChessPiece(
          name: ChessPieceType.knight, 
          isWhite: false, 
          imgPath: 'lib/images/black_knight.png');

        board = newBoard;

  }

  // INITIALIZE THE BOARD
  _initializeBoard() {
    late List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

        // testing
        // newBoard[4][4] = ChessPiece(
        //   name: ChessPieceType.knight, 
        //   isWhite: false, 
        //   imgPath: 'lib/images/black_knight.png');

        // pawns
        for(int i = 0; i < 8; i++) {
          newBoard[1][i] = ChessPiece(
            name: ChessPieceType.pawn, 
            isWhite: false, 
            imgPath: 'lib/images/black_pawn.png');
        }

        for(int i = 0; i < 8; i++) {
          newBoard[6][i] = ChessPiece(
            name: ChessPieceType.pawn, 
            isWhite: true, 
            imgPath: 'lib/images/black_pawn.png');
        }

        // rook
        newBoard[0][0] = ChessPiece(
          name: ChessPieceType.rook, 
          isWhite: false, 
          imgPath: 'lib/images/black_rook.png');

        newBoard[0][7] = ChessPiece(
          name: ChessPieceType.rook, 
          isWhite: false, 
          imgPath: 'lib/images/black_rook.png');

        newBoard[7][0] = ChessPiece(
          name: ChessPieceType.rook, 
          isWhite: true, 
          imgPath: 'lib/images/black_rook.png');

        newBoard[7][7] = ChessPiece(
          name: ChessPieceType.rook, 
          isWhite: true, 
          imgPath: 'lib/images/black_rook.png');

        // knight

        newBoard[0][1] = ChessPiece(
          name: ChessPieceType.knight, 
          isWhite: false, 
          imgPath: 'lib/images/black_knight.png');
        newBoard[0][6] = ChessPiece(
          name: ChessPieceType.knight, 
          isWhite: false, 
          imgPath: 'lib/images/black_knight.png');
        newBoard[7][1] = ChessPiece(
          name: ChessPieceType.knight, 
          isWhite: true, 
          imgPath: 'lib/images/black_knight.png');
        newBoard[7][6] = ChessPiece(
          name: ChessPieceType.knight, 
          isWhite: true, 
          imgPath: 'lib/images/black_knight.png');

          // bishop
          newBoard[0][2] = ChessPiece(
          name: ChessPieceType.bishop, 
          isWhite: false, 
          imgPath: 'lib/images/black_bishop.png');

          newBoard[0][5] = ChessPiece(
          name: ChessPieceType.bishop, 
          isWhite: false, 
          imgPath: 'lib/images/black_bishop.png');

          newBoard[7][5] = ChessPiece(
          name: ChessPieceType.bishop, 
          isWhite: true, 
          imgPath: 'lib/images/black_bishop.png');

          newBoard[7][2] = ChessPiece(
          name: ChessPieceType.bishop, 
          isWhite: true, 
          imgPath: 'lib/images/black_bishop.png');

          // queen

          newBoard[0][3] = ChessPiece(
            name: ChessPieceType.queen, 
            isWhite: false, 
            imgPath: 'lib/images/black_queen.png');

          newBoard[7][3] = ChessPiece(
            name: ChessPieceType.queen, 
            isWhite: true, 
            imgPath: 'lib/images/black_queen.png');

          // king

          newBoard[0][4] = ChessPiece(
            name: ChessPieceType.king, 
            isWhite: false, 
            imgPath: 'lib/images/black_king.png');

          newBoard[7][4] = ChessPiece(
            name: ChessPieceType.king, 
            isWhite: true, 
            imgPath: 'lib/images/black_king.png');

        

        board = newBoard;
  }

// user selected a piece
void pieceSelected(int row, int col) {
  setState(() {
    // select a piece if there is a piece in that position
    // if(board[row][col] != null) {
    //   selectedPiece = board[row][col];
    //   selectedRow = row;
    //   selectedCol = col;
    // }

    // no piece has been selected yet, this is the first selection
    if( selectedPiece == null && board[row][col] != null) {
      if (board[row][col]!.isWhite == isWhiteTurn) { // white to begin 
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }
    }

    // there is a piece already selected, but user can select another one of their pieces
    else if (board[row][col] != null && board[row][col]!.isWhite == selectedPiece!.isWhite) {
      selectedPiece = board[row][col];
      selectedRow = row;
      selectedCol = col;
    }

    // if there is a piece selected and user taps on a square that is a valid move, move there
    else if (selectedPiece != null && validMoves.any((element) => element[0] == row && element[1] == col)) {
      movePiece(row, col);
    }

    // if piece is selected calculate its valid moves
    validMoves = calculateRawValidMoves(selectedRow, selectedCol, selectedPiece);
  });
}

// CALCULATE RAW VALID MOVES
List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece){
    List<List<int>> candidateMoves = [];

    if (piece == null){
      return [];
    }

    // different directions based on thier color
    int direction = piece.isWhite ? -1 : 1; // up or down

    switch (piece.name) {
      case ChessPieceType.pawn:
        // pawns can move forward if the square is not occupied
        if (isInBoard(row + direction, col) && // move one up direction
          board[row+direction][col] == null){ // null which is empty square
          candidateMoves.add([row + direction, col]);
        } 

        // pawns can move 2 squares if they are at their initial positions
        if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) { // black and row 1 and white and row 6 = initial positions
          if (isInBoard(row + 2 * direction, col) && // check if in board
              board[row + 2 * direction][col] == null && // check if positions are null
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        // pawns can kill diagnally
        if(isInBoard(row + direction, col -1) && // check if on board
          board[row + direction][col -1] != null && // and if their is a piece ther that is no null
          board[row + direction][col -1]!.isWhite !=piece.isWhite) { // and white this is a valid moves
            candidateMoves.add([row + direction, col -1]);
          }
          // for white
        if(isInBoard(row + direction, col + 1) && // check if on board
          board[row + direction][col + 1] != null && // and if their is a piece ther that is no null
          board[row + direction][col + 1]!.isWhite !=piece.isWhite) { // and white this is a valid moves
            candidateMoves.add([row + direction, col + 1]);
          }
        
        break;
      case ChessPieceType.rook:
        // horizontal and vertical direction
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, 1], // right
          [0, -1], // left
        ];

        for (var direction in directions) {
          var i =1;
          while (true) { 
            var newRow = row + i * direction[0]; // get every square until we hit a road block in a particular direction
            var newCol = col + i * direction[1];
            if(!isInBoard(newRow, newCol)){ // break if not on board
              break;
            }
            if (board[newRow][newCol] != null){ // if the position is not null that is it has a piece 
              if(board[newRow][newCol]!.isWhite !=piece.isWhite){ // then check the color if it is white and our piece isnt white kill
                candidateMoves.add([newRow, newCol]); // kill
              }
              break; // blocked if its our piece
            }
            candidateMoves.add([newRow, newCol]);
          }
        }
        break;
      case ChessPieceType.knight:

        // all eight possible l shape we can move
        var knighMoves = [
          [-2, -1], // up 2 left 1
          [-2, 1], // up 2 right 1
          [-1, -2], // up 1 left 2
          [-1, 2], // up 1 right 2
          [1, -2], // down 1 left 2
          [1, 2], // down1 righr 2
          [2, -1], // down 2 left 1
          [2, 1], // down 2 right 1
        ];

        for (var move in knighMoves){
          var newRow = row +move[0];
          var newCol = col + move[1];
          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null){
            if(board[newRow][newCol]!.isWhite !=piece.isWhite){
              candidateMoves.add([newRow, newCol]); // capture
            }
            continue;
          }
          candidateMoves.add([newRow, newCol]);
        }

        break;
      case ChessPieceType.bishop:
        // diagonal directions
        var directions = [ 
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], // down left
          [1, 1], // down right
        ];

        for (var direction in directions) {
          var i =1;
          while (true) { 
            var newRow = row + i * direction[0]; 
            var newCol = col + i * direction[1];
          if(!isInBoard(newRow, newCol)){ 
              break;
            }
            if (board[newRow][newCol] != null){
              if(board[newRow][newCol]!.isWhite !=piece.isWhite){ 
                candidateMoves.add([newRow, newCol]); 
              }
              break; // blocked if its our piece
            }
            candidateMoves.add([newRow, newCol]);
            i++;
            }
          }

        break;
      case ChessPieceType.queen:
        // all ehight directions
        var directions =[
          [-1,0], // up
          [1,0], // down
          [0,-1], // left 
          [0,1], // right
          [-1,-1], // up left
          [-1,1], // up right
          [1,-1], //down left
          [1,1], // down right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) { 
            var newRow = row + i * direction[0]; 
            var newCol = col + i * direction[1];
          if(!isInBoard(newRow, newCol)){ 
              break;
            }
            if (board[newRow][newCol] != null){
              if(board[newRow][newCol]!.isWhite !=piece.isWhite){ 
                candidateMoves.add([newRow, newCol]); 
              }
              break; // blocked if its our piece
            }
            candidateMoves.add([newRow, newCol]);
            i++;
            }
          }

        break;
      case ChessPieceType.king:

      // all ehight directions
        var directions =[
          [-1,0], // up
          [1,0], // down
          [0,-1], // left 
          [0,1], // right
          [-1,-1], // up left
          [-1,1], // up right
          [1,-1], //down left
          [1,1], // down right
        ];

        for (var direction in directions) {
          while (true) { 
            var newRow = row + direction[0]; 
            var newCol = col + direction[1];
          if(!isInBoard(newRow, newCol)){ 
              break;
            }
            if (board[newRow][newCol] != null){
              if(board[newRow][newCol]!.isWhite !=piece.isWhite){ 
                candidateMoves.add([newRow, newCol]); 
              }
              break; // blocked if its our piece
            }
            candidateMoves.add([newRow, newCol]);
            }
          }
        break;
      // default:
    }

    return candidateMoves;
    // return candidateMoves.cast<List<int>>;
  }

  // ChessPieces myPawn = ChessPieces(
  //     name: ChessPiece.pawn, isWhite: false, imgPath: 'lib/images/b_pawn.png');

  // MOVE PIECE
  void movePiece(int newRow, int newCol){

    // quick check here, if the new spot has an enemy piece
    if (selectedPiece == null) {
    return; // Exit if no piece is selected
  }

    if (board[newRow][newCol] != null ){ // if that new position we are trying to go to is an enemy piece
      // add the captured piece to the list
      var capturedPiece = board[newRow][newCol];
      if (capturedPiece!.isWhite){
        whitePieceTaken.add(capturedPiece);
      } else {
        blackPiecetaken.add(capturedPiece);
      }
    }

    // move the piece and clear the old
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    // see if the king is checkmate
    // if (isKingCheckmated(!isWhiteTurn)){
    //   checkStatus = true;
    // } else {
    //   checkStatus = false;
    // }

    // clear selection
    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });

    // update king position
    // if (selectedPiece!.name == ChessPieceType.king) {
    //   if (isWhiteTurn) {
    //     whiteKingPosition = [newRow, newCol];
    //   } else {
    //     blackKingPosition = [newRow, newCol];
    //   }
    // }

    // change turns
    isWhiteTurn = !isWhiteTurn;
  }

  // is king checkmated?
  // bool isKingCheckmated(bool isWhiteKing){
  //   // get the position of the king
  //   List<int> kingPosition = 
  //     isWhiteKing ? whiteKingPosition : blackKingPosition;

  //   // check if any enemy piece can attack the king
  //   for(int i=0; i<8; i++){
  //     for(int j=0; j<8; j++){
  //       // skip empty squares and piece of the same color as the king
  //       if (board[i][j] == null || board[i][j]!.isWhite == isWhiteKing){
  //         continue;
  //       }

  //       List<List<int>> pieceValidMoves =
  //           calculateRawValidMoves(i, j, board[i][j]);

  //       // check if the king's position is in this piece's valid moves
  //       if (pieceValidMoves.any((move) => 
  //           move[0] == kingPosition[0] && move[1] == kingPosition[1])) {
  //             return true;
  //       }
  //     }
  //   }

  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color.fromARGB(255, 64, 88, 44),
  body: LayoutBuilder(
    builder: (context, constraints) {
      final mediaQuery = MediaQuery.of(context);
      final screenWidth = mediaQuery.size.width;
      final screenHeight = mediaQuery.size.height;

      return Column(
        children: [
          // white piece captured
          Expanded(
            flex: 1,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: whitePieceTaken.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth ~/ 100, // adjust the cross axis count based on screen width
              ),
              itemBuilder: (context, index) => TakenPieces(
                whitePieceTaken[index].imgPath,
                true,
                // screenHeight * 0.05, // set the height of each item based on screen height
                screenHeight * 0.0005, // set the height of each item based on screen height
                // screenWidth * 0.1, // set the width of each item based on screen width
                screenWidth * 0.001, // set the width of each item based on screen width
              ),
            ),
          ),

          Text(checkStatus ? 'Checkmate' : '', style: TextStyle(fontSize: screenHeight * 0.02)), // adjust font size based on screen height

          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 8 * 8,
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8
                // crossAxisCount: screenWidth ~/ 100, // adjust the cross axis count based on screen width
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 8;
                int col = index % 8;

                bool isWhite = (row + col) % 2 == 0;

                // check if this square is selected
                bool isSelected = selectedRow == row && selectedCol == col;

                // check if this square is a valid move
                bool isvalidMove = false;
                for (var position in validMoves) {
                  // compare row and col
                  if (position[0] == row && position[1] == col) {
                    isvalidMove = true;
                  }
                }

                return Square(
                  isWhite,
                  board[row][col],
                  isSelected,
                  (() => pieceSelected(row, col)),
                  isvalidMove,
                  screenHeight * 0.05, // set the height of each item based on screen height
                  screenWidth * 0.1, // set the width of each item based on screen width
                );
              },
            ),
          ),

          // black piece taken
          Expanded(
            flex: 1,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: blackPiecetaken.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth ~/ 100, // adjust the cross axis count based on screen width
              ),
              itemBuilder: (context, index) => TakenPieces(
                blackPiecetaken[index].imgPath,
                false,
                screenHeight * 0.05, // set the height of each item based on screen height
                screenWidth * 0.1, // set the width of each item based on screen width
              ),
            ),
          ),
        ],
      );
    },
  ),
);
    // return Scaffold(
    //   backgroundColor: const Color.fromARGB(255, 64, 88, 44),
    //   body: Column(
    //     children: [
    //       // white piece captured
    //       Expanded(
    //         child: GridView.builder(
    //           physics: const NeverScrollableScrollPhysics(),
    //           itemCount: whitePieceTaken.length,
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8), 
    //           itemBuilder: (context, index) => TakenPieces(whitePieceTaken[index].imgPath, true)
    //           ),
    //       ),

    //       Text(checkStatus ? 'Checkmate' :''),
    //       Expanded(
    //         flex: 3,
    //         child: GridView.builder(
    //             itemCount: 8 * 8,
    //             physics: const NeverScrollableScrollPhysics(),
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 8),
    //             itemBuilder: (context, index) {
    //               int row = index ~/ 8;
    //               int col = index % 8;
            
    //               bool isWhite = (row + col) % 2 == 0;
            
    //               // check if this square is selected
    //               bool isSelected = selectedRow == row && selectedCol == col;
            
    //               // check if this square is a valid move
    //               bool isvalidMove = false;
    //               for (var position in validMoves){
    //                 // compare row and col
    //                 if (position[0] == row && position[1] == col){
    //                   isvalidMove= true;
    //                 }
    //               }
            
    //               return Square(
    //                 isWhite, 
    //                 board[row][col],
    //                 isSelected,
    //                 (() => pieceSelected(row, col)),
    //                 isvalidMove
    //                 );
    //             }),
    //       ),

    //       // black piece taken
    //       Expanded(
    //         child: GridView.builder(
    //           physics: const NeverScrollableScrollPhysics(),
    //           itemCount: blackPiecetaken.length,
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8), 
    //           itemBuilder: (context, index) => TakenPieces(blackPiecetaken[index].imgPath, false)
    //           ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
