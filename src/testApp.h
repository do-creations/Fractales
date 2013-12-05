#pragma once


#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxGui.h"
#include "algoritmos.h"
#include "koch.h"
#include "tapete.h"
#include "bresenham.h"


typedef struct  {
    int operation;
    float pars[2];    //parameters scale sx,sy traslate dx, dy rotate (cw/acw),degs reflection bx,by
    bool played;
    bool taken;
    float time;
}ops;

class testApp : public ofxiOSApp{
	
    public:
    
        testApp();
        ~testApp();
        void setup();
        void update();
        void draw();
        void exit();
    
        //void touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data);
        //void touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data);
        //void touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data);
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

        void circleResolutionChanged(int & circleResolution);
        void ringButtonPressed();
        void timeUpdate(float time);
        void totalTimeUpdate();
        void changeColor(float r, float g, float b, float a);

        unsigned int rv;
        unsigned int gv;
        unsigned int bv;
        unsigned int av;
        bool setFill;
        bool bHide;
        bool showTriangle;
        bool waitStepValid;
        bool animated;
    
        deque<ops> get_toDo();
        void set_toDo(ops input);
        void delete_toDo(int index);
    
        ofParameter<float> ellapsedSeconds;
        ofParameter<float> totalSeconds;

    
        ofParameter<float> radius;
        ofParameter<ofColor> color;
        ofParameter<ofVec2f> center;
        ofParameter<int> circleResolution;
        ofParameter<int> iteraciones;
        ofParameter<int> fractalN;
        ofParameter<float> escala;
        ofParameter<int> rotar;


        ofParameter<bool> filled;
        ofParameter<bool> setPoints;
        ofParameter<ofVec2f> setSelect;


        ofxButton twoCircles;
        ofxButton ringButton;
        ofParameter<string> screenSize;
        ofParameter<string> timeTaken;
        ofParameter<string> totalTimeTaken;


        ofxPanel gui;

        ofSoundPlayer ring;
};

