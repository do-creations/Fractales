#include "testApp.h"
#define ROTAR 0
#define TRASLADA 1
#define ESCALA 2
#define REFLEJA 3
#define FRADIUS 20;
//--------------------------------------------------------------


point2 v[]={{-1.0, -0.58}, {1.0, -0.58}, {0.0, 1.15}};

int numTiempos = 1;
int rspeed = 7;
float sspeed = 7;
int timer = 0;
int first;
int last;

int currentT[2] = { 0, 0};
int currentS[2] = { 1, 1};
int currentR = 0;
int globalCount = 0;

int currentFractal;
int currentIteration;
bool currentSetPoints;
bool deleteLast = false;
bool trianguloAhora = false;
bool waitStep = true;
bool animatedVal = true;
string fractalLabel = "sierpinski triangle";

coords pointerPoint = { 0, 0};
coords touchIDs[20];
typedef struct{
    coords pos;
    bool touching;
    ofColor color;
}fingers;

fingers fs[5];


typedef struct{
    bool taken;
    float time;
}opTime;
opTime fractalTime = { false, -1 };
deque<ops> toDo;
deque<ops> waitingToDo;
deque<opTime> doTimes;
vector<coords> esferas;

void rePlay();
float actionTimes();
void triangulo(float x0, float x1, float y0, float y1);

testApp :: testApp () {
    cout << "creating TestApp" << endl;
    //setup();
}

//--------------------------------------------------------------
testApp :: ~testApp() {
    cout << "destroying TestApp" << endl;
}
deque<ops> testApp :: get_toDo(){
    return toDo;
}
void testApp :: set_toDo(ops input){
    //toDo = input;
    printf("set to do\n");
    waitingToDo.push_back(input);
    rePlay();
}
void testApp :: delete_toDo(int index){
    printf("Tamanio antes %d\n", toDo.size());
    toDo.erase(toDo.begin() + index +1);
    printf("Tamanio despues %d\n", toDo.size());
    rePlay();
}

