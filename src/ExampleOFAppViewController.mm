#import "ExampleOFAppViewController.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"


@implementation ExampleOFAppViewController
//ofxiPhoneApp
- (id) initWithFrame:(CGRect)frame app:(ofxiOSApp *)appThis {

    ofxiOSGetOFWindow()->setOrientation( OF_ORIENTATION_DEFAULT );
    //ofxiPhoneGetOFWindow()->setOrientation( OF_ORIENTATION_DEFAULT );   //-- default portait orientation.
    return self = [super initWithFrame:frame andApp:appThis];
    //return self = [super initWithFrame:frame app:app];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

@end
