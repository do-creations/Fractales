//
//  algoritmos.h
//  ofxGuiExample
//
//  Created by Jorge Ruiz on 11/6/13.
//
//

#ifndef __ofxGuiExample__algoritmos__
#define __ofxGuiExample__algoritmos__

#include <iostream>
//#include "testApp.h"
#include "ofxiOSExtras.h"
//#include "ofxGui.h"
#endif /* defined(__ofxGuiExample__algoritmos__) */

typedef float point2[2];
int fraclevel = 3;
int minfraclevel = 0;
int maxfraclevel = 12;
//ofParameter<ofVec2f> centro;
point2 position = { 0.0,0.0 };
float xpos = 0.0;
float ypos = 0.0;
void triangle( point2 a, point2 b, point2 c, ofVec2f centro);
void divide_triangle(point2 a, point2 b, point2 c, int m,ofVec2f centro,int rotacion);
void setPosition( float x, float y);