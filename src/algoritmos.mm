//
//  algoritmos.cpp
//
//  Created by Jorge Ruiz on 11/6/13.
//
//

#include "algoritmos.h"

//ofParameter<ofVec2f> centro;



void setPosition( float x, float y){
    /*
    position[0] = xpos;//input[0];
    position[1] = ypos;//input[1];
     */
    ofTranslate(x,y);
}
void triangle( point2 a, point2 b, point2 c, ofVec2f centro, int rotacion)

/* display one triangle  */
{
    ofPushMatrix();
    //ofTranslate((ofVec2f)centro);
    //ofTranslate(position[0], position[1]);
    
    //ofScale(100.0, 100.0);
    //ofTriangle(v[0][0], v[0][1], v[1][0], v[1][1], v[2][0], v[2][1]);
    float xx = (a[0]+b[0]+c[0])/3;
    float yy = (a[1]+b[1]+b[1])/3;
    
    
    //glTranslatef(-(a[0] + (c[0]-a[0])/2), -(c[1] + (b[1]-c[1])/2), 0.0);
    
    //ofTranslate( -(b[0]-xx), -(b[1]+yy));
    //ofTranslate(centro);


    //ofRotate((float)rotacion, 0.0, 0.0, 1.0);
    
    //glTranslatef((c[0] + (a[0]-c[0])/2), (c[1] + (b[1]-c[1])/2), 0.0);
    //glTranslatef((a[0]+b[0]+c[0])/3, (a[1]+b[1]+b[1])/3, 0.0);
    ofTriangle(a[0], a[1], b[0], b[1], c[0], c[1]);

    
    //ofTranslate(b[0]-xx, b[1]+yy);

    
    
    //ofRotate((float)-rotacion, 0.0, 0.0, 1.0);
    
    //glTranslatef((c[0] + (a[0]-c[0])/2), (c[1] + (b[1]-c[1])/2), 0.0);

    

    ofPopMatrix();
    
    /*
     glBegin(GL_TRIANGLES);
     glVertex2fv(a);
     glVertex2fv(b);
     glVertex2fv(c);
     glEnd();
     */
}

void divide_triangle(point2 a, point2 b, point2 c, int m,ofVec2f centro, int rotacion)
{
    
    point2 v0, v1, v2;
    int j;
    if(m>0)
    {
        for(j=0; j<2; j++) v0[j]=(a[j]+b[j])/2;
        for(j=0; j<2; j++) v1[j]=(a[j]+c[j])/2;
        for(j=0; j<2; j++) v2[j]=(b[j]+c[j])/2;
        divide_triangle(a, v0, v1, m-1, centro, rotacion);
        divide_triangle(c, v1, v2, m-1, centro, rotacion);
        divide_triangle(b, v2, v0, m-1, centro, rotacion);
    }
    else(triangle(a,b,c,centro, rotacion)); /* draw triangle at end of recursion */
}