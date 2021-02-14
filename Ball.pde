class Ball
{
  PVector position;
  PVector velocity;
  
  ArrayList<Ball> balls;
  
  color c;
  
  float radius;
  float maxSpeed = 5.0f;
  
  int noteNumber;
  
  // Constructor
  Ball(int noteNum)
  {
    noteNumber = noteNum;
    radius     = 125.0f;// / map( (float)noteNumber, 1.0f, 13.0f, 1.0f, 5.0f );
    ballSize();
    
    balls      = ballSystem.balls;
    
    position = new PVector( radius, radius, 0.0f); 
    velocity = new PVector( 0.0f, 0.0f, 0.0f );
    newPosition();
    newVelocity();
    
    float r = map( (float)noteNumber, 1.0f, 13.0f, 255.0f, 0.0f ) % 255.0f;
    float g = map( (float)noteNumber, 1.0f, 13.0f, 839.0f, 1693.0f ) % 255.0f;
    float b = map( (float)noteNumber, 1.0f, 13.0f, 1091.0f, 3109.0f ) % 255.0f;
    
    c = color(r, g, b);
  }
  
  
  // Adjusts radius based on noteNumber
  void ballSize()
  {
    switch(noteNumber)
    {
      case 1:  // root
        break;
      
      case 2:  // min 2
        radius *= (3.0f / 8.0f);
        break;
      
      case 3:  // Maj 2
        radius *= (3.0f / 8.0f);
        break;
      
      case 4:  // min 3
        radius *= (6.0f / 8.0f);
        break;
        
      case 5:  // Maj 3
        radius *= (6.0f / 8.0f);
        break;
      
      case 6:  // Perfect 4
        radius *= (5.0f / 8.0f);
        break;
        
      case 7:  // Tritone
        break;
        
      case 8:  // Perfect 5
        radius *= (7.0f / 8.0f);
        break;
      
      case 9:  // min 6
        radius *= (3.0f / 8.0f);
        break;
        
      case 10:  // Maj 6
        radius *= (3.0f / 8.0f);
        break;
        
      case 11:  // Dom 7
        radius *= (5.0f / 8.0f);
        break;
        
      case 12:  // Maj 7
        radius *= (4.0f / 8.0f);
        break;
        
      case 13:  // Octave
        radius *= (3.0f / 8.0f);
        break;
      
      default:
        break;
    }
  }
  
  // Sets a new random position if overlapping other balls (not 100%)
  void newPosition()
  {
    PVector newPos = new PVector( random(radius, width - radius), 
                                  random(radius, height - radius), 
                                  random(-height + radius, height - radius) );
    
    if (balls.size() > 0)
    {
      for (Ball other : balls)
      {
        float distance = PVector.dist(newPos, other.position);
        
        if (distance <= radius + other.radius && distance > 0.0f)
        {
          newPosition();
        }
        else
        {
          position = newPos.copy();
        }
      }
    }
  }
  
  
  
  // Sets new random velocity for instance of ball
  void newVelocity()
  {
    velocity = new PVector( random(1.0f, maxSpeed), 
                            random(1.0f, maxSpeed), 
                            random(1.0f, maxSpeed) );
  }
  
  
  
  // Calls methods to run the ball
  void run(ArrayList<Ball> balls_)
  {
    balls = balls_;
    
    update();
    borders();
    ballBounce(balls);
    render();
  }
  
  
  
  // Updates position by velocity
  void update()
  {
    position.add(velocity);
  }
  
  
  
  // Bounce off the screen limits
  void borders()
  {
    // Left wall = 1
    if (position.x <= radius)
    {
      position.x = radius;
      velocity.x *= -1.0f;
      
      contactCube ( position.copy(), 1 );
      playPerc();
    }
    
    // Right wall = 2
    if (position.x >= width - radius)
    {
      position.x = width - radius;
      velocity.x *= -1.0f;
      
      contactCube ( position.copy(), 2 );
      playPerc();
    }
    
    // Top wall = 4
    if (position.y <= radius)
    {
      position.y = radius;
      velocity.y *= -1.0f;
      
      contactCube ( position.copy(), 4 );
      playPerc();
    }
    
    // Bottom wall = 3
    if (position.y >= height - radius)
    {
      position.y = height - radius;
      velocity.y *= -1.0f;
      
      contactCube ( position.copy(), 3 );
      playPerc();
    }
    
    // Back wall = 0
    if (position.z <= -height + radius)
    {
      position.z = -height + radius;
      velocity.z *= -1.0f;
      
      contactCube ( position.copy(), 0 );
      playPerc();
    }
    
    // Front wall = 5
    if (position.z >= height - radius)
    {
      position.z = height - radius;
      velocity.z *= -1.0f;
      
      contactCube ( position.copy(), 5 );
      playPerc();
    }
  }    // End Borders
  
  
  
  // Draws cube on wall when hits invisible wall
  void contactCube( PVector ballPos, int wall)
  {
    float w;
    float h;
    float d;
    
    PVector location = ballPos;
      
    switch(wall)
    {      
      // back wall
      case 0:
        w = radius * 2.0f;
        h = radius * 2.0f;
        d = 10.0f;
        
        location.z -= radius;
        break;
      
      // left wall
      case 1:
        w = 10.0f;
        h = radius * 2.0f;
        d = radius * 2.0f;
        
        location.x -= radius;
        break;
        
      // right wall
      case 2:
        w = 10.0f;
        h = radius * 2.0f;
        d = radius * 2.0f;
        
        location.x += radius;
        break;
        
      // bottom wall
      case 3:
        w = radius * 2.0f;
        h = 10.0f;
        d = radius * 2.0f;
        
        location.y += radius;
        break;
        
      // top wall
      case 4:
        w = radius * 2.0f;
        h = 10.0f;
        d = radius * 2.0f;
        
        location.y -= radius;
        break;
      
      // front wall
      case 5:
        w = radius * 2.0f;
        h = radius * 2.0f;
        d = 10.0f;
        
        location.z += radius;
        break;
        
      default:
        w = 0.0f;
        h = 0.0f;
        d = 0.0f;
        break;
    }
    
    pushMatrix();
      translate ( location.x, location.y, location.z );
      box       ( w, h, d );
    popMatrix();
  }
  
  
  
  // Bounce off other balls
  void ballBounce(ArrayList<Ball> ballList)
  {
    for (Ball other : ballList)
    {
      // Distance between two balls
      float distance = PVector.dist(position, other.position);
      
      if (distance <= radius + other.radius && distance > 0.0f)
      {
        PVector vCopy  = velocity.copy();
        velocity       = other.velocity.copy();
        other.velocity = vCopy.copy();
        
        if (noteNumber == other.noteNumber)
        {
          playBass(balls);
        }
        else
        {
          playPad();
          other.playPad();
        }
      }
    }
  }
  
  
  
  // Plays the percussion sounds based on instance's noteNumber
  void playPerc()
  {
    switch(noteNumber)
    {
      case 1:
        if (boom1.isPlaying())
          boom1.stop();
          
        boom1.play();
        break;
        
      case 2:
        if (hit2min.isPlaying())
          hit2min.stop();
          
        hit2min.play();
        break;
        
      case 3:
        if (hit2Maj.isPlaying())
          hit2Maj.stop();
          
        hit2Maj.play();
        break;
        
      case 4:
        if (clack3min.isPlaying())
          clack3min.stop();
          
        clack3min.play();
        break;
        
      case 5:
        if (clack3Maj.isPlaying())
          clack3Maj.stop();
          
        clack3Maj.play();
        break;
        
      case 6:
        if (blewp4.isPlaying())
          blewp4.stop();
          
        blewp4.play();
        break;
        
      case 7:
        if (spaceMetalTriTone.isPlaying())
          spaceMetalTriTone.stop();
          
        spaceMetalTriTone.play();
        break;
        
      case 8:
        if (boom5.isPlaying())
          boom5.stop();
          
        boom5.play();
        break;
        
      case 9:
        if (hat6min.isPlaying())
          hat6min.stop();
          
        hat6min.play();
        break;
        
      case 10:
        if (hat6maj.isPlaying())
          hat6maj.stop();
          
        hat6maj.play();
        break;
      case 11:
        if (hat7min.isPlaying())
          hat7min.stop();
          
        hat7min.play();
        break;
        
      case 12:
        if (hat7Maj.isPlaying())
          hat7Maj.stop();
          
        hat7Maj.play();
        break;
        
      case 13:
        if (octaHat.isPlaying())
          octaHat.stop();
          
        octaHat.play();
        break;
        
      default:
        if (boom1.isPlaying())
          boom1.stop();
          
        boom1.play();
        break;
    }
  }
  
  
  
  // Plays pad based on instance's noteNumber
  void playPad()
  {
    switch(noteNumber)
    {
      case 1:
        if (padC3.isPlaying())
          padC3.stop();
          
        padC3.play();
        break;
        
      case 2:
        if (padCs3.isPlaying())
          padCs3.stop();
          
        padCs3.play();
        break;
        
      case 3:
        if (padD3.isPlaying())
          padD3.stop();
          
        padD3.play();
        break;
        
      case 4:
        if (padDs3.isPlaying())
          padDs3.stop();
          
        padDs3.play();
        break;
        
      case 5:
        if (padE3.isPlaying())
          padE3.stop();
          
        padE3.play();
        break;
        
      case 6:
        if (padF3.isPlaying())
          padF3.stop();
          
        padF3.play();
        break;
        
      case 7:
        if (padFs3.isPlaying())
          padFs3.stop();
          
        padFs3.play();
        break;
        
      case 8:
        if (padG3.isPlaying())
          padG3.stop();
          
        padG3.play();
        break;
        
      case 9:
        if (padGs3.isPlaying())
          padGs3.stop();
          
        padGs3.play();
        break;
        
      case 10:
        if (padA3.isPlaying())
          padA3.stop();
          
        padA3.play();
        break;
        
      case 11:
        if (padAs3.isPlaying())
          padAs3.stop();
          
        padAs3.play();
        break;
        
      case 12:
        if (padB3.isPlaying())
          padB3.stop();
          
        padB3.play();
        break;
        
      case 13:
        if (padC4.isPlaying())
          padC4.stop();
          
        padC4.play();
        break;
        
      default:
        if (padC3.isPlaying())
          padC3.stop();
          
        padC3.play();
        break;
    }
  }
  
  
  
  // Stops any currently playing bass
  void stopBass()
  {
    if (bassC1.isPlaying())
      bassC1.stop();
    else if (bassCs1.isPlaying())
      bassCs1.stop();
    else if (bassD1.isPlaying())
      bassD1.stop();
    else if (bassDs1.isPlaying())
      bassDs1.stop();
    else if (bassE1.isPlaying())
      bassE1.stop();
    else if (bassF1.isPlaying())
      bassF1.stop();
    else if (bassFs1.isPlaying())
      bassFs1.stop();
    else if (bassG1.isPlaying())
      bassG1.stop();
    else if (bassGs1.isPlaying())
      bassGs1.stop();
    else if (bassA1.isPlaying())
      bassA1.stop();
    else if (bassAs1.isPlaying())
      bassAs1.stop();
    else if (bassB1.isPlaying())
      bassB1.stop();
    else if (bassC2.isPlaying())
      bassC2.stop();
  }
  
  
  
  // Stops any other playing bass, then plays bass based on instance noteNumber
  void playBass(ArrayList<Ball> ballList)
  {
    for (Ball other : ballList)
    {
      other.stopBass();
    }
    
    switch(noteNumber)
    {
      case 1:
        if (bassC1.isPlaying())
          bassC1.stop();
          
        bassC1.play();
        break;
        
      case 2:
        if (bassCs1.isPlaying())
          bassCs1.stop();
          
        bassCs1.play();
        break;
        
      case 3:
        if (bassD1.isPlaying())
          bassD1.stop();
          
        bassD1.play();
        break;
        
      case 4:
        if (bassDs1.isPlaying())
          bassDs1.stop();
          
        bassDs1.play();
        break;
        
      case 5:
        if (bassE1.isPlaying())
          bassE1.stop();
          
        bassE1.play();
        break;
        
      case 6:
        if (bassF1.isPlaying())
          bassF1.stop();
          
        bassF1.play();
        break;
        
      case 7:
        if (bassFs1.isPlaying())
          bassFs1.stop();
          
        bassFs1.play();
        break;
        
      case 8:
        if (bassG1.isPlaying())
          bassG1.stop();
          
        bassG1.play();
        break;
        
      case 9:
        if (bassGs1.isPlaying())
          bassGs1.stop();
          
        bassGs1.play();
        break;
        
      case 10:
        if (bassA1.isPlaying())
          bassA1.stop();
          
        bassA1.play();
        break;
        
      case 11:
        if (bassAs1.isPlaying())
          bassAs1.stop();
          
        bassAs1.play();
        break;
        
      case 12:
        if (bassB1.isPlaying())
          bassB1.stop();
          
        bassB1.play();
        break;
        
      case 13:
        if (bassC2.isPlaying())
          bassC2.stop();
          
        bassC2.play();
        break;
        
      default:
        if (bassC1.isPlaying())
          bassC1.stop();
          
        bassC1.play();
        break;
    }
  }
  
  
  
  
  // Draw the ball on screen
  void render()
  {
    noStroke();
    //stroke(50, 0, 50);
    
    fill( c );
    
    pushMatrix();
      translate ( position.x, position.y, position.z );
      sphere    ( radius );
    popMatrix();
  }
  
  
}
