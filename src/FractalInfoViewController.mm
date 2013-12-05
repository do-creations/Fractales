//
//  FractalInfoViewController.m
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/24/13.
//
//

#import "FractalInfoViewController.h"
#import "PlotSingleViewController.h"

@interface FractalInfoViewController ()

@end

@implementation FractalInfoViewController
@synthesize h, mm;

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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PlotSingleViewController *next = segue.destinationViewController;
    next.fractValue = [segue.identifier intValue];
}
- (IBAction)showH:(id)sender{
    h.hidden = false;
    mm.hidden = true;
}
- (IBAction)showM:(id)sender{
    h.hidden = true;
    mm.hidden = false;
}

@end
