//
//  PlotSingleViewController.cpp
//  iosNativeStoryboardArc
//
//  Created by Jorge Ruiz on 11/23/13.
//
//

#include "PlotSingleViewController.h"
#include "algoritmos.h"
#include "koch.h"
#include "tapete.h"
#include "PDFViewController.h"

@interface PlotSingleViewController () {}

@end

@implementation PlotSingleViewController

#define BAR_POSITION @"POSITION"
#define BAR_HEIGHT @"HEIGHT"
#define COLOR @"COLOR"
#define CATEGORY @"CATEGORY"

#define AXIS_START 0
#define AXIS_END 20

@synthesize data;
@synthesize graph;
@synthesize hostingView;
@synthesize itNum;
@synthesize fractValue;

NSData *pdf;

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
    
    float bar_heights[8]; // numero de iteraciones
    
    //
    float ltemp = 2.0;
    
    int iteraciones = 0;

    
    NSDate *start=[NSDate date];
    NSDate *end=[NSDate date];

    NSString *categories[8];

    for(int i = 0; i < 8; i++){
        iteraciones = i;
        switch (fractValue) {
            case 0:
                start=[NSDate date];
                divide_triangle(v[0], v[1], v[2], iteraciones, ofVec2f(0,0), 0);
                end=[NSDate date];
                bar_heights[iteraciones] = (float)[end timeIntervalSinceDate:start];
                break;
            case 1:
                start=[NSDate date];
                drawsnowflake( iteraciones );
                end=[NSDate date];
                bar_heights[iteraciones] = (float)[end timeIntervalSinceDate:start];
                break;
            case 2:
                start=[NSDate date];
                tapete(-ltemp/2.0, -ltemp/2.0, ltemp, iteraciones, ofColor(255,255,255));
                end=[NSDate date];
                bar_heights[iteraciones] = (float)[end timeIntervalSinceDate:start];
                break;
            default:
                break;
        }
        categories[iteraciones] = [NSString stringWithFormat:@"%f ms", bar_heights[iteraciones]];
    }
    

    for(int i = 0; i < 8; i++){
        bar_heights[i] *= 1000.0;
    }
    
    
    //float bar_heights[] = {20,30,10};
    UIColor *colors[] = {
        [UIColor redColor],
        [UIColor blueColor],
        [UIColor orangeColor]};
    //[UIColor purpleColor]};
    //NSString *categories[] = {@"Triangulo", @"Copo", @"Tapete"};
    
    
    for (int i = 0; i < 8 ; i++){
        double position = i ; //Bars will be 10 pts away from each other
        double height = bar_heights[i];
        
        NSDictionary *bar = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithDouble:position],BAR_POSITION,
                             [NSNumber numberWithDouble:height],BAR_HEIGHT,
                             colors[0],COLOR,
                             categories[i],CATEGORY,
                             nil];
        [self.data addObject:bar];
    }
    [self generateBarPlot];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //fractValue = 1; //cambiar al ser enviado por la vista previa
    [self grafica];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
        //textStyle.textAlignment
        
        NSDictionary *bar = [self.data objectAtIndex:index];
        CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%@", [bar valueForKey:@"CATEGORY"]]];
        label.textStyle =textStyle;
        
        // = 3.1415/2;
        
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
- (IBAction)generaPDF{
    
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
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:
                        CPTDecimalFromFloat(0)//(AXIS_START)
                                                    length:CPTDecimalFromFloat((7 - 0)+.99)];//((AXIS_END - AXIS_START)+5)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:
                        CPTDecimalFromFloat(AXIS_START)
                                                    length:CPTDecimalFromFloat((AXIS_END - AXIS_START)+30)];
    

    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;
    //axisSet.xAxis.labelRotation = 3.1415/2;
    //set axes' title, labels and their text styles
    
    //axisSet.xAxis.labelFormatter = [NSFormatter setf]
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.fontName = @"Helvetica";
    textStyle.fontSize = 14;
    textStyle.color = [CPTColor blackColor];//[CPTColor whiteColor];
    axisSet.xAxis.title = @"Fractal (iteraciones)";
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
    plot.labelRotation = 3.1415/2;
    plot.barWidth = [[NSDecimalNumber decimalNumberWithString:@"0.8"]
                     decimalValue];
    plot.barOffset = [[NSDecimalNumber decimalNumberWithString:@"0.5"]
                      decimalValue];
    plot.barCornerRadius = 5.0;
    // Remove bar outlines
    CPTMutableLineStyle *borderLineStyle = [CPTMutableLineStyle lineStyle];
    borderLineStyle.lineColor = [CPTColor clearColor];
    plot.lineStyle = borderLineStyle;
    // Identifiers are handy if you want multiple plots in one graph
    plot.identifier = @"fractales";
    [self.graph addPlot:plot];
    pdf = [self.graph dataForPDFRepresentationOfLayer];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PDFViewController *next = segue.destinationViewController;
    next.pdf = pdf;
}

@end
