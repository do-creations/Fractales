//
//  koch.cpp
//  Fractales
//
//  Created by Jorge Ruiz on 11/6/13.
//
//

#include "koch.h"


Turtle t;                     // The turtle

//int fraclevel = 5;
template<typename T>
std::string tostring(const T & input)
{
    std::ostringstream os;
    os << input;
    return os.str();
}

/*
// printbitmap
// Prints the given string at the given raster position
//  using GLUT bitmap fonts.
// You probably don't want any rotations in the model/view
//  transformation when calling this function.
void printbitmap(const string msg, double x, double y)
{
    glRasterPos2d(x, y);
    for (string::const_iterator ii = msg.begin();
         ii != msg.end();
         ++ii)
    {
        glutBitmapCharacter(GLUT_BITMAP_9_BY_15, *ii);
    }
}
*/

// drawkoch_recurse
// Draws a Koch curve at the given level, with the given length,
// using the turtle.
// If level is 0, draws a line segment. Otherwise, recursively
// draws the curve.
void drawkoch_recurse(int level, double length)
{
    /*
    if(color == true){
        glColor3f((float)(rand()%10)/10.0, (float)(rand()%10)/10.0, (float)(rand()%10)/10.0);
    }
    else{
        glColor3f(0.0,0.0,0.0);
    }
     */
    if (level <= 0)
    {
        t.forward(length);
    }
    else
    {
        drawkoch_recurse(level-1, length/3.0);
        t.left(60);
        drawkoch_recurse(level-1, length/3.0);
        t.right(120);
        drawkoch_recurse(level-1, length/3.0);
        t.left(60);
        drawkoch_recurse(level-1, length/3.0);
    }
}

void drawsnowflake(int fraclevel)
{
    const double fracsize = 1.0;
    
    t.reset();
    t.setpos(-0.5, 0.3);  // Positioned at (-0.5, 0.3)
    t.setdir(0.0);        // Facing east
    
    // Draw three Koch curve segments:
    // level = fraclevel, length = fracsize
    drawkoch_recurse(fraclevel, fracsize);
    t.right(120);
    drawkoch_recurse(fraclevel, fracsize);
    t.right(120);
    drawkoch_recurse(fraclevel, fracsize);
}
