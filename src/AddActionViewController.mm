//
//  AddActionViewController.m
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/24/13.
//
//

#import "AddActionViewController.h"

@interface AddActionViewController ()

@end


@implementation AddActionViewController

@synthesize xlabel, xslider, ylabel, yslider;
@synthesize xval, yval, dval, dextraval;
@synthesize actual;

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
    actual = (ops){ 1, { xslider.value, yslider.value }, false, false, -1.0};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cambio:(id)sender
{
    actual.pars[0] = xslider.value;
    actual.pars[1] = yslider.value;
    if(actual.pars[1] < 0){
        actual.pars[0] = -1;
        actual.pars[1] = abs(actual.pars[1]);
    }
    xval.text = [NSString stringWithFormat:@"%.2f", xslider.value];
    yval.text = [NSString stringWithFormat:@"%.2f", yslider.value];
    dval.text = [NSString stringWithFormat:@"%.2f", yslider.value];

}
- (IBAction)seleccion:(id)sender{
    UISegmentedControl *control = sender;
    if(control.selectedSegmentIndex == 0){
        actual.operation = 1; //traslada
        yslider.minimumValue = 0;
        yslider.maximumValue = 100.0;
        xslider.minimumValue = 0;
        xslider.maximumValue = 100.0;
        xslider.hidden = false;
        xlabel.hidden = false;
        xval.hidden = false;
        yval.hidden = false;
        dval.hidden = true;
        dextraval.hidden = true;
        ylabel.text = @"Y: ";
        
        

    }
    else if(control.selectedSegmentIndex == 1){
        actual.operation = 0;
        actual.pars[0] = 1;
        xslider.hidden = true;
        xlabel.hidden = true;
        xslider.value = 1.0;
        yslider.minimumValue = -360.0;
        yslider.maximumValue = 360.0;
        xval.hidden = true;
        yval.hidden = true;
        dval.hidden = false;
        dextraval.hidden = false;
        ylabel.text = @"Grados: ";
    }
    else{
        actual.operation = 2;
        yslider.minimumValue = 00.5;
        yslider.maximumValue = 20.0;
        xslider.minimumValue = 00.5;
        xslider.maximumValue = 20.0;
        xslider.hidden = false;
        xlabel.hidden = false;
        ylabel.text = @"Y: ";
        xval.hidden = false;
        yval.hidden = false;
        dval.hidden = true;
        dextraval.hidden = true;

    }
}
@end
