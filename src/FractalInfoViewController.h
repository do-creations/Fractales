//
//  FractalInfoViewController.h
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/24/13.
//
//

#import <UIKit/UIKit.h>

@interface FractalInfoViewController : UIViewController
@property(nonatomic, retain)IBOutlet UITextView *h;
@property(nonatomic, retain)IBOutlet UITextView *mm;

- (IBAction)showH:(id)sender;
- (IBAction)showM:(id)sender;

@end
