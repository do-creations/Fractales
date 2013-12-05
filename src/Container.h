//
//  Container.h
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/22/13.
//
//
#import <UIKit/UIKit.h>

@interface Container : UIViewController

// IB
@property(nonatomic, retain)IBOutlet UIView *vista;
- (IBAction)launchAppPressed:(id)sender;

@end
