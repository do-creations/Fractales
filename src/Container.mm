//
//  Container.cpp
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/22/13.
//
//

#include "Container.h"
#import "FractalAppViewController.h"
#import "testApp.h"

@interface Container ()

@end

@implementation Container

@synthesize vista;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    testApp *exampleOFApp = new testApp();
    
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    CGRect frame = mainScreenFrame;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        frame.size.width = mainScreenFrame.size.height;
        frame.size.height = mainScreenFrame.size.width;
    }
    
    
    FractalAppViewController *exampleOFAppViewController = [[FractalAppViewController alloc] initWithFrame:frame app:exampleOFApp];
    
    //[vista ]
    //[self presentViewController:exampleOFAppViewController animated: YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end