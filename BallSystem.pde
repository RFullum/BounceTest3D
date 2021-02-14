class BallSystem
{
  ArrayList<Ball> balls;
  
  BallSystem()
  {
    balls = new ArrayList<Ball>();
  }
  
  
  
  void run()
  {
    for (Ball b : balls)
    {
      b.run(balls);
    }
  }
  
  
  
  void addBall(Ball b)
  {
    balls.add(b);
  }
  
  
  
  void removeBall(int noteKey)
  {
    boolean isNote = false;
    int i = balls.size() - 1;
    
    while (!isNote && i >= 0)
    {
      Ball instance = balls.get(i);
      
      if (instance.noteNumber == noteKey)
      {
        balls.remove(i);
        isNote = true;
      }
      
      i--;
    }
  }
  
  
  
  void removeAll()
  {
    balls.removeAll(balls);
  }
}
