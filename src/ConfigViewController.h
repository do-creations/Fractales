//
//  ConfigViewController.h
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/22/13.
//
//

#import <UIKit/UIKit.h>
#import "testApp.h"
#import "FractalAppViewController.h"

@interface ConfigViewController : UIViewController

@property(nonatomic, retain)IBOutlet UISlider *rslide;
@property(nonatomic, retain)IBOutlet UISlider *gslide;
@property(nonatomic, retain)IBOutlet UISlider *bslide;
@property(nonatomic, retain)IBOutlet UISlider *aslide;
@property(nonatomic, retain)IBOutlet UISwitch *fill;
@property(nonatomic, retain)IBOutlet UISwitch *triangleSwitch;
@property(nonatomic, retain)IBOutlet UISegmentedControl *animacion;

@property(nonatomic, readwrite) bool first;
@property(atomic, readwrite)testApp *exampleOFApp;

- (IBAction)colorChange:(id)sender;
- (IBAction)triangleChange;
- (IBAction)animChange:(id)sender;
// IBACTION FILL CHANGE????
// IB
//- (IBAction)launchAppPressed:(id)sender;

@end
