#import "LaunchAppViewController.h"
#import "ExampleOFAppViewController.h"
#import "ExampleOFApp.h"
#import "SquareApp.h"
#import "SquareAppViewController.h"
#import "testApp.h"
#import "FractalAppViewController.h"

@interface LaunchAppViewController () {}

@end

@implementation LaunchAppViewController

#pragma mark - IB

- (IBAction)launchAppPressed:(id)sender {
    
    // Note we are not creating the ExampleOFAppViewController via storyboards
    // as is requires a custom initilaiser
    
    // create the app
    //ExampleOFApp *exampleOFApp = new ExampleOFApp();
    testApp *exampleOFApp = new testApp();

    //exampleOFApp->size = 2;
    // For the curious, exampleOFApp will be deleted laters

    // create the frame for the app. In this example we create it to
    // be the the same size as the screen and respect this views
    // orientation
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    CGRect frame = mainScreenFrame;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        frame.size.width = mainScreenFrame.size.height;
        frame.size.height = mainScreenFrame.size.width;
    }
    
    // create the app
    //ExampleOFAppViewController *exampleOFAppViewController = [[ExampleOFAppViewController alloc] initWithFrame:frame andApp:exampleOFApp];
    FractalAppViewController *exampleOFAppViewController = [[FractalAppViewController alloc] initWithFrame:frame app:exampleOFApp];
    // add it
    
    //[self.tabBarController set]
    //[self.tabBarController addChildViewController:exampleOFAppViewController];
    //[self presentViewController:exampleOFAppViewController animated: YES completion:nil];
    [self.navigationController pushViewController:exampleOFAppViewController animated:YES];
    //[self.navigationController pushViewController:exampleOFAppViewController animated:YES];
    //UIViewController *temp = [[UIViewController alloc] init];
    
    //[temp setView:exampleOFAppViewController];
    
    //[self.navigationController pushViewController:temp animated:YES];
    
}

#pragma mark - Life Cycle

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


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