void testApp::setup(){
    
    
    //ofSetOrientation(OF_ORIENTATION_90_LEFT);
	ofSetVerticalSync(true);
    
	
	// we add this listener before setting up so the initial circle resolution is correct
	circleResolution.addListener(this, &testApp::circleResolutionChanged);
	ringButton.addListener(this,&testApp::ringButtonPressed);
    //ellapsedSeconds.addListener(this, &testApp::timeUpdate);
	// change default sizes for ofxGui so it's usable in small/high density screens
	//ofxGuiSetFont("Questrial-Regular.ttf",10,true,true);
	ofxGuiSetTextPadding(4);
	ofxGuiSetDefaultWidth(300);
	ofxGuiSetDefaultHeight(18);
	gui.setup("panel"); // most of the time you don't need a name but don't forget to call setup
    gui.setDefaultHeight(30);
	//gui.add(filled.set("relleno", true));
    filled.set("relleno", true);
    gui.add(setPoints.set("set", false));
    //gui.getGroup("set").setSize(150, 18);


	//gui.add(radius.set( "radius", 140, 10, 300 ));
    gui.add(iteraciones.set( "iteraciones", 3, 0, 7 ));
    
    gui.add(fractalN.set(fractalLabel, 1, 1, 3));
    //gui.add(filled.set("triangulo", true), filled.set("koch", false), filled.set("tapete", false));
    /*
    gui.add(escala.set("escala", 70, 1, 200));
    gui.add(rotar.set("rotacion",0,0,360));
	gui.add(center.set("posicion",ofVec2f(ofGetWidth()*.5,ofGetHeight()*.725),ofVec2f(0,0),ofVec2f(ofGetWidth(),ofGetHeight())));
     */
    escala.set("escala", 70, 1, 200);
    rotar.set("rotacion",0,0,360);
    center.set("posicion",ofVec2f(ofGetWidth()*.5,ofGetHeight()*.6),ofVec2f(0,0),ofVec2f(ofGetWidth(),ofGetHeight()));
    //rv = 220;
    //gv = 41;
    //bv = 37;
    color.set(ofColor(220,41,37));
    //color.set("color",ofColor(220,41,37),ofColor(0,0),ofColor(255,255));
    //color.set("color",ofColor(rv,gv,bv),ofColor(0,0),ofColor(255,255));
	//gui.add(color.set("color",ofColor(220,41,37),ofColor(0,0),ofColor(255,255)));
	//gui.add(circleResolution.set("circleRes", 5, 3, 90));
    
	//gui.add(screenSize.set("screenSize", ofToString(ofGetWidth()) + "x" + ofToString(ofGetHeight())));
    //gui.setup(timeTaken.set("Time for fractal: ", ofToString(ellapsedSeconds, 6)),timeTaken.set("Time for fractal: ", ofToString(ellapsedSeconds, 6)));
    //gui.setName("tiempos");
	gui.add(timeTaken.set("Time for fractal: ", ofToString(ellapsedSeconds, 6)));
    gui.add(totalTimeTaken.set("Ops Time: ", ofToString(totalSeconds, 6)));
    
    //, "Total Time: ", ofToString(totalSeconds, 6)
            //totalTimeTaken.set("Total time: ", ofToString(totalSeconds, 6)));

    
    //gui.getGroup("posicion").minimize();
    //gui.getGroup("color").minimize();
    //gui.getGroup("Time for fractal: ").minimize();

    
	bHide = true;
    
	ring.loadSound("ring.wav");
    
    currentFractal = fractalN;
    currentIteration = iteraciones;
    currentSetPoints = setPoints;
    //center = (ofVec2f)center;
    toDo.push_back((ops){TRASLADA, {0, 0}, true, true, 0});
    
    //screenSize = ofToString(w) + "x" + ofToString(h);
    //ops tempOp = {TRASLADA, {10, 10}};
    
    toDo.push_back((ops){TRASLADA, {10, 10}, false, false, -1});
    toDo.push_back((ops){TRASLADA, {-20, 0}, false, false, -1});
    toDo.push_back((ops){TRASLADA, {20, 50}, false, false, -1});
    toDo.push_back((ops){ROTAR, { -1, 65}, false, false, -1 });
    toDo.push_back((ops){ESCALA, { 2, 2}, false, false, -1 });
    //toDo.push_back((ops){ROTAR, { 1, 65}, false, false, -1 });
    toDo.push_back((ops){ESCALA, { 0.7, 0.7}, false, false, -1 });
    //toDo.push_back((ops){TRASLADA, {-20, -50}, false, false, -1});
    //toDo.push_back((ops){TRASLADA, {1, 20}, false, false, -1});

    //toDo.push_back((ops){TRASLADA, {-20, 0}, false, false, -1});
    fs[0] = (fingers){ {0,0},false,ofColor(220,41,37)};
    fs[1] = (fingers){ {0,0},false,ofColor(220,121,37)};
    fs[2] = (fingers){ {0,0},false,ofColor(63,107,143)};
    fs[3] = (fingers){ {0,0},false,ofColor(63,107,143)};
    fs[4] = (fingers){ {0,0},false,ofColor(63,107,143)};

    //waitStepValid = false;
    //animated = false;
    
    waitStep = waitStepValid;

    if(animated == false){
        animatedVal = animated;
        rePlay();
    }

}

//--------------------------------------------------------------
void testApp::circleResolutionChanged(int & circleResolution){
	ofSetCircleResolution(circleResolution);
}

//--------------------------------------------------------------
void testApp::ringButtonPressed(){
	ring.play();
}
void testApp::timeUpdate(float time){
    ellapsedSeconds = time;
    timeTaken.set("Time taken: ", ofToString(ellapsedSeconds, 6));
}
void testApp::totalTimeUpdate(){
    //ellapsedSeconds = time;
    totalTimeTaken.set("Ops Time: ", ofToString(actionTimes(), 6));//, "Total Time: ", ofToString(actionTimes()+fractalTime.time, 6));
}
void testApp::changeColor(float rc, float gc, float bc, float ac){
    rv = rc; gv = gc; bv = bc; av = ac;
}

