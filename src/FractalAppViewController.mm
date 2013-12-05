//
//  FractalAppViewController.cpp
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/22/13.
//
//

#include "FractalAppViewController.h"
#import "SquareAppViewController.h"
#import "ofxiOSExtras.h"
#import "testApp.h"
@implementation FractalAppViewController

- (id) initWithFrame:(CGRect)frame app:(ofxiOSApp *)app {
    
    ofxiOSGetOFWindow()->setOrientation( OF_ORIENTATION_DEFAULT );   //-- default portait orientation.
    
    return self = [super initWithFrame:frame app:app];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    testApp *exampleOFApp = new testApp();
    
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    CGRect frame = mainScreenFrame;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        frame.size.width = mainScreenFrame.size.height;
        frame.size.height = mainScreenFrame.size.width;
    }
    
    
    FractalAppViewController *exampleOFAppViewController = [[FractalAppViewController alloc] initWithFrame:frame app:exampleOFApp];
    self = exampleOFAppViewController;//[super initWithFrame:frame app:exampleOFApp];
    printf("initialized\n");
    if (self) {
        // Custom initialization
    }
    return self;
}*/
/*
- (id)initWithCoder:(NSCoder *)decoder{
    printf("Init with decoder\n");
    testApp *exampleOFApp = new testApp();
    
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    CGRect frame = mainScreenFrame;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        frame.size.width = mainScreenFrame.size.height;
        frame.size.height = mainScreenFrame.size.width;
    }
    
    
    FractalAppViewController *exampleOFAppViewController = [[FractalAppViewController alloc] initWithFrame:frame app:exampleOFApp];
    self = exampleOFAppViewController;
    return self;
}*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    printf("did load \n");

    
    //[self.tabBarController presentModalViewController:exampleOFAppViewController animated:YES];
    //[self presentViewController:exampleOFAppViewController animated:YES completion:nil];
    //self.view = exampleOFAppViewController.view;
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

/*
@implementation FractalAppViewController

- (id) initWithFrame:(CGRect)frame app:(ofxiOSApp *)app {
    
    ofxiOSGetOFWindow()->setOrientation( OF_ORIENTATION_DEFAULT );   //-- default portait orientation.
    
    return self = [super initWithFrame:frame app:app];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

@end
*/