int state[] = new int[9]; //0-nothing, 1-player, 2-computer
float inputNode[] = new float [18];
float outputNode[] = new float[9];
float hiddenNode[] = new float[12];
float weight1[] = new float[216];
float weight2[] = new float[108];
int offset=15;
boolean playerMove=false;
boolean win=false;
int whoWon=0;
boolean editing=false;
int prevMove=0;
boolean learn=false;
float outO[] = new float[9];
float inO[] = new float[9];

float outI[] = new float[18];
float inH[] = new float[12];
float outH[] = new float[12];
float error=0;
boolean auto=true;
boolean autoPlay=false;
boolean disp=true;
int cCount=0;
boolean controlComputer=false;

float learningRate=0.25;

void setup() {
  fullScreen();
  Set();
}

void draw() {
  if (learn) {
    backpropogate2();
  } else if (win) {
    if(disp){
      grid();
    }
    reset();
  } else {
    background(255);
    if(disp){
      grid();
      drawBrain();
    }
    play();
    checkForWin();
    correct();
  }
}