//--------------------------------------------------------------
void testApp::update(){
    //ofSleepMillis(300);
    waitStep = waitStepValid;
    animatedVal = animated;
    filled.set(setFill);
    color.set(ofColor(rv,gv,bv,av));
    //color.set("color",ofColor(rv,gv,bv),ofColor(0,0),ofColor(255,255));
    if(fractalN != currentFractal || iteraciones != currentIteration){
        currentFractal = fractalN;
        currentIteration = iteraciones;
        fractalTime.taken = false;
        if(fractalN == 1)
            fractalN.set("sierpinski triangle", 1, 1, 3);
        else if(fractalN == 2)
            fractalN.set("koch snowflake", 2, 1, 3);
        else if(fractalN == 3)
            fractalN.set("sierpinski carpet", 3, 1, 3);
        
        rePlay();
    }
    if(currentSetPoints == true && setPoints == false){
        rePlay();
        currentSetPoints = false;
    }
    else if(currentSetPoints == false && setPoints == true){
        currentSetPoints = true;
    }
}

//--------------------------------------------------------------
float actionTimes(){
    float total = 0;
    for(int i = 0; i < toDo.size(); i++){
        total += toDo.at(i).time;
    }
    return total;
}
char tipo(int i){
    char temp;
    switch (i) {
        case TRASLADA:
            temp = 'T';
            break;
        case ROTAR:
            temp = 'R';
            break;
        case ESCALA:
            temp = 'E';
            break;
        default:
            temp = 'Z';
            break;
    }
    return temp;
}
void printData(){
    float total = 0;
    printf("Lista de tiempos operaciones\n");
    for(int i = 0; i < toDo.size(); i++){
        printf("#%d\t %c tiempo: %f\n", i+1, tipo(toDo.at(i).operation), toDo.at(i).time);
        total += toDo.at(i).time;
    }
    printf("Total %f \n", total);
}
ops doInverse(int pos){
    ops temporal;

    if(toDo.size() > 0) {
        temporal.played = false;
        temporal.taken = true;
        temporal.time = 0;
        //toDo.at(pos).played = false;
        timer = 0;
        if(toDo.at(pos).operation == TRASLADA){
            temporal.operation = TRASLADA;
            temporal.pars[0] = toDo.at(pos).pars[0] * -1;
            temporal.pars[1] = toDo.at(pos).pars[1] * -1;

        }
        else if(toDo.at(pos).operation == ROTAR){
            temporal.operation = ROTAR;
            temporal.pars[0] = toDo.at(pos).pars[0] * -1;
            temporal.pars[1] = toDo.at(pos).pars[1];
        }
        else if(toDo.at(pos).operation == ESCALA){
            temporal.operation = ESCALA;
            temporal.pars[0] = 1/toDo.at(pos).pars[0];
            temporal.pars[1] = 1/toDo.at(pos).pars[1];

        }
    }
    return temporal;
}
void doFunction(int pos){
    //printf("Global Count %d\n",globalCount);
    if(toDo.size() > 0){
        if(toDo.at(pos).operation == TRASLADA){
            if(toDo.at(pos).played == false){//cambiar a false
                vector<coords>positions;
                positions = BresenhamLine(0, 0, toDo.at(pos).pars[0], toDo.at(pos).pars[1]);
                //printf("position %d x %d y %d\n", positions.size(), positions.at(timer%positions.size()).x, positions.at(timer%positions.size()).y);
                if(toDo.at(pos).pars[0] < 0 && toDo.at(pos).pars[1] < 0){
                    ofTranslate(positions.at((positions.size() -1) - timer).x, positions.at((positions.size() -1) - timer).y);
                }
                else if(toDo.at(pos).pars[0] < 0){
                    ofTranslate(positions.at((positions.size() -1) - timer).x, positions.at(timer%positions.size()).y);
                }
                else if(toDo.at(pos).pars[1] < 0 ){
                    ofTranslate(positions.at(timer%positions.size()).x, positions.at((positions.size() -1) - timer).y);
                }
                else{
                    ofTranslate(positions.at(timer%positions.size()).x, positions.at(timer%positions.size()).y);
                }
                if(timer+1 == positions.size()){
                    toDo.at(pos).played = true;
                    timer = 0;
                }
                else{
                    if(waitStep)
                        ofSleepMillis(50);
                }
            }
            else{
                //printf("tras played");
                NSDate *start=[NSDate date];
                ofTranslate(toDo.at(pos).pars[0], toDo.at(pos).pars[1]);
                NSDate *end=[NSDate date];
                if(toDo.at(pos).taken == false){
                    toDo.at(pos).time = (float)[end timeIntervalSinceDate:start];
                    toDo.at(pos).taken = true;
                }

            }
            
        }
        else if(toDo.at(pos).operation == ROTAR){
            //timer = 0;
            //printf("play rotar");
            if(toDo.at(pos).played == false){
                float increment = toDo.at(pos).pars[1]/(float)rspeed;
                //printf("\n%d \t Incremento %f  current %f \n", timer,increment, toDo.at(pos).pars[0]*increment*timer);
                ofRotate(toDo.at(pos).pars[0]*increment*timer, 0, 0, 1);
                
                if(abs(toDo.at(pos).pars[0]*increment*(timer)) == toDo.at(pos).pars[1]){
                    //printf("rotate played \ n");
                    toDo.at(pos).played = true;
                    timer = 0;

                }
                else{
                    if(waitStep)
                        ofSleepMillis(50);
                }
            }
            else{
                NSDate *start=[NSDate date];
                ofRotate(toDo.at(pos).pars[0]*toDo.at(pos).pars[1], 0, 0, 1);
                NSDate *end=[NSDate date];
                if(toDo.at(pos).taken == false){
                    toDo.at(pos).time = (float)[end timeIntervalSinceDate:start];
                    toDo.at(pos).taken = true;
                }

            }
            //toDo.push_back(toDo.front());
            //toDo.pop_front();
        }
        else if(toDo.at(pos).operation == ESCALA){
            //timer = 0;
            //ofSleepMillis(500);
            if(toDo.at(pos).played == false){
                float incrementx = (toDo.at(pos).pars[0] - 1)/sspeed;
                float incrementy = (toDo.at(pos).pars[1] - 1)/sspeed;
                ofScale(1+incrementx*timer, 1+incrementy*timer);
                if(1 + incrementx*timer == toDo.at(pos).pars[0]){
                    toDo.at(pos).played = true;
                    timer = 0;
                }
                else{
                    if(waitStep)
                        ofSleepMillis(50);
                }
            }
            else{
                NSDate *start=[NSDate date];
                float changex = (toDo.at(pos).pars[0] - 1);
                float changey = (toDo.at(pos).pars[0] - 1);
                ofScale( 1 + changex, 1 + changey);
                NSDate *end=[NSDate date];
                if(toDo.at(pos).taken == false){
                    toDo.at(pos).time = (float)[end timeIntervalSinceDate:start];
                    toDo.at(pos).taken = true;
                }
            }
            //toDo.push_back(toDo.front());
            //toDo.pop_front();
        }
    }
    
    
}
void doFunction(testApp *current){

    for(int i = 0; i <= globalCount%toDo.size(); i++){
        doFunction(i);
    }
    if(globalCount < toDo.size()-1 && toDo.at(globalCount).played == true){
        //printf("global count ++");
        globalCount++;
    }
    else if(globalCount == toDo.size()-1 && toDo.at(globalCount).played == true){
        current->totalTimeUpdate();// totalTimeUpdate();
        //testApp.totalTimeTaken.set("Total time: ", ofToString(, 6));
        //printf("waiting replay");
        //ofSleepMillis(300);
        //rePlay();
    }

    timer++;
}
void rePlay(){
    printf("el valor de animated %b", animatedVal);
    while(!waitingToDo.empty()){
        toDo.push_back(waitingToDo.front());
        waitingToDo.pop_front();
    }
    for(int i = 0; i < toDo.size(); i++ )
    {
        if(animatedVal == true){
            toDo.at(i).played = false;
        }
        else{
            toDo.at(i).played = true;
        }
        toDo.at(i).taken = false;
        timer = 0;
        globalCount = 0;
    }
}

