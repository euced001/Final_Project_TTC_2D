class AGENT{

      float speed = 35; //50;
      int num = numpoints + 1;
      color colors;
      boolean atEnd = false;
  
      VECTOR position;
      VECTOR velocity;
      VECTOR acceleration;
      
      //For TTC
      float agentRadius; // = agentAndTargetRadius ; //for ttc
      float sensingRadius; //= agentRadius + 15; //for ttc???
      VECTOR goalVelocity; //for ttc
      VECTOR goalForce = new VECTOR(0, 0, 0);//for ttc
      VECTOR start = new VECTOR(0,0,0);//for ttc
      VECTOR agentGoal = goal;//for ttc
      VECTOR forceAvoid = new VECTOR(0, 0, 0);//for ttc
      
      
      VECTOR[] arrayOfPoints = new VECTOR[num];

      //For BFS
      //array of booleans to determine if visited
      boolean visited[]  = new boolean[num]; 
      ArrayList<Integer>[] neighbors = new ArrayList[num];  //A list of neighbors can can be reached from a given node
      int[] parent = new  int[num];
      //To store the path
      ArrayList<Integer> path = new ArrayList(); 
      int nextNode; //keeps track of the next path

      AGENT(VECTOR[] array, VECTOR i_position){    
       
           position = new VECTOR(0,0,0);
           velocity = new VECTOR(random(-20, 20),random(-20,20),0);
           acceleration = new VECTOR(0,0,0);
           
           position = i_position;
           
           arrayOfPoints[0] = position;
           //copy the points onto the array for the agent
           for(int i = 1; i < num; i++)
           {
             arrayOfPoints[i] = array[i-1];     
           }
     }
     //for just boids
      AGENT(VECTOR i_position){    
       
           position = new VECTOR(0,0,0);
           velocity = new VECTOR(random(-20, 20),random(-20,20),0);
           acceleration = new VECTOR(0,0,0);
           
           position = i_position;
          
 
     }     
     //for TTC
     //AGENT(VECTOR[] array, VECTOR i_position, int i_radius){    
     AGENT(VECTOR i_position, float i_radius){    
           
           position = new VECTOR(0,0,0);
           velocity = new VECTOR(random(-20, 20),random(-20,20),0);
           acceleration = new VECTOR(0,0,0);
           goalVelocity = new VECTOR(0, 0, 0);
           start = i_position;
           position = i_position;
           agentRadius = i_radius;
           sensingRadius = agentRadius; //+ random(0,5);
           
           goalVelocity.subtract(start,agentGoal);
           goalVelocity.normalizev();
           goalVelocity = new VECTOR(goalVelocity.xpn, goalVelocity.ypn, goalVelocity.zpn); //now goalVelocity vecotor is normal
           
           //goalForce.subtract(goalVelocity, goalVelocity);   //compute the goal force eqn 19.3
           //goalForce.scalarmultiply(2);
              
          
    }    

    void edges(){
    
     if(position.xp  > width){
         position.xp = 0;}
     else if(position.xp < 0){
         position.xp = width;}
         
     if(position.yp  > height){
         position.yp = 0;}
     else if(position.yp < 0){
         position.yp = height;}

    }
      
      //Implement BFS
      
    void bfs() {
      //initialize the arrays to represent the graph
      for (int i = 0; i < num; i++)
      { 
        neighbors[i] = new ArrayList<Integer>(); 
        visited[i] = false;
        parent[i] = -1; //No partent yet
      }
      
      connect();
      println("List of Neghbors:");
      println(neighbors);
    
      int start = 0;
      int goal = num - 1;
    
    
      ArrayList<Integer> fringe = new ArrayList(); 
      println("\nBeginning Search");
    
      visited[start] = true;
      fringe.add(start);
      println("Adding node", start, "(start) to the fringe.");
      println(" Current Fring: ", fringe);
    
      while (fringe.size() > 0) {
        int currentNode = fringe.get(0);
        fringe.remove(0);
        if (currentNode == goal) {
          println("Goal found!");
          break;
        }
        for (int i = 0; i < neighbors[currentNode].size(); i++) {
          int neighborNode = neighbors[currentNode].get(i);
          if (!visited[neighborNode]) {
            visited[neighborNode] = true;
            parent[neighborNode] = currentNode;
            fringe.add(neighborNode);
            println("Added node", neighborNode, "to the fringe.");
            println(" Current Fringe: ", fringe);
          }
        }
      }
      
      
      print("\nReverse path: ");
      int prevNode = parent[goal];
      path.add(goal);
      print(goal, " ");
      while (prevNode >= 0) {
        print(prevNode, " ");
        path.add(prevNode);
        prevNode = parent[prevNode];
      }
      print("\n");
      println("The path is:");
      println(path);
      print("\n");
    }
      
   void updateposit(float dt){
      
       velocity.normalizev();
       velocity = new VECTOR(velocity.xpn, velocity.ypn, velocity.zpn);
          
       velocity = velocity.scalarmultiply(speed*dt);
 
      
       position.addv(position, velocity);
        
       acceleration = acceleration.scalarmultiply(dt);
       velocity.addv(velocity, acceleration);
        
    }  

    void updatevelocity(float dt, int count){     
      
        if(count == -1){      
            count = 0;           
        }      
        // Head to the first stop in the path
        if(count == path.size()-2)
        { 
          //SOMETIMES CODE BREAKS HERE
            velocity.subtract(arrayOfPoints[path.get(count)], position); 
        }
        //check if we are close enough to head towards the next stop
       if(position.distance(position, arrayOfPoints[path.get(count)]) < 1 & count > 0)
        {     
           print("too close");
           velocity.subtract(arrayOfPoints[path.get(count)], position);    
           nextNode--;
        }
        
       //check if near the gaol
       if(count == 0)
       {           
         if(atEnd == false){
      
           velocity.subtract(arrayOfPoints[path.get(count)], position);
      
          
           if(position.distance(position, arrayOfPoints[path.get(count)]) < 10){             
                    atEnd = true;
                    colors = #4BDCF7;
                     
                     velocity.xp = random(-20, 20);
                     velocity.yp = random(-20, 20);
                     velocity.zp = random(-20, 20);        
           }
          
       }   
       
    }  
      
  }
     
   void connect()
      {
        //boolean collide = false;
        for (int i = 0; i < num; i++)
        {
      
          
          VECTOR poc = new VECTOR(0,0,0);
          poc.subtract(arrayOfPoints[i], sphere);
          
          float c; 
          c = (poc.xp*poc.xp) + (poc.yp*poc.yp) - (radius*radius);
          // This should avoid connecting with oneself and also checking twice for the same pair of points
         
          for ( int j = i+1; j < num; j++)
          {
            boolean collide = false;
            VECTOR vel = new VECTOR(0,0,0);
            vel.subtract(arrayOfPoints[i], arrayOfPoints[j]);
      
            float a; 
            
            a = vel.magnitude();
            a *= a;
      
            float b;
            b = 2*vel.dotv(vel, poc);
    
                  for(int k = 0; k < circlesTotal; k++){
                  
                      VECTOR pock = new VECTOR(0, 0, 0);   
                      pock.subtract(arrayOfPoints[i], circles[k].position);
         
                      float ck; 
                      ck = (pock.xp*pock.xp) + (pock.yp*pock.yp) - (circles[k].radius*circles[k].radius);
                      
                            
                      float ak; 
                      ak = vel.magnitude();
                      ak *= ak;
                
                      float bk;
                      bk = 2*vel.dotv(vel, pock);
                      
                      if (sqrt(bk*bk - 4*ak*ck) > 0)
                      {
                        collide = true;      
                      } 
                      else
                      {
                      }
      
                    println(k);
                    print(collide);
                
               }
           
            
            //checking for j = 2 should avoid connecting the agents
            //if (sqrt(b*b - 4*a*c) > 0 && (collide == false))
            if (sqrt(b*b - 4*a*c) > 0 )
            {
              collide = true;
            } 
            else if( collide == false)
            {
              neighbors[i].add(j);
            }
          }
  
        }//outerloop
      }
      

     
}//class
