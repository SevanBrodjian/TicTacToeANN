public void grid() {
  if ((mouseX>width-50 && mouseX<width-10 && mouseY>10 && mouseY<50 && !editing)) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
  if (mouseX>width-50 && mouseX<width-10 && mouseY>10 && mouseY<50 && !editing) {
    fill(200, 25, 25);
  } else {
    fill(255, 25, 25);
  }
  stroke(0);
  strokeWeight(2);
  rect(width-50, 10, 40, 40);
  strokeWeight(4);
  line(offset, (802/3), offset+700, (802/3));
  line(offset, (1502/3), offset+700, (1502/3));
  line((700/3)+offset, 34, (700/3)+offset, 734);
  line((1400/3)+offset, 34, (1400/3)+offset, 734);
  stroke(0);
  for (int i=0; i<9; i++) {
    piece(state[i], i);
  }
}

public void Set() {
  textSize(50);
  for (int i=0; i<9; i++) {
    state[i]=round(random(0, 0));
    outputNode[i]=0;
    inputNode[i]=0;
    inputNode[i+9]=0;
    outI[i]=0;
    outI[i+9]=0;
    outO[i]=0;
    inO[i]=0;
  }
  for (int i=0; i<12; i++) {
    inH[i]=0;
    outH[i]=0;
  }
  for (int i=0; i<216; i++) {
    weight1[i]=random(0, 0.5);
  }
  for (int i=0; i<108; i++) {
    weight2[i]=random(0, 0.5);
  }
}

public void piece(int val, int place) {
  fill(255);
  stroke(0);
  strokeWeight(4);

  if (val==1) {
    line(offset+15+700/3*(place%3), 49+700/3*(int)(place/3), offset+655/3+700/3*(place%3), 757/3+700/3*(int)(place/3));
    line(offset+655/3+700/3*(place%3), 49+700/3*(int)(place/3), offset+15+700/3*(place%3), 757/3+700/3*(int)(place/3));
  }
  if (val==2) {
    ellipse(350/3+offset+700/3*(place%3), 452/3+700/3*(int)(place/3), 610/3, 610/3);
  }
}

public void play() {
  if (!playerMove) {
    computer();
    return;
  }
  if (autoPlay) {
    int count=0;
    int open[] = new int[9];
    for (int i=0; i<9; i++) {
      if (state[i]==0) {
        open[count]=i;
        count++;
      }
    }
    //println(open);
    //println("done " + count);
    state[open[round(random(count-1))]]=1;
    playerMove=false;
  } else {

    fill(255);
    stroke(255, 25, 25);
    strokeWeight(4);
    for (int place=0; place<9; place++) {
      if (editing) {
        if (mouseX>offset+15+700/3*(place%3)-15 && mouseX<offset+655/3+700/3*(place%3)+15 && mouseY>49+700/3*(int)(place/3)-15 && mouseY<757/3+700/3*(int)(place/3)+15 && state[place]==0) {
          ellipse(350/3+offset+700/3*(place%3), 452/3+700/3*(int)(place/3), 610/3, 610/3);
          if (mousePressed) {
            state[place]=2;
            state[prevMove]=0;
            prevMove=place;
            editing=false;
            learn=true;
          }
        }
      } else {
        if (mouseX>offset+15+700/3*(place%3)-15 && mouseX<offset+655/3+700/3*(place%3)+15 && mouseY>49+700/3*(int)(place/3)-15 && mouseY<757/3+700/3*(int)(place/3)+15 && state[place]==0) {
          line(offset+15+700/3*(place%3), 49+700/3*(int)(place/3), offset+655/3+700/3*(place%3), 757/3+700/3*(int)(place/3));
          line(offset+655/3+700/3*(place%3), 49+700/3*(int)(place/3), offset+15+700/3*(place%3), 757/3+700/3*(int)(place/3));
          if (mousePressed) {
            state[place]=1;
            playerMove=false;
          }
        }
      }
    }
  }
}

