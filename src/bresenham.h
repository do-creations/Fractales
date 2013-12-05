//
//  bresenham.h
//  Fractals
//
//  Created by Jorge Ruiz on 11/18/13.
//
//

#ifndef __Fractals__bresenham__
#define __Fractals__bresenham__

#include <iostream>
#include "ofxiOS.h"
#include <vector>
//#include <vector>
//#include "ofxiOSExtras.h"
//#include "ofxGui.h"

#endif /* defined(__Fractals__bresenham__) */

typedef struct{
    int x;
    int y;
}coords;

vector<coords> BresenhamLine(float x0, float y0, float x1, float y1);
