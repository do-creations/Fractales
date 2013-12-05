//
//  tapete.cpp
//  Fractales
//
//  Created by Jorge Ruiz on 11/6/13.
//
//

#include "tapete.h"

typedef struct
{
    float x, y, bok;
}pdata;

void tapete(float x, float y, float sz, float k, ofColor color)
{
    ////LIMITACION DE ITERACIONES
    if(k > 6){
        k = 6;
    }
    
    pdata p1, p2;
    
    p1.x = x;
    p1.y = y;
    p1.bok = sz;
    
    p2.x = x+sz/3;
    p2.y = y+sz/3;
    p2.bok = sz/3;
    
    //printf("x2 %f, y2 %f , sz2 %f", p2.x, p2.y, p2.bok);
    
    
    //ofScale(10/sz, 10/sz);
    ofSetColor(color);
    ofRect(ofRectangle(p1.x, p1.y, p1.bok, p1.bok));
    if(k>0){
        ofSetColor(ofColor(0,0,0));
        ofRect(ofRectangle(p2.x, p2.y, p2.bok, p2.bok));
    }
    
    if(k>1)
    {
        tapete(x,y,sz/3,k-1,color);
        tapete(x+sz/3,y,sz/3,k-1,color);
        tapete(x+sz-sz/3,y,sz/3,k-1,color);
        tapete(x+sz-sz/3,y+sz/3,sz/3,k-1,color);
        tapete(x+sz-sz/3,y+sz-sz/3,sz/3,k-1,color);
        tapete(x+sz/3,y+sz-sz/3,sz/3,k-1,color);
        tapete(x,y+sz-sz/3,sz/3,k-1,color);
        tapete(x,y+sz/3,sz/3,k-1,color);
    }
    
}
