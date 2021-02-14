import processing.sound.*;

// Ball System 
int numBalls;

BallSystem ballSystem;

// Camera
PVector camPos;

float centerX;
float centerY;
float centerZ;
float upX;
float upY;
float upZ;

// Sounds
SoundFile bassC1, bassCs1, bassD1, bassDs1, bassE1, bassF1, bassFs1, bassG1, bassGs1, bassA1, bassAs1, bassB1, bassC2;
SoundFile padC3, padCs3, padD3, padDs3, padE3, padF3, padFs3, padG3, padGs3, padA3, padAs3, padB3, padC4;
SoundFile boom1, hit2min, hit2Maj, clack3min, clack3Maj, blewp4, spaceMetalTriTone, boom5, hat6min, hat6maj, hat7min, hat7Maj, octaHat;

void setup()
{
  fullScreen(P3D);
  
  // Ball System Setup
  numBalls = 10;
  
  ballSystem = new BallSystem();
  
  
  // Camera Setup
  camPos  = new PVector( width / 2.0f, height / 2.0f, height * 2.0f );
  centerX = width / 2.0f;
  centerY = height / 2.0f;
  centerZ = 0.0f;
  
  upX = 0.0f;
  upY = 1.0f;
  upZ = 0.0f;
  
  camera( camPos.x, camPos.y, camPos.z, 
          centerX, centerY, centerZ, 
          upX, upY, upZ );
          
  soundFileSetup();
}

void draw()
{
  background(0);
  
  lighting();
  ballSystem.run();
  corners();
}

/*
  Keys `, 1, 2, 3, 4, 5, 6, 7 , 8, 9, 0, -, = add balls to system
  key ` is the root note. 1 through = are how many semitones up from
  the root (- is 11; = is 12)
  Shift + those keys remove ball with that note value
*/
void keyPressed()
{
  if (key == '`')
    ballSystem.addBall( new Ball(1) );
  if (key == '1')
    ballSystem.addBall( new Ball(2) );
  if (key == '2')
    ballSystem.addBall( new Ball(3) );
  if (key == '3')
    ballSystem.addBall( new Ball(4) );
  if (key == '4')
    ballSystem.addBall( new Ball(5) );
  if (key == '5')
    ballSystem.addBall( new Ball(6) );
  if (key == '6')
    ballSystem.addBall( new Ball(7) );
  if (key == '7')
    ballSystem.addBall( new Ball(8) );
  if (key == '8')
    ballSystem.addBall( new Ball(9) );
  if (key == '9')
    ballSystem.addBall( new Ball(10) );
  if (key == '0')
    ballSystem.addBall( new Ball(11) );
  if (key == '-')
    ballSystem.addBall( new Ball(12) );
  if (key == '=')
    ballSystem.addBall( new Ball(13) );
    
  if (key == '~')
    ballSystem.removeBall(1);
  if (key == '!')
    ballSystem.removeBall(2);
  if (key == '@')
    ballSystem.removeBall(3);
  if (key == '#')
    ballSystem.removeBall(4);
  if (key == '$')
    ballSystem.removeBall(5);
  if (key == '%')
    ballSystem.removeBall(6);
  if (key == '^')
    ballSystem.removeBall(7);
  if (key == '&')
    ballSystem.removeBall(8);
  if (key == '*')
    ballSystem.removeBall(9);
  if (key == '(')
    ballSystem.removeBall(10);
  if (key == ')')
    ballSystem.removeBall(11);
  if (key == '_')
    ballSystem.removeBall(12);
  if (key == '+')
    ballSystem.removeBall(13);
    
  if (key == 'x')
    ballSystem.removeAll();
}


// Draws boxes at corners of space
void corners()
{
  noStroke();
  fill(125, 125, 125);
  float boxSize = 30.0f;
  
  pushMatrix();
    translate(0.0f, 0.0f, height);
    box(boxSize);
  popMatrix();
  
  pushMatrix();
    translate(0.0f, 0.0f, -height);
    box(boxSize);
  popMatrix();
  
  pushMatrix();
    translate(width, 0.0f, height);
    box(boxSize);
  popMatrix();
  
  pushMatrix();
    translate(width, 0.0f, -height);
    box(boxSize);
  popMatrix();
  
  pushMatrix();
    translate(0.0f, height, height);
    box(boxSize);
  popMatrix();
  
  pushMatrix();
    translate(0.0f, height, -height);
    box(boxSize);
  popMatrix();
  
  pushMatrix();
    translate(width, height, height);
    box(boxSize);
  popMatrix();
  
  pushMatrix();
    translate(width, height, -height);
    box(boxSize);
  popMatrix();
}



// Controls lighting
void lighting()
{
  //ambientLights();
  directionalLights();
}

void ambientLights()
{
  //lightFalloff(2.0f, 0.0f, 0.0f);
  
  //ambientLight(0, 255, 0, width, 0.0f, 0.0f);
}

void directionalLights()
{
  lightFalloff(3.0f, 0.0f, 0.0f);
  
  ambientLight(255.0f, 255.0f, 255.0f);
  
  float r1 = (millis() * 0.01f) % 255;
  float g1 = (millis() * 0.07f) % 255;
  float b1 = (millis() * 0.11f) % 255;
  float r2 = (millis() * second() * 0.005f) % 255;
  float g2 = (millis() * 0.03) % 255;
  float b2 = (millis() / (second() + 1)) % 255;
  
  directionalLight(r1, g1, b1, 0.0f,  1.0f,  0.0f);
  directionalLight(r2, g2, 255.0f, b2,  -1.0f, 0.0f);
  directionalLight(b1, r1, g2, 1.0f,  0.0f,  0.0f);
  directionalLight(g1, b2, r2, -1.0f, 0.0f,  0.0f);
}




