
//add new circles
void drawObstacles(){

            if(mousePressed){
            
              delay(100);//ensure we only create one circle per click
              VECTOR mouse = new VECTOR(mouseX, mouseY, 0);
              circles[circlesTotal]  = new CIRCLE(mouse, 100, #F919FA);
              circlesTotal++;
              
              agent1[0].arrayOfPoints[0] = agent1[0].position;
              agent1[0].path = new ArrayList(); //now the path is empty
              
              agent1[0].bfs();
              agent1[0].nextNode = agent1[0].path.size()-2;   
            } 
  
  
}   

void separate(){

          if(distance(agent1[0].position, sphere) < 110){
             
                separation(agent1[0]);
                agent1[0].updateposit(1/frameRate);    
          }
            
          else{
               
                agent1[0].updatevelocity(1/frameRate, agent1[0].nextNode);
                agent1[0].updateposit(1/frameRate);
          } 


}
//continuosly draw the circles
void drawCircles(){

          for(int i = 0; i < circlesTotal; i++){
           
              pushMatrix();
              fill(circles[i].colors);
              circle(circles[i].position.xp, circles[i].position.yp, circles[i].radius);
              popMatrix();
           
          }
 
}

void drawPaths(){
          for (int i = 0; i < numpoints; i++){
              for (int j = 0; j < agent1[0].neighbors[i].size(); j++){
             
                  pushMatrix();
                  fill(200);
                  line(agent1[0].arrayOfPoints[i].xp, agent1[0].arrayOfPoints[i].yp, agent1[0].arrayOfPoints[agent1[0].neighbors[i].get(j)].xp, agent1[0].arrayOfPoints[agent1[0].neighbors[i].get(j)].yp);
                  popMatrix();
              
              }
         }
}

void drawSphere(){
  
          pushMatrix();
          fill(0, 0, 255);
          circle(sphere.xp, sphere.yp, radius);
          popMatrix();
}


void drawAgents(){
  
  
           //first agent is RED
          for(int i = 0; i < numAgents; i ++){
              if(i == 5){
                  pushMatrix();
                  //fill(agent1[i].colors);
                  fill(255,0,0);
                  translate(agent1[i].position.xp, agent1[i].position.yp);
                  circle(0,0, agentAndTargetRadius*.5);
                  popMatrix();
                  agent1[i].agentGoal.vectorPrint();
                  //draw the goal for agent 0
                  pushMatrix();
                  fill(255,0,0); 
                  circle(agent1[i].agentGoal.xp,agent1[i].agentGoal.yp, agentAndTargetRadius*.75);
                  popMatrix();
              } 
              else{  
                  pushMatrix();
                  fill(agent1[i].colors);
                  translate(agent1[i].position.xp, agent1[i].position.yp);
                  circle(0,0, agentAndTargetRadius*.5);
                  popMatrix();
              }
                         
          }

}
