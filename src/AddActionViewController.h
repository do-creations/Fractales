//
//  AddActionViewController.h
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/24/13.
//
//

#import <UIKit/UIKit.h>
#import "testApp.h"




@interface AddActionViewController : UIViewController

@property (nonatomic, retain) IBOutlet UISlider *xslider;
@property (nonatomic, retain) IBOutlet UISlider *yslider;
@property (nonatomic, retain) IBOutlet UILabel *xlabel;
@property (nonatomic, retain) IBOutlet UILabel *ylabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *operacion;
@property (nonatomic, retain) IBOutlet UILabel *xval;
@property (nonatomic, retain) IBOutlet UILabel *yval;
@property (nonatomic, retain) IBOutlet UILabel *dval;
@property (nonatomic, retain) IBOutlet UILabel *dextraval;
@property (nonatomic, readwrite) ops actual;


- (IBAction)seleccion:(id)sender;

@end
