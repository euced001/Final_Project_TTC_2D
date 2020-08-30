void findPRMpoints(){
          
          PRMpoints[numpoints-1] = goal;
          println("The goal is:");
          PRMpoints[numpoints-1].vectorPrint();
         
          for (int i = 0; i < numpoints-1; i++)
          {         
              VECTOR samplePoint = new VECTOR(random(0,800), random(0, 800), 0);
              
              float dist;
              dist = distance(samplePoint, sphere);
              dist *= dist;
              
              
              //while((xpoint - xsphere)*(xpoint - xsphere) + (ypoint - ysphere)*(ypoint - ysphere) <= (radius)*(radius))
              while(dist <= radius)
              {   
                  //VECTOR addFive = new VECTOR(5, 5, 5);
                  //samplePoint.addv(samplePoint, addFive);
                  samplePoint = new VECTOR(random(0, 800), random(0, 800), 0);
              }
              
              PRMpoints[i] = samplePoint;
              println(i);
              println("the sample point is:");
              PRMpoints[i].vectorPrint();
              println();

          }
          println("Done sampling points!");
}

float distance(VECTOR firstVector, VECTOR secondVector)
{  
          float xdiff;
          float ydiff;
          float zdiff;
          xdiff = firstVector.xp - secondVector.xp;
          ydiff = firstVector.yp - secondVector.yp;
          zdiff = firstVector.zp - secondVector.zp;
          
          return sqrt(xdiff*xdiff + ydiff*ydiff + zdiff*zdiff);  
} 
                    