bool settingsChange(){
    
}
void testApp::draw(){
    //ofBackgroundGradient(ofColor::white, ofColor::gray);
    
    for(int i = 0; i < 5; i ++){
        ofPushMatrix();
        {
            if(fs[i].touching == true){
                ofSetColor(fs[i].color, 50);
                ofCircle(fs[i].pos.x, fs[i].pos.y,40);
            }
            else{
                //printf("i : %d no esta en tocando\n", i );
            }
        }
        ofPopMatrix();
    }
    if(fs[0].touching == true && fs[1].touching == true && trianguloAhora == true)
        triangulo(fs[0].pos.x, fs[1].pos.x, fs[0].pos.y, fs[1].pos.y);
    
	if( filled ){
		ofFill();
	}else{
		ofNoFill();
	}
    
	ofSetColor(color);
    
    //divide_triangle(v[0], v[1], v[2], iteraciones, (ofVec2f)center);
    ofPushMatrix();
    
    
    ofTranslate((ofVec2f)center);
    
    ofPushMatrix();{
        //ofTranslate(pointerPoint.x, pointerPoint.y);
        for(int i = 0; i < esferas.size(); i++){
            ofCircle(esferas.at(i).x - center->x, esferas.at(i).y - center->y, 5);
        }
        
    }ofPopMatrix();
    
    ofCircle(0, 0, 5);
    
    ofTranslate(currentT[0], currentT[1]);
    
    doFunction(this);

    ofScale(escala, escala);
    //ofRotate(rotar, 0.0, 0.0, 1.0);
    NSDate *start=[NSDate date];
    //NSLog(@"Start time %@", start);
    float ltemp = 2.0;

    //
    switch (fractalN) {
        case 1:
            divide_triangle(v[0], v[1], v[2], iteraciones, (ofVec2f)center, rotar);
            break;
        case 2:
            drawsnowflake( iteraciones );
            break;
        case 3:
            tapete(-ltemp/2.0, -ltemp/2.0, ltemp, iteraciones, color);
            break;
        default:
            break;
    }
    
    NSDate *end=[NSDate date];
    if(fractalTime.taken == false){
        fractalTime.time = (float)[end timeIntervalSinceDate:start];
        fractalTime.taken = true;
    }    // NSLog(@"End time %@", end);
    timeUpdate(fractalTime.time);//(float)[end timeIntervalSinceDate:start]);
    
    //ellapsedSeconds= [end timeIntervalSinceDate:start];
    
    //gui.draw();
    //NSLog(@"time : %f \n", ellapsedSeconds);
    ofPopMatrix();
    /*
     if(twoCircles){
     ofCircle(center->x-radius*.5, center->y, radius );
     ofCircle(center->x+radius*.5, center->y, radius );
     }else{
     ofCircle((ofVec2f)center, radius );
     }
     */
	if( bHide ){
		gui.draw();
	}
    if(deleteLast == true && toDo.at(toDo.size()-1).played == true){
        toDo.pop_back();
        toDo.pop_back();
        globalCount -= 2;
        deleteLast = false;
    }
}

