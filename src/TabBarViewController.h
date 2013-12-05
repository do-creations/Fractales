//
//  TabBarViewController.h
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/22/13.
//
//

#import <UIKit/UIKit.h>
#import "testApp.h"

@interface TabBarViewController : UITabBarController

@property(nonatomic,readwrite) testApp *mainInstance;

@end
