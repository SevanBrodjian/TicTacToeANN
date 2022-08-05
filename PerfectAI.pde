int overPlayer;
int inf=10;

public int minimax(int player) {
  overPlayer=player;
  String boardstate="";
  int opens[] = new int[9];
  int boards[] = new int[9];
  for(int i=0; i<9; i++){
    boards[i]=state[i];
    boardstate+=boards[i];
  }
  String open=openMoves(boardstate);
  int maxValue=-999;
  int maxSpace=-1;
  for(int i=0; i<open.length(); i++){
    opens[i]=valueOf(open.charAt(i));
    boards[opens[i]]=player;
    boardstate="";
    for(int j=0; j<9; j++){
      boardstate+=boards[j];
    }
    int val = calculate(boardstate, 2, false);
    //println(opens[i] + " " + boardstate + " " + val);
    if(val>maxValue){
      maxValue=val;
      maxSpace=opens[i];
    }
    boards[opens[i]]=0;
  }
  //println("done");
  return maxSpace;
}

public int calculate(String boardState, int depth, boolean isMaximizingPlayer) {
  //println(boardState);
  int boardVal=terminalState(boardState);
  if(boardVal!=-1){
    if(depth==2){
      //println(boardState + " " + boardVal);
    }
    if(boardVal==10){
      boardVal-=depth;
    } else if(boardVal==-10){
      boardVal+=depth;
    }
    return boardVal;
  }
  
  int opens[] = new int[9];
  int boards[] = new int[9];
  for(int i=0; i<9; i++){
    boards[i]=valueOf(boardState.charAt(i));
  }
  String open=openMoves(boardState);
  for(int i=0; i<open.length(); i++){
    opens[i]=valueOf(open.charAt(i));
  }
  //println(opens);
  //println(boards);
  
  if(isMaximizingPlayer){
    boardVal=-999;
    for(int i=0; i<open.length(); i++){
      boards[opens[i]]=2;
      String push="";
      for(int j=0; j<9; j++){
        push+=boards[j];
      }
      boardVal=max(boardVal, calculate(push, depth+1, false));
      boards[opens[i]]=0;
    }
    return boardVal;
  } else {
    boardVal=999;
    for(int i=0; i<open.length(); i++){
      boards[opens[i]]=1;
      String push="";
      for(int j=0; j<9; j++){
        push+=boards[j];
      }
      boardVal=min(boardVal, calculate(push, depth+1, true));
      boards[opens[i]]=0;
    }
    return boardVal;
  }
}

public int terminalState(String boardState) {
  int board[] = new int[9];
  String open = openMoves(boardState);
  for (int i=0; i<9; i++) {
    board[i]=valueOf(boardState.charAt(i));
  }
  for (int i=1; i<3; i++) {
    if (board[0]==i && ((board[1]==i && board[2]==i) || (board[3]==i && board[6]==i) || (board[4]==i && board[8]==i))) {
      if (i==overPlayer) {
        return inf;
      } else {
        return -inf;
      }
    }
    if (board[1]==i && (board[4]==i && board[7]==i)) {
      if (i==overPlayer) {
        return inf;
      } else {
        return -inf;
      }
    }
    if (board[2]==i && ((board[5]==i && board[8]==i) || (board[4]==i && board[6]==i))) {
      if (i==overPlayer) {
        return inf;
      } else {
        return -inf;
      }
    }
    if (board[3]==i && (board[4]==i && board[5]==i)) {
      if (i==overPlayer) {
        return inf;
      } else {
        return -inf;
      }
    }
    if (board[6]==i && (board[7]==i && board[8]==i)) {
      if (i==overPlayer) {
        return inf;
      } else {
        return -inf;
      }
    }
  }
  if (open.length()==0) {
    return 0;
  }
  return -1;
}

public String openMoves(String boardState) {
  String open="";
  for (int i=0; i<9; i++) {
    if (boardState.charAt(i)=='0') {
      open+=i;
    }
  }
  return open;
}

public int valueOf(Character ch){
  if(ch=='0'){
    return 0;
  }
  if(ch=='1'){
    return 1;
  }
  if(ch=='2'){
    return 2;
  }
  if(ch=='3'){
    return 3;
  }
  if(ch=='4'){
    return 4;
  }
  if(ch=='5'){
    return 5;
  }
  if(ch=='6'){
    return 6;
  }
  if(ch=='7'){
    return 7;
  }
  if(ch=='8'){
    return 8;
  }
  return -1;
}