//--------------------------------------------------------------
void testApp::exit(){
	ringButton.removeListener(this,&testApp::ringButtonPressed);
}


//--------------------------------------------------------------
void triangulo(float x0, float x1, float y0, float y1){
    ofPushMatrix();
    {
        ofSetColor(ofColor(70,125,183,150));
        ofTriangle(x0, y0, x1, y0, x1, y1);
    }
    ofPopMatrix();
}

void testApp::touchDown(ofTouchEventArgs & touch){

    ofLog(OF_LOG_VERBOSE, "touch %d down at (%d,%d)", touch.id, touch.x, touch.y);
    //printf(" %f %f %f\n", touch[0], touch[1], touch[3]);
    touchIDs[touch.id].x = touch.x;
    touchIDs[touch.id].y = touch.y;
    if(touch.id < 5){
        fs[touch.id].pos.x = touch.x; fs[touch.id].pos.y = touch.y; fs[touch.id].touching = true;
    }
    if(touch.id == 1){
        float diffx = touchIDs[0].x - touchIDs[1].x;
        float diffy = touchIDs[0].y - touchIDs[1].y;
        float separacion =(int)(sqrt((diffx*diffx) + (diffy*diffy)));
        if(separacion > 85)
            if(showTriangle == true) //variable de la configuracion
                trianguloAhora = true;
        else
            trianguloAhora = false;

    }
    //if(globalCount == toDo.size()-1 && toDo.at(globalCount).played == true){

    //else{
    //    toDo.push_back((ops){TRASLADA, {touch.x - center->x, touch.y - center->y}, false, false, -1});
    //}
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
    ofLog(OF_LOG_VERBOSE, "touch %d moved at (%d,%d)", touch.id, touch.x, touch.y);
	//balls[touch.id].moveTo(touch.x, touch.y);
	//balls[touch.id].bDragged = true;
    touchIDs[touch.id].x = touch.x;
    touchIDs[touch.id].y = touch.y;
    if(touch.id < 5){
        fs[touch.id].pos.x = touch.x; fs[touch.id].pos.y = touch.y; fs[touch.id].touching = true;
    }
    if(touch.id == 1){
        float diffx = touchIDs[0].x - touchIDs[1].x;
        float diffy = touchIDs[0].y - touchIDs[1].y;
        float separacion =(int)(sqrt((diffx*diffx) + (diffy*diffy)));
        if(separacion > 90){
            escala.set(0.3* separacion);
            if(showTriangle == true)
                trianguloAhora = true;
        }
        else{
            trianguloAhora = false;
            float xlocalpos = (center->x + (touchIDs[1].x + (diffx/2) - center->x));
            float ylocalpos = (center->y + (touchIDs[1].y + (diffy/2) - center->y));
            center.set(ofVec2f(xlocalpos, ylocalpos));
            //center.x = center.x + (center.x - touchIDs[1].x);
            printf("Separacion es %f x: %f y: %f \n", separacion, xlocalpos, ylocalpos);
            

        }
        //printf("la escala es %f \n", escala.get());
    }
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    //ofLog(OF_LOG_VERBOSE, "touch %d up at (%d,%d)", touch.id, touch.x, touch.y);
	//balls[touch.id].bDragged = false;
    if(touch.id < 5){
       fs[touch.id].touching = false;
    }
    trianguloAhora = false;
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
    ofLog(OF_LOG_VERBOSE, "touch %d double tap at (%d,%d)", touch.id, touch.x, touch.y);
    printf( "touch %d double tap at (%f,%f)", touch.id, touch.x, touch.y);
    //ofSleepMillis(5000);
    if(setPoints == true){
        esferas.push_back((coords){touch.x, touch.y});
        waitingToDo.push_back((ops){TRASLADA, {touch.x - center->x, touch.y - center->y}, false, false, -1});
    }
    if(touch.id == 1 && toDo.size() > 1){
        toDo.push_back(doInverse(toDo.size()-1));
        deleteLast = true;
    }
    if(touch.id == 2){
        printData();
    }
}
/*
void testApp::touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data) {
    printf("touchDown: %f, %f %i\n", x, y, touchId);
    //things[touchId].moveTo(x, y);
}

void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data) {
    printf("touchMoved: %f, %f %i\n", x, y, touchId);
    //things[touchId].moveTo(x, y);
}

void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data) {
    printf("touchUp: %f, %f %i\n", x, y, touchId);
}
 */
//--------------------------------------------------------------


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
    
}