public void computer() {
  if (!auto) {
    int test = minimax(2);
    state[test]=2;
    playerMove=true;
  } else {
    for (int i=0; i<9; i++) {
      if (state[i]==1) {
        inputNode[2*i]=1;
        inputNode[2*i+1]=-1;
      } else if (state[i]==2) {
        inputNode[2*i]=-1;
        inputNode[2*i+1]=1;
      } else {
        inputNode[2*i]=-1;
        inputNode[2*i+1]=-1;
      }
      outputNode[i]=0;
    }
    for (int i=0; i<18; i++) {
      outI[i]=inputNode[i];
    }
    for (int i=0; i<12; i++) {
      inH[i]=0;
      outH[i]=0;
    }
    float maxVal=0;
    int maxNode=1;

    for (int i=0; i<12; i++) {
      for (int j=0; j<18; j++) {
        inH[i]+=outI[j]*weight1[12*j+i];
      }
      outH[i]=1.0/(1.0+exp(-inH[i]));
    }
    for (int i=0; i<9; i++) {
      for (int j=0; j<12; j++) {
        inO[i]+=outH[j]*weight2[9*j+i];
      }
      outO[i]=1.0/(1.0+exp(-inO[i]));
      //println(i + " " + outO[i]);
      if (state[i]!=0) {
        outO[i]=0;
      }
      if (outO[i]>maxVal) {
        maxVal=outO[i];
        maxNode=i;
      }
      //println(i + " " + outO[i]);
    }
    int bestMove=minimax(2);
    if (maxNode==bestMove || !controlComputer) {
      state[maxNode]=2;
      prevMove=maxNode;
      playerMove=true;
    } else {
      state[minimax(2)]=2;
      prevMove=minimax(2);
      learn=true;
      playerMove=true;
    }
  }
}

public void make(int i) {
  state[i]=1;
  playerMove=false;
}

public void checkForWin() {
  int sum=0;
  for (int i=0; i<9; i++) {
    if (state[i]!=0) {
      if (i%3==0 && state[i+1]==state[i] && state[i+2]==state[i]) {
        win=true;
        whoWon=state[i];
        displayWin();
        //println("1");
      }
      if (i/3==0 && state[i+3]==state[i] && state[i+6]==state[i]) {
        win=true;
        whoWon=state[i];
        displayWin();
        //println("2");
      }
      if ((i==0||i==2) && state[4]==state[i] && state[8-i]==state[i]) {
        win=true;
        whoWon=state[i];
        displayWin();
        //println("3");
      }
    }
    if (state[i]!=0) {
      sum++;
    }
  }
  //println(whoWon);
  if (sum==9 && whoWon==0) {
    win=true;
    displayWin();
  }
}

public void displayWin() {
  if (autoPlay) {
    return;
  }
  textAlign(CENTER, CENTER);
  textSize(50);
  stroke(0);
  fill(0);
  if (whoWon==1) {
    text("Player Wins", offset+750, height-100, width-offset-750, 100);
  } else if (whoWon==2) {
    text("Computer Wins", offset+750, height-100, width-offset-750, 100);
  } else {
    text("Tie Game", offset+750, height-100, width-offset-750, 100);
  }
}

public void reset() {
  if (keyPressed || autoPlay) {
    win=false;
    whoWon=0;
    for (int i=0; i<9; i++) {
      state[i]=0;
    }
  }
}

public void correct() {
  if ((mousePressed && mouseX>width-50 && mouseX<width-10 && mouseY>10 && mouseY<50) || (mouseX>1000 && mouseY>700)) {
    editing=true;
  }
  if (keyPressed) {
    editing=false;
  }
}

