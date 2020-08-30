/////START////BOIDS//////////////BOIDS//////////////////BOIDS///////////////////////////////////////////
                    
void align(AGENT agent){  
      VECTOR average = new VECTOR(0,0,0);
      int total = 0;
      agent.acceleration = new VECTOR(0,0,0);
      
      for(int i = 0; i < numAgents; i++){
        
          if( distance(agent.position, agent1[i].position) <= radiusOfPercep){
            
              average.addv(average, agent1[i].velocity);
              total++;   
            }             
      }       
      if(total > 0){ 
          average  = average.scalarmultiply(1/total);        
          steering.subtract(average, agent.velocity);
      }
      agent.acceleration = steering;    
}

//cohesion is the same concept as align, but it uses position instead of velocity
void cohesion(AGENT agent){
      VECTOR average = new VECTOR(0,0,0);    
      int total = 0;
      for(int i = 0; i < numAgents; i++){
          if( distance(agent.position, agent1[i].position) <= radiusOfPercep ){    
              average.addv(average, agent1[i].position);
              total++;
          }             
      }  
      if(total > 0){
          average  = average.scalarmultiply(1/total);        
          steering.subtract(average, agent.position);        
      }
      agent.acceleration = steering;
}

void separation(AGENT agent){
      VECTOR average = new VECTOR(0,0,0);
      int total = 0;
      float d;
      
      for(int i = 0; i < numAgents; i++){
           d = distance(agent.position, agent1[i].position); 
           if( d <= radiusOfPercep && agent != agent1[i]){
              VECTOR diff = new VECTOR(0,0,0);
              //the strength of the force should be proportional to the distance. That is, a boid should work harder to 
              //stay away from a closer boid than a farther boid.
              //diffx = (agent.xP - agent1[i].xP)/d; 
              //diffy = (agent.yP - agent1[i].yP)/d;
              diff.subtract(agent.position, agent1[i].position);
              diff = diff.scalarmultiply(1/d);
              //xavg += diffx;
              //yavg += diffy;
              average.addv(average, diff);   
              total++;      
         }    
        // the separation from the sphere used to be in the for loop      
      }         
      d = distance(agent.position, sphere);
      if(d < 105){
      VECTOR diff = new VECTOR(0,0,0);                       
              //diffx = (agent.xP - xsphere)/d;
              //diffy = (agent.yP - ysphere)/d;
              diff.subtract(agent.position, sphere);
              diff.scalarmultiply(1/d);              
              //xavg += diffx;
              //yavg += diffy;
              average.addv(average, diff); 
              total++;      
      }      
      for(int k = 0; k < circlesTotal; k++){
            d = distance(agent.position, circles[k].position);
            //if(d < 75 && agent.atEnd == true){
            if(d < circles[k].radius + 5){
                  VECTOR diff = new VECTOR(0,0,0);
                  //diffx = (agent.xP - circles[k].xp)/d;
                  //diffy = (agent.yP - circles[k].yp)/d;                  
                  diff.subtract(agent.position, circles[k].position);
                  diff.scalarmultiply(1/d);
                  //xavg += diffx;
                  //yavg += diffy;
                  average.addv(average, diff);
                  total++; 
              }  
      }        
      if(total > 0){
            //xavg = xavg/(total);
            //yavg = yavg/(total);        
            average.scalarmultiply(1/total); 
            //steeringx = xavg - agent.vx;
            //steeringy = yavg - agent.vy;
            steering.subtract(average, agent.velocity);
      }
      //agent.xAcc += 25*(steeringx);
      //agent.yAcc += 25*(steeringy);
      steering = steering.scalarmultiply(25);
      agent.acceleration.addv(agent.acceleration, steering);
}
/////END////BOIDS//////////////BOIDS//////////////////BOIDS///////////////////////////////////////////
