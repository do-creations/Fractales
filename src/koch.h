//
//  koch.h
//  Fractales
//
//  Created by Jorge Ruiz on 11/6/13.
//
//

#ifndef __Fractales__koch__
#define __Fractales__koch__

#include <iostream>
#include <math.h>
#include "ofxiOSExtras.h"
#define M_PI (3.1415926535897932384626433832795)

#endif /* defined(__Fractales__koch__) */

class Turtle
{
    // ***** class Turtle: ctors, etc. *****
public:
    
    Turtle()                         // Default ctor
    { reset(); }
    
    // Compiler-generated dctor, copy ctor, copy op= are fine
    
    // ***** class Turtle: Public Functions *****
public:
    
    void reset()                     // Restore initial state
    { x = 0.0; y = 0.0; dir = 0.0; draw = true; }
    
    void setpos(const double newx, const double newy)
    { x = newx; y = newy; }          // Set position x & y
    
    void setdir(const double newdir) // Set direction in degrees ccw from east
    { dir = newdir; }
    
    void left(const double angle)    // Turn - angle is in degrees
    { dir += angle; }
    
    void right(const double angle)   // Turn - angle is in degrees
    { left(-angle); }
    
    void pendown()                   // Lower pen; turn drawing on
    { draw = true; }
    
    void penup()                     // Raise pen; turn drawing off
    { draw = false; }
    
    void forward(const double dist)  // Move forward; draw if pen is down
    {
        double newx = x + dist * cos(M_PI * dir / 180.0);
        double newy = y + dist * sin(M_PI * dir / 180.0);
        if (draw)
        {
            ofLine(x, y, newx, newy);
            /*
            glBegin(GL_LINES);
            glVertex2d(x, y);
            glVertex2d(newx, newy);
            glEnd();*/
        }
        x = newx;
        y = newy;
    }
    
    void back(const double dist)            // Move backward; draw if pen down
    { forward(-dist); }
    
    // ***** class Turtle: Data members *****
private:
    
    double x;    // Current x coordinate
    double y;    // Current y coordinate
    double dir;  // Current direction in degrees ccw from east
    bool draw;   // true if currently drawing (pen down)
    
};
void drawsnowflake(int fraclevel);