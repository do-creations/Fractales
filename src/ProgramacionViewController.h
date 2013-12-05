//
//  ProgramacionViewController.h
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/24/13.
//
//

#import <UIKit/UIKit.h>
#import "testApp.h"
@interface ProgramacionViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, readwrite) testApp *mainInstance;

@end