public void drawBrain() {
  stroke(0);
  fill(215);
  for (int i=0; i<18; i++) {
    for (int k=0; k<12; k++) {
      strokeWeight(weight1[i*9+k]*4.0);
      line(offset+750, 30+i*34, offset+1050, 100+k*34);
    }
  }
  for (int i=0; i<12; i++) {
    for (int k=0; k<9; k++) {
      strokeWeight(weight2[i*9+k]*4.0);
      line(offset+1050, 100+i*34, offset+1300, 145+k*34);
    }
  }
  strokeWeight(1.5);
  for (int j=0; j<18; j++) {
    ellipse(offset+750, 30+j*34, 30, 30);
  }
  for (int i=0; i<12; i++) {
    ellipse(offset+1050, 100+i*34, 30, 30);
  }
  for (int i=0; i<9; i++) {
    ellipse(offset+1300, 145+i*34, 30, 30);
  }
}

public void backpropogate() {
  float weight2Temp[] = new float[108];
  float expected[] = new float[9];
  for (int i=0; i<9; i++) {
    if (i==prevMove) {
      expected[i]=1;
    } else {
      expected[i]=0;
    }
  }
  float error=0;
  for (int i=0; i<9; i++) {
    error+=0.5*pow((expected[i]-outO[i]), 2);
    //println(i+" "+expected[i]+" "+outO[i]);
  }
  println(error + " " + cCount);
  cCount++;

  for (int i=0; i<108; i++) {
    weight2Temp[i]=weight2[i];
    int outNeuron=i%9;
    int inNeuron=i/9;
    float decValue=-(expected[outNeuron]-outO[outNeuron])*outO[outNeuron]*(1.0-outO[outNeuron])*outH[inNeuron];
    weight2Temp[i]-=decValue*learningRate;
    if (weight2Temp[i]<0) {
      weight2Temp[i]=0;
    }
  }
  for (int i=0; i<216; i++) {
    int hidNeuron=i%12;
    int inNeuron=i/12;
    float etot=0;
    for (int j=0; j<9; j++) {
      etot+=-(expected[j]-outO[j])*(outO[j]*(1.0-outO[j]))*weight2[hidNeuron*9+j];
    }
    float decValue=etot*outH[hidNeuron]*(1.0-outH[hidNeuron])*outI[inNeuron];
    println(decValue);
    weight1[i]-=decValue*learningRate;
    if (weight1[i]<0) {
      weight1[i]=0;
    }
  }
  for (int i=0; i<108; i++) {
    weight2[i]=weight2Temp[i];
  }
  learn=false;
}

void keyReleased() {
  if (key=='a') {
    autoPlay=!autoPlay;
  }
  if (key=='h') {
    disp=!disp;
  }
  if (key=='c') {
    controlComputer=!controlComputer;
  }
}

public void backpropogate2() {
  float weight2Temp[] = new float[108];
  float expected[] = new float[9];
  for (int i=0; i<9; i++) {
    if (i==prevMove) {
      expected[i]=1;
    } else {
      expected[i]=0;
    }
  }
  float error=0;
  for (int i=0; i<9; i++) {
    error+=0.5*pow((expected[i]-outO[i]), 2);
  }
  println(error + " " + cCount);
  cCount++;

  for (int i=0; i<108; i++) {
    weight2Temp[i]=weight2[i];
    int outNeuron=i%9;
    int hidNeuron=i/9;
    weight2Temp[i]+=learningRate*error*outH[hidNeuron]*10*outO[outNeuron]*(1.0-outO[outNeuron]);
    //println(learningRate*error*outH[hidNeuron]*outO[outNeuron]*(1.0-outO[outNeuron]));
    if (weight2Temp[i]<0) {
      weight2Temp[i]=0;
    }
  }
  for (int i=0; i<216; i++) {
    int hidNeuron=i%12;
    int inNeuron=i/12;
    weight1[i]+=learningRate*error*outI[inNeuron]*outH[hidNeuron]*(1.0-outH[hidNeuron]);
    //println(learningRate*error*outI[inNeuron]*outH[hidNeuron]*(1.0-outH[hidNeuron]));
    if (weight1[i]<0) {
      weight1[i]=0;
    }
  }
  for (int i=0; i<108; i++) {
    weight2[i]=weight2Temp[i];
  }
  learn=false;
}
