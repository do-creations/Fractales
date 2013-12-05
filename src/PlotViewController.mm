//
//  PlotViewController.cpp
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/23/13.
//
//

#include "PlotViewController.h"
#include "algoritmos.h"
#include "koch.h"
#include "tapete.h"

@interface PlotViewController () {}

@end

int iteraciones = 3;

@implementation PlotViewController

#define BAR_POSITION @"POSITION"
#define BAR_HEIGHT @"HEIGHT"
#define COLOR @"COLOR"
#define CATEGORY @"CATEGORY"

#define AXIS_START 0
#define AXIS_END 50

@synthesize data;
@synthesize graph;
@synthesize hostingView;
@synthesize itNum;

#pragma mark - Life Cycle
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
    }
    return self;
}

- (void)grafica{
    self.data = [NSMutableArray array];
    
    
    //agreagar a stepper
    
    point2 v[]={{-1.0, -0.58}, {1.0, -0.58}, {0.0, 1.15}};
    
    float bar_heights[3];
    
    //
    float ltemp = 2.0;
    
    NSString *categories[] = {@"Triangulo", @"Copo", @"Tapete"};

    
    NSDate *start=[NSDate date];
    divide_triangle(v[0], v[1], v[2], iteraciones, ofVec2f(0,0), 0);
    NSDate *end=[NSDate date];
    bar_heights[0] = (float)[end timeIntervalSinceDate:start];
    
    start=[NSDate date];
    drawsnowflake( iteraciones );
    end=[NSDate date];
    bar_heights[1] = (float)[end timeIntervalSinceDate:start];
    
    start=[NSDate date];
    tapete(-ltemp/2.0, -ltemp/2.0, ltemp, iteraciones, ofColor(255,255,255));
    end=[NSDate date];
    bar_heights[2] = (float)[end timeIntervalSinceDate:start];
    
    for(int i = 0; i < 3; i++){
        categories[i] = [categories[i] stringByAppendingFormat:@" %.6f ms", bar_heights[i]];
        bar_heights[i] *= 1000.0;
    }
    
    
    //float bar_heights[] = {20,30,10};
    UIColor *colors[] = {
        [UIColor redColor],
        [UIColor blueColor],
        [UIColor orangeColor]};
    //[UIColor purpleColor]};
    
    for (int i = 0; i < 3 ; i++){
        double position = i; //Bars will be 10 pts away from each other
        double height = bar_heights[i];
        
        NSDictionary *bar = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithDouble:position],BAR_POSITION,
                             [NSNumber numberWithDouble:height],BAR_HEIGHT,
                             colors[i],COLOR,
                             categories[i],CATEGORY,
                             nil];
        [self.data addObject:bar];
    }
    [self generateBarPlot];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    // We need a hostview, you can create one in IB (and create an outlet) or just do this:
    CPTGraphHostingView* hostView = [[CPTGraphHostingView alloc] initWithFrame:self.view.frame];
    [self.view addSubview: hostView];
    
    // Create a CPTGraph object and add to hostView
    CPTGraph* graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
    hostView.hostedGraph = graph;
    
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 16 )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( -4 ) length:CPTDecimalFromFloat( 8 )]];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    plot.dataSource = self;
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
*/
    [self grafica];

}
- (IBAction)valueChanged:(UIStepper *)sender {
    iteraciones = [sender value];
    itNum.text = [NSString stringWithFormat:@"%i",iteraciones];
     [self grafica];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords {
    return 9; // Our sample graph contains 9 'points'
}

// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    // We need to provide an X or Y (this method will be called for each) value for every index
    int x = index - 4;
    
    // This method is actually called twice per point in the plot, one for the X and one for the Y value
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        // Return x value, which will, depending on index, be between -4 to 4
        return [NSNumber numberWithInt: x];
    } else {
        // Return y value, for this example we'll be plotting y = x * x
        return [NSNumber numberWithInt: x * x];
    }
}
*/
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if ( [plot.identifier isEqual:@"fractales"] )
        return [self.data count];
    
    return 0;
}
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if ( [plot.identifier isEqual:@"fractales"] )
    {
        NSDictionary *bar = [self.data objectAtIndex:index];
        
        if(fieldEnum == CPTBarPlotFieldBarLocation)
            return [bar valueForKey:BAR_POSITION];
        else if(fieldEnum ==CPTBarPlotFieldBarTip)
            return [bar valueForKey:BAR_HEIGHT];
    }
    return [NSNumber numberWithFloat:0];
}
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    if ( [plot.identifier isEqual: @"fractales"] )
    {
        CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
        textStyle.fontName = @"Helvetica";
        textStyle.fontSize = 14;
        textStyle.color = [CPTColor blackColor];//[CPTColor whiteColor];
        
        NSDictionary *bar = [self.data objectAtIndex:index];
        CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%@", [bar valueForKey:@"CATEGORY"]]];
        label.textStyle =textStyle;
        
        return label;
    }
    
    CPTTextLayer *defaultLabel = [[CPTTextLayer alloc] initWithText:[NSString stringWithString:@"Label"]];
    return defaultLabel;
    
}
-(CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot
recordIndex:(NSUInteger)index
{
    if ( [barPlot.identifier isEqual:@"fractales"] )
    {
        NSDictionary *bar = [self.data objectAtIndex:index];
        CPTGradient *gradient = [CPTGradient gradientWithBeginningColor:[CPTColor blackColor]//[CPTColor whiteColor]
                                                            endingColor:[bar valueForKey:@"COLOR"]
                                                      beginningPosition:0.0 endingPosition:0.3 ];
        [gradient setGradientType:CPTGradientTypeAxial];
        [gradient setAngle:320.0];
        
        //CPTFill *fill = [CPTFill fillWithGradient:gradient];
        CPTFill *fill = [CPTFill fillWithColor:[bar valueForKey:@"COLOR"]];
        return fill;
        
    }
    return [CPTFill fillWithColor:[CPTColor colorWithComponentRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    
}

- (void)generateBarPlot
{
    //Create host view
    
    
    for (UIView *subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[CPTGraphHostingView class]])
        {
            [subView removeFromSuperview];
        }
    }
    self.hostingView = [[CPTGraphHostingView alloc]
                        initWithFrame:[[UIScreen mainScreen]bounds]];
    //[self.hostingView removeFromSuperview];
    [self.view addSubview:self.hostingView];
    [self.view sendSubviewToBack:self.hostingView];
    
    //Create graph and set it as host view's graph
    self.graph = [[CPTXYGraph alloc] initWithFrame:self.hostingView.bounds];
    [self.hostingView setHostedGraph:self.graph];
    
    
    
    //set graph padding and theme
    self.graph.plotAreaFrame.paddingTop = 55.0f;
    self.graph.plotAreaFrame.paddingRight = 00.0f;
    self.graph.plotAreaFrame.paddingBottom = 85.0f;
    self.graph.plotAreaFrame.paddingLeft = 60.0f;
    //[self.graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    
    //set axes ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
    //plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:
                        //CPTDecimalFromFloat(AXIS_START)
                                                    //length:CPTDecimalFromFloat((AXIS_END - AXIS_START)+5)];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:
                        CPTDecimalFromFloat(0)//(AXIS_START)
                                                    length:CPTDecimalFromFloat((2 - 0)+.99)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:
                        CPTDecimalFromFloat(AXIS_START)
                                                    length:CPTDecimalFromFloat((AXIS_END - AXIS_START)+5)];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;
    
    
    //set axes' title, labels and their text styles
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.fontName = @"Helvetica";
    textStyle.fontSize = 14;
    textStyle.color = [CPTColor blackColor];//[CPTColor whiteColor];
    axisSet.xAxis.title = @"Fractal";
    axisSet.yAxis.title = @"Tiempo (ms x10^-3)";
    axisSet.xAxis.titleTextStyle = textStyle;
    axisSet.yAxis.titleTextStyle = textStyle;
    axisSet.xAxis.titleOffset = 30.0f;
    axisSet.yAxis.titleOffset = 40.0f;
    axisSet.xAxis.labelTextStyle = textStyle;
    axisSet.xAxis.labelOffset = 3.0f;
    axisSet.yAxis.labelTextStyle = textStyle;
    axisSet.yAxis.labelOffset = 3.0f;
    //set axes' line styles and interval ticks
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor blackColor];//[CPTColor whiteColor];
    lineStyle.lineWidth = 3.0f;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(1.0f);
    axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(5.0f);
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTicksPerInterval = 1;
    axisSet.yAxis.minorTicksPerInterval = 1;
    axisSet.xAxis.minorTickLength = 1.0f;
    axisSet.yAxis.minorTickLength = 5.0f;
    
    // Create bar plot and add it to the graph
    CPTBarPlot *plot = [[CPTBarPlot alloc] init] ;
    plot.dataSource = self;
    plot.delegate = self;
    plot.barWidth = [[NSDecimalNumber decimalNumberWithString:@"0.8"]
                     decimalValue];
    plot.barOffset = [[NSDecimalNumber decimalNumberWithString:@"0.5"]
                      decimalValue];
    plot.barCornerRadius = 5.0;
    // Remove bar outlines
    plot.labelRotation = 3.1415/2;

    CPTMutableLineStyle *borderLineStyle = [CPTMutableLineStyle lineStyle];
    borderLineStyle.lineColor = [CPTColor clearColor];
    plot.lineStyle = borderLineStyle;
    // Identifiers are handy if you want multiple plots in one graph
    plot.identifier = @"fractales";
    [self.graph addPlot:plot];
}
@end
