#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
// modified from lukasz karluk's iosNativeExample

int main(){
    ofAppiOSWindow *window = new ofAppiOSWindow();
    ofSetupOpenGL(ofPtr<ofAppBaseWindow>(window), 1024,768, OF_FULLSCREEN);
    window->startAppWithDelegate("AppDelegate");
}
