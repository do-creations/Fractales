//
//  PlotSingleViewController.h
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/23/13.
//
//

#import <UIKit/UIKit.h>
#import "CorePlotHeaders/CorePlot-CocoaTouch.h"

@interface PlotSingleViewController: UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate>

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (nonatomic, retain) IBOutlet UILabel *itNum;
@property (nonatomic, readwrite) int fractValue;

- (void) generateBarPlot;
@end