void soundFileSetup()
{
  loadBass();
  loadPad();
  loadPerc();
  
}


void loadPerc()
{
  float percAmp = 0.75f;
  
  boom1             = new SoundFile(this, "Sounds/1_Boom.wav");
  hit2min           = new SoundFile(this, "Sounds/2min_Hit.wav");
  hit2Maj           = new SoundFile(this, "Sounds/2Maj_Hit.wav");
  clack3min         = new SoundFile(this, "Sounds/3min_Clack.wav");
  clack3Maj         = new SoundFile(this, "Sounds/3Maj_Clack.wav");
  blewp4            = new SoundFile(this, "Sounds/4_Blewp.wav");
  spaceMetalTriTone = new SoundFile(this, "Sounds/5tritone_SpaceMetal.wav");
  boom5             = new SoundFile(this, "Sounds/5_Boom.wav");
  hat6min           = new SoundFile(this, "Sounds/6min_hat.wav");
  hat6maj           = new SoundFile(this, "Sounds/6Maj_hat.wav");
  hat7min           = new SoundFile(this, "Sounds/7min_Hat2.wav");
  hat7Maj           = new SoundFile(this, "Sounds/7Maj_Hat2.wav");
  octaHat           = new SoundFile(this, "Sounds/8_OctaHat.wav");
  
  boom1.amp             (percAmp);
  hit2min.amp           (percAmp);
  hit2Maj.amp           (percAmp);
  clack3min.amp         (percAmp);
  clack3Maj.amp         (percAmp);
  blewp4.amp            (percAmp);
  spaceMetalTriTone.amp (percAmp);
  boom5.amp             (percAmp);
  hat6min.amp           (percAmp);
  hat6maj.amp           (percAmp);
  hat7min.amp           (percAmp);
  hat7Maj.amp           (percAmp);
  octaHat.amp           (percAmp);
}


void loadPad()
{
  float padAmp  = 0.5f; 
  
  padC3  = new SoundFile(this, "Sounds/Pad_C3.wav" );
  padCs3 = new SoundFile(this, "Sounds/Pad_C#3.wav");
  padD3  = new SoundFile(this, "Sounds/Pad_D3.wav" );
  padDs3 = new SoundFile(this, "Sounds/Pad_D#3.wav");
  padE3  = new SoundFile(this, "Sounds/Pad_E3.wav" );
  padF3  = new SoundFile(this, "Sounds/Pad_F3.wav" );
  padFs3 = new SoundFile(this, "Sounds/Pad_F#3.wav");
  padG3  = new SoundFile(this, "Sounds/Pad_G3.wav" );
  padGs3 = new SoundFile(this, "Sounds/Pad_G#3.wav");
  padA3  = new SoundFile(this, "Sounds/Pad_A3.wav" );
  padAs3 = new SoundFile(this, "Sounds/Pad_A#3.wav");
  padB3  = new SoundFile(this, "Sounds/Pad_B3.wav" );
  padC4  = new SoundFile(this, "Sounds/Pad_C4.wav" );
  
  padC3.amp  (padAmp);
  padCs3.amp (padAmp);
  padD3.amp  (padAmp);
  padDs3.amp (padAmp);
  padE3.amp  (padAmp);
  padF3.amp  (padAmp);
  padFs3.amp (padAmp);
  padG3.amp  (padAmp);
  padGs3.amp (padAmp);
  padA3.amp  (padAmp);
  padAs3.amp (padAmp);
  padB3.amp  (padAmp);
  padC4.amp  (padAmp);
}

void loadBass()
{
  float bassAmp = 0.75f;
  
  bassC1  = new SoundFile(this, "Sounds/Bass_C1.wav" );
  bassCs1 = new SoundFile(this, "Sounds/Bass_C#1.wav");
  bassD1  = new SoundFile(this, "Sounds/Bass_D1.wav" );
  bassDs1 = new SoundFile(this, "Sounds/Bass_D#1.wav");
  bassE1  = new SoundFile(this, "Sounds/Bass_E1.wav" );
  bassF1  = new SoundFile(this, "Sounds/Bass_F1.wav" );
  bassFs1 = new SoundFile(this, "Sounds/Bass_F#1.wav");
  bassG1  = new SoundFile(this, "Sounds/Bass_G1.wav" );
  bassGs1 = new SoundFile(this, "Sounds/Bass_G#1.wav");
  bassA1  = new SoundFile(this, "Sounds/Bass_A1.wav" );
  bassAs1 = new SoundFile(this, "Sounds/Bass_A#1.wav");
  bassB1  = new SoundFile(this, "Sounds/Bass_B1.wav" );
  bassC2  = new SoundFile(this, "Sounds/Bass_C2.wav" );
  
  bassC1.amp  (bassAmp);
  bassCs1.amp (bassAmp);
  bassD1.amp  (bassAmp);
  bassDs1.amp (bassAmp);
  bassE1.amp  (bassAmp);
  bassF1.amp  (bassAmp);
  bassFs1.amp (bassAmp);
  bassG1.amp  (bassAmp);
  bassGs1.amp (bassAmp);
  bassA1.amp  (bassAmp);
  bassAs1.amp (bassAmp);
  bassB1.amp  (bassAmp);
  bassC2.amp  (bassAmp);
}
