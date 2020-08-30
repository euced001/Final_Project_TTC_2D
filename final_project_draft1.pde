//SOURCES: 
//https://youtu.be/aKYlikFAV4k for A* Algorithm

//NOTES:
//Implemented hw3_interatcion_two_rev2 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


int numAgents = 50;
int numpoints = 10;//25;//10; //numpoints is the number of sample points for PRM
int radiusOfPercep = 50;//500; //50;
int radius = 100;
int agentAndTargetRadius = 25;

VECTOR ZERO = new VECTOR (0,0,0); //the zero vectoe
VECTOR sphere = new VECTOR(400,400,0);

VECTOR steering = new VECTOR(0,0,0);
VECTOR goal = new VECTOR(750, 50, 0);
VECTOR agentStart = new VECTOR(50, 750, 0);

AGENT[] agent1;

VECTOR point; //???
//int numpoints = 13; //first two elements are agents; the last 1 elment is the goal. The other 10 are the nodes //play around with num of points; more points leads to possibility of finding the ideal path

VECTOR[] PRMpoints = new VECTOR[numpoints]; 

int circlesTotal = 0;
CIRCLE[] circles;

void setup(){
        size(800,800, P3D);
        agent1 = new AGENT[numAgents];
        //circles = new CIRCLE[1000]; //max size of circles is 1000
        
        //findPRMpoints();
        
        //for(int i = 0; i < numAgents; i++){
        //     //use if/else for one agent to use bfs 
        //     //if(i == 0){    
        //           agent1[i] = new AGENT(PRMpoints, agentStart);
        //           agent1[i].colors = #3FD61E;
        //           agent1[i].bfs();
        //           agent1[i].nextNode = agent1[i].path.size()-2;        
        //     //}
        //     //else{
        //     //     VECTOR random = new VECTOR(random(50, 300),random(500,750),0); 
        //     //     agent1[i] = new AGENT(PRMpoints, random);
        //     //}
        //}      

    
        //for(int i = 0; i < numAgents; i++){
 
        //     VECTOR random = new VECTOR(random(0, width),random(0,height),0); 
        //     agent1[i] = new AGENT(PRMpoints, random);          
          
        //     //agent1[i] = new AGENT(PRMpoints, agentStart);
        //     agent1[i].colors = #3FD61E;
        //     agent1[i].bfs();
        //     agent1[i].nextNode = agent1[i].path.size()-2;        

        //}     
        //for just boids
        //for(int i = 0; i < numAgents; i++){
        //     VECTOR random = new VECTOR(random(0, width),random(0,height),0); 
        //     agent1[i] = new AGENT(random); 
           
        //}
        //println("Set up is complete!");
                     goal = new VECTOR(400, 400, 0);

        //for ttc
        for(int i = 0; i < numAgents; i++){
             //*VECTOR random = new VECTOR(random(50, 150),random(550,700),0); 
             VECTOR random = new VECTOR(random(width),random(height),0); 
             float randomRadius = random(0, 25);
             //*goal = new VECTOR(random(0, width), random(0, height), 0);
             agent1[i] = new AGENT(random, randomRadius); 
           
        }
        println("Set up is complete!");        
}

///START//////////////////DRAW////////////////////////////////////////////////////DRAW///////////////////////////////////////////

void draw(){ 
        background(255, 255, 255);     
        //for boids
        //for(int i = 0; i < numAgents; i++){
        //      agent1[i].edges();
        //      align(agent1[i]); 
        //      cohesion(agent1[i]);
        //      separation(agent1[i]);
        //      agent1[i].updateposit(1/frameRate);        
        //} 
        //for ttc
        for(int i = 0; i < numAgents; i++){
            //agent1[i].edges();
            //*ttcAlgorithm(agent1[i], 1/frameRate);
            float d = distance(agent1[i].position, goal);
            if(d > agentAndTargetRadius*1.5){
              ttcAlgorithm(agent1[i], 1/frameRate);
              
            }
        
        
        }
        
        //agent1[0].edges();
        //drawObstacles();
        //separate();
        //for(int k = 0; k<circlesTotal; k++){
           
        //       if(distance(agent1[0].position, circles[k].position) < circles[k].radius + 5){
              
        //            separation(agent1[0]);
        //            agent1[0].updateposit(1/frameRate);       
        //       }       
        //}
        //agent1[0].updatevelocity(1/frameRate, agent1[0].nextNode);
        //agent1[0].updateposit(1/frameRate);    
        //draw the circles
        //drawCircles();
        // draw the paths
        //drawPaths();
 
        ////start of draw PRM points 
        //for (int i = 1; i < numpoints-1; i++) {       
        //    pushMatrix();
        //    fill(0, 0, 255);
        //    circle(agent1[0].arrayOfPoints[i].xp, agent1[0].arrayOfPoints[i].yp, agentAndTargetRadius*.5);
        //    popMatrix();
        //}
        //end of draw PRM points

        drawSphere();
        drawAgents();

        //Draw the Goal
        pushMatrix();
        fill(0, 255, 0);
        circle(750, 50, agentAndTargetRadius);
        popMatrix();

}
////END/////////////////DRAW////////////////////////////////////////////////////DRAW///////////////////////////////////////////

























  
