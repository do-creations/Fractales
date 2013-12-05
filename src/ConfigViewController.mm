//
//  ConfigViewController.cpp
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/22/13.
//
//

#include "ConfigViewController.h"
#include "TabBarViewController.h"
#include "AppDelegate.h"
@interface ConfigViewController () {}

@end


@implementation ConfigViewController

@synthesize rslide, bslide, gslide, aslide, first, fill, triangleSwitch, animacion, exampleOFApp;

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)slideColor{
    float rv = rslide.value;
    float gv = gslide.value;
    float bv = bslide.value;
    float av = aslide.value;
    UIColor *nuevo = [[UIColor alloc] initWithRed:rv/255.0f green:gv/255.0f  blue:bv/255.0f  alpha:av/255.0f];
    rslide.tintColor = nuevo;
    gslide.tintColor = nuevo;
    bslide.tintColor = nuevo;
    aslide.tintColor = nuevo;
    fill.tintColor = nuevo;
    fill.onTintColor = nuevo;
    triangleSwitch.tintColor = nuevo;
    triangleSwitch.onTintColor = nuevo;
    animacion.tintColor = nuevo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    first = true;
    [self slideColor];

    
}
-(void)viewDidAppear:(BOOL)animated{

    if(first == true){
        exampleOFApp = new testApp();
        
        //TabBarViewController *tempTab = [self parentViewController];
        //tempTab.mainInstance = exampleOFApp;
        if([[ self parentViewController] isKindOfClass:[AppDelegate class]])
            printf("Appdelegate =========\n");
        if([[ self parentViewController] isKindOfClass:[TabBarViewController class]])
            printf("TabBar =============\n");
        

        
        CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
        CGRect frame = mainScreenFrame;
        if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            frame.size.width = mainScreenFrame.size.height;
            frame.size.height = mainScreenFrame.size.width;
        }
        
        
        FractalAppViewController *exampleOFAppViewController = [[FractalAppViewController alloc] initWithFrame:frame app:exampleOFApp];
        NSMutableArray *test = [[NSMutableArray alloc] initWithArray:[self.tabBarController viewControllers]] ;
        [test addObject:exampleOFAppViewController];
        [self.tabBarController setViewControllers:test];
        UITabBarItem *tempitem = [[self.tabBarController viewControllers] objectAtIndex:[self.tabBarController viewControllers].count -1];
        [tempitem setTitle:@"fractales"];
        first = false;
    }
    [self loadFullConf];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadFullConf{
    [self colorChange:nil];
    [self fillChange];
    [self triangleChange];
    [self animChange:animacion];
}
- (IBAction)triangleChange{
    testApp *curr = exampleOFApp;
    if(triangleSwitch.on)
        curr->showTriangle = true;
    else
        curr->showTriangle = false;
}
- (IBAction)fillChange{
    testApp *curr = exampleOFApp;
    if(fill.on)
        curr->setFill = true;
    else
        curr->setFill = false;
}
- (IBAction)animChange:(id)sender{
    UISegmentedControl *tempSegment = sender;
    if(tempSegment.selectedSegmentIndex == 0){
        exampleOFApp->waitStepValid = true;
        exampleOFApp->animated = true;
    }
    else if(tempSegment.selectedSegmentIndex == 1){
        exampleOFApp->waitStepValid = false;
        exampleOFApp->animated = true;
    }
    else if(tempSegment.selectedSegmentIndex == 2){
        exampleOFApp->waitStepValid = false;
        exampleOFApp->animated = false;
    }
}
- (IBAction)colorChange:(id)sender{
    testApp *curr = exampleOFApp;
    float rv = rslide.value;
    float gv = gslide.value;
    float bv = bslide.value;
    float av = aslide.value;
    
    curr->rv = rv;
    curr->gv = gv;
    curr->bv = bv;
    curr->av = av;
     
    //exampleOFApp->changeColor(rv, gv, bv);

    [self slideColor];
}

@end
