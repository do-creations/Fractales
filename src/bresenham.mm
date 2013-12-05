//
//  bresenham.cpp
//  Fractals
//
//  Created by Jorge Ruiz on 11/18/13.
//
//

#include "bresenham.h"


vector<coords> BresenhamLine(float x0, float y0, float x1, float y1)
{
    vector<coords> puntos;
	int x, y, dx, dy, xend, p, incE, incNE;
	//int maxY;
    
	dx = abs(x1 - x0);
    dy = abs(y1 - y0);
	
	//maxY=getmaxy();
    
	p = 2 * dy - dx;
    incE = 2 * dy;
    incNE = 2 * (dy - dx);
    
    /* determinar que punto usar para empezar, cual para terminar */
    if (x0 > x1) {
		x = x1;
		y = y1;
        xend = x0;
    }
    else {
        x = x0;
        y = y0;
        xend = x1;
    }
    
    /* se repite hasta llegar al extremo de la línea */
    while (x <= xend)
    {
        //putpixel(x, y);
        
        puntos.push_back((coords){x,y});
        //printf("puntos en b x %d y %d", x , y);
		x = x + 1;
        if (p < 0) {
            p = p + incE;
		}
        else {
            y = y + 1;
            p = p + incNE;
        }
    }
    return puntos;
}