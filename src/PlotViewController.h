//
//  PlotViewController.h
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/23/13.
//
//
#import <UIKit/UIKit.h>
#import "CorePlotHeaders/CorePlot-CocoaTouch.h"

@interface PlotViewController: UIViewController //<CPTPlotDataSource>
<CPTBarPlotDataSource, CPTBarPlotDelegate>
//@property (nonatomic, retain) UIStepper
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (nonatomic, retain) IBOutlet UILabel *itNum;

- (void) generateBarPlot;
- (IBAction)valueChanged:(UIStepper *)sender;

@end
