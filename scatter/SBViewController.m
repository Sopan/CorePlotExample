//
//  CPViewController.m
//  CorePlotApplication
//
//  Copyright (c) 2012 Sopan Shekhar Sharma. All rights reserved.
//

#import "SBViewController.h"
#import "SBPlotsObject.h"


#define kCPAreaFillChart @"AreaFillChart"
#define kCPStackedScatterPlot @"StackedScatterPlot"
#define kCPStackedBarPlot @"StackedBarPlot"
#define kCPCancel @"Cancel"
#define kCPDay @"Day"
#define kCPPrice @"Price"
#define kCPAvg @"Avg"

@interface SBViewController ()

/*! @property double xMax
    @brief max X-axis value within the data points.
 */
@property (nonatomic) double xMax;

/*! @property double yPrimaryAxisMax
    @brief max primary Y-axis value within the data points.
 */
@property (nonatomic) double yPrimaryAxisMax;

/*! @property double yPrimaryAxisMax
    @brief max secondary Y-axis value within the data points.
 */
@property (nonatomic) double ySecondaryAxisMax;

/*! @property CPTXYGraph *graph
    @brief instance of CPTXYGraph.
 */
@property (nonatomic, retain) CPTXYGraph *graph;

/*! @property NSMutableArray *plotArray
    @brief contains an array of plot objects.
 */
@property (nonatomic, retain) NSMutableArray *plotArray;

/*! @property CPTXYPlotSpace *yPrimaryAxisPlotSpace
    @brief plotspace for primary Y-axis.
 */
@property (nonatomic, retain) CPTXYPlotSpace *yPrimaryAxisPlotSpace;

/*! @property CPTXYPlotSpace *ySecondaryAxisPlotSpace
    @brief plotspace for secondary Y-axis.
 */
@property (nonatomic, retain) CPTXYPlotSpace *ySecondaryAxisPlotSpace;

/*! @property NSMutableArray *legendList
    @brief array conatining all legend names.
 */
@property (nonatomic, retain) NSMutableArray *legendList;

/*! @property NSMutableArray *yPrimaryAxisLegendList
    @brief array conatining all primary Y-axis legend names.
 */
@property (nonatomic, retain) NSMutableArray *yPrimaryAxisLegendList;

/*! @property NSMutableArray *ySecondaryAxisLegends
    @brief array conatining all secondary Y-axis legend names.
 */
@property (nonatomic, retain) NSMutableArray *ySecondaryAxisLegendList;

/*! @property UIBarButtonItem *actionSheetButton
    @brief bar button for an action sheet.
 */
@property (nonatomic, retain) UIBarButtonItem *actionSheetButton;

/*! @property NSString *chartType
    @brief satring containing the chart type.
 */
@property (nonatomic, retain) NSString *chartType;

/*! @fn - (void)loadSampleData
    @brief Responsible for loading the data.
 */
- (void)loadSampleData;

/*! @fn - (void)calculatePointsForPlottingGraph
    @brief Responsible for calculating the points to be plotted in the graph.
 */
- (void)calculatePointsForPlottingGraph;

/*! @fn - (void)configureHost
    @brief Method to configure the host view.
 */
- (void)configureHost;

/*! @fn - (void)configureGraph
    @brief Method to configure the graph view.
 */
- (void)configureGraph;

/*! @fn - (void)computeMaximumAndMinimumValues
    @brief Method to compute the max and min values which are to be plotted on the axes.
 */
- (void)computeMaximumAndMinimumValues;

/*! @fn - (void)configureAxes
    @brief Method to configure the axes based on the graph type selected.
 */
- (void)configureAxes;

/*! @fn - (void)loadGraphContents
    @brief Method responsible for calling various methods to create graphs.
 */
- (void)loadGraphContents;

/*! @fn - (void)inputOnBothAxis
    @brief Responsible for containing data points for both the axes.
 */
- (void)inputOnBothAxis;

/*! @fn - (void)inputOnPrimaryAxisOnly
    @brief Responsible for containing data points for primary axis only.
 */
- (void)inputOnPrimaryAxisOnly;

@end

@implementation SBViewController
@synthesize hostView, xMax, graph, actionSheetButton, chartType;
@synthesize colorArray, plotArray, modalObjectsArray, legendList;
@synthesize yPrimaryAxisPlotSpace, ySecondaryAxisPlotSpace, yPrimaryAxisMax ,  ySecondaryAxisMax, yPrimaryAxisLegendList, ySecondaryAxisLegendList;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
    self.chartType = kCPStackedBarPlot;
    
    [self configureHost];    
    [self loadGraphContents];
    
    self.actionSheetButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"OptionImage.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickOnOptionButton:)];
    self.navigationItem.rightBarButtonItem = self.actionSheetButton;
}

- (void)dealloc {
    self.hostView = nil;
    self.graph = nil;
    self.actionSheetButton = nil;
    self.chartType = nil;
    self.colorArray = nil;
    self.plotArray = nil;
    self.modalObjectsArray = nil;
    self.legendList = nil;
    self.yPrimaryAxisPlotSpace = nil;
    self.ySecondaryAxisPlotSpace = nil;
    self.yPrimaryAxisLegendList = nil;
    self.ySecondaryAxisLegendList = nil;
    [super dealloc];
}

- (void)loadGraphContents {
    [self.hostView.hostedGraph removeFromSuperlayer];
    [self configureGraph];
    [self loadSampleData];
    [self configurePlots];
    [self configureAxes];
}

- (void)loadSampleData {
    
    self.modalObjectsArray = [[[NSMutableArray alloc] initWithObjects:nil] autorelease];
    self.colorArray = [[[NSMutableArray alloc] initWithObjects:[UIColor orangeColor], [UIColor greenColor], [UIColor purpleColor], [UIColor brownColor], [UIColor blueColor], [UIColor purpleColor], [UIColor brownColor], [UIColor blueColor], nil] autorelease];
    self.plotArray = [[[NSMutableArray alloc] initWithObjects:nil] autorelease];
    self.legendList = [NSMutableArray array];
    
    self.yPrimaryAxisLegendList = [NSMutableArray array];
    self.ySecondaryAxisLegendList = [NSMutableArray array];
    
    if ([self.chartType isEqualToString:kCPAreaFillChart]) {
        [self inputOnBothAxis];
    } else {
        [self inputOnPrimaryAxisOnly];
    }
    
    
}

- (void)inputOnBothAxis {
    SBPlotsObject *aplot = [[SBPlotsObject alloc] init];
    aplot.xAxisPoints = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    aplot.yAxisPoints = [[NSMutableArray alloc] initWithObjects:@"8", @"9", @"10", @"11", @"8", @"9", @"10", @"11", @"8", @"9", @"10", @"13", @"15", @"17", @"9", @"11", @"8", @"15", @"17", @"1", nil];
    aplot.isFirstYAxis = YES;
    aplot.name = @"0";
    [self.legendList addObject:aplot.name];
    [self.modalObjectsArray addObject:aplot];
    [self.yPrimaryAxisLegendList addObject:aplot];
    [aplot release];
    
    aplot = [[SBPlotsObject alloc] init];
    aplot.xAxisPoints = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    aplot.yAxisPoints = [[NSMutableArray alloc] initWithObjects:@"2", @"4", @"6", @"8", @"10", @"12", @"14", @"16", @"18", @"20", @"1", @"3", @"5", @"7", @"9", @"11", @"13", @"15", @"17", @"19", nil];
    aplot.isFirstYAxis = YES;
    aplot.name = @"1";
    [self.legendList addObject:aplot.name];
    [self.modalObjectsArray addObject:aplot];
    [self.yPrimaryAxisLegendList addObject:aplot];
    [aplot release];
    
    aplot = [[SBPlotsObject alloc] init];
    aplot.xAxisPoints = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    aplot.yAxisPoints = [[NSMutableArray alloc] initWithObjects:@"130", @"140", @"130", @"150", @"100", @"130", @"130", @"150", @"170", @"150", @"130", @"140", @"150", @"190", @"104", @"110", @"130", @"140", @"120", @"150", nil];
    aplot.isFirstYAxis = NO;
    aplot.name = @"2";
    [self.legendList addObject:aplot.name];
    [self.modalObjectsArray addObject:aplot];
    [self.ySecondaryAxisLegendList addObject:aplot];
    [aplot release];
    
}

- (void)inputOnPrimaryAxisOnly {
    SBPlotsObject *aplot = [[SBPlotsObject alloc] init];
    aplot.xAxisPoints = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    aplot.yAxisPoints = [[NSMutableArray alloc] initWithObjects:@"8", @"9", @"10", @"11", @"8", @"9", @"10", @"11", @"8", @"9", @"10", @"13", @"15", @"17", @"9", @"11", @"8", @"15", @"17", @"1", nil];
    aplot.isFirstYAxis = YES;
    aplot.name = @"0";
    [self.legendList addObject:aplot.name];
    [self.modalObjectsArray addObject:aplot];
    [self.yPrimaryAxisLegendList addObject:aplot];
    [aplot release];
    
    aplot = [[SBPlotsObject alloc] init];
    aplot.xAxisPoints = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    aplot.yAxisPoints = [[NSMutableArray alloc] initWithObjects:@"2", @"4", @"6", @"8", @"10", @"12", @"14", @"16", @"18", @"20", @"1", @"3", @"5", @"7", @"9", @"11", @"13", @"15", @"17", @"19", nil];
    aplot.isFirstYAxis = YES;
    aplot.name = @"1";
    [self.legendList addObject:aplot.name];
    [self.modalObjectsArray addObject:aplot];
    [self.yPrimaryAxisLegendList addObject:aplot];
    [aplot release];
    
    aplot = [[SBPlotsObject alloc] init];
    aplot.xAxisPoints = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    aplot.yAxisPoints = [[NSMutableArray alloc] initWithObjects:@"12", @"13", @"12", @"13", @"10", @"12", @"11", @"10", @"11", @"13", @"12", @"14", @"14", @"19", @"14", @"13", @"11", @"14", @"12", @"10", nil];
    aplot.isFirstYAxis = YES;
    aplot.name = @"2";
    [self.legendList addObject:aplot.name];
    [self.modalObjectsArray addObject:aplot];
    [self.yPrimaryAxisLegendList addObject:aplot];
    [aplot release];
}

- (void)clickOnOptionButton:(id)iSender {
    UIActionSheet *anActionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [anActionSheet setTag:0];
    [anActionSheet addButtonWithTitle:kCPAreaFillChart];
    [anActionSheet addButtonWithTitle:kCPStackedScatterPlot];
    [anActionSheet addButtonWithTitle:kCPStackedBarPlot];
    [anActionSheet addButtonWithTitle:kCPCancel];
    anActionSheet.cancelButtonIndex = 3;
    [anActionSheet showInView:self.view];
    [anActionSheet release];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        self.chartType = kCPAreaFillChart;
        [self loadGraphContents];
    } else if (buttonIndex == 1) {
        self.chartType = kCPStackedScatterPlot;
        [self loadGraphContents];
    } else if (buttonIndex == 2) {
        self.chartType = kCPStackedBarPlot;
        [self loadGraphContents];
    }
}


- (void)configureHost {
    self.hostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [[UIScreen mainScreen] bounds].size.height, 270.0f)];
    self.hostView.backgroundColor =[UIColor grayColor];
    [self.view addSubview:self.hostView];
}

- (void)configureGraph {
    self.graph = [[CPTXYGraph alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [[UIScreen mainScreen] bounds].size.height, 270.0f)];
    [self.graph applyTheme:[CPTTheme themeNamed:kCPTPlainBlackTheme]];
    
    self.hostView.hostedGraph = self.graph;
    [self.hostView.hostedGraph setDelegate:self];
    
    [self.graph.plotAreaFrame setPaddingLeft:30.0f];
    [self.graph.plotAreaFrame setPaddingBottom:50.0f];
    [self.graph.plotAreaFrame setPaddingRight:30.0f];
    [self.graph.plotAreaFrame setPaddingTop:15.0f];
    [self.graph.plotAreaFrame setBorderLineStyle:nil];
    
    [self.graph setTopDownLayerOrder:[NSArray arrayWithObjects: [NSNumber numberWithInt:CPTGraphLayerTypeAxisLines],
                                      [NSNumber numberWithInt:CPTGraphLayerTypeMajorGridLines],
                                      [NSNumber numberWithInt:CPTGraphLayerTypePlots],
                                      nil]];
    
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 10.0f;
    self.graph.titleTextStyle = titleStyle;
    self.graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    self.graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
    
    CPTMutableTextStyle *legendTextStyle = [CPTTextStyle textStyle];
    legendTextStyle.fontSize = 10.0f;
    legendTextStyle.color = [CPTColor whiteColor];
    CPTLegend *theLegend = [CPTLegend legendWithGraph:self.graph];
    theLegend.numberOfRows = 1;
    theLegend.textStyle = legendTextStyle;
    
    graph.legend = theLegend;
    graph.legendAnchor = CPTRectAnchorBottom;
    [graph.legend setDelegate:self];
}


- (CPTPlotSymbol *)symbolForScatterPlot:(CPTScatterPlot *)plot recordIndex:(NSUInteger)index {
    CGFloat xax;
    CGFloat yax;
    CPTPlotSymbol *aaplSymbol;
    NSDecimal plotPoint[2];
    CGPoint plotAreaPoint = [self.hostView.hostedGraph convertPoint:plot.position toLayer:self.hostView.hostedGraph.plotAreaFrame.plotArea];
    [self.hostView.hostedGraph.defaultPlotSpace plotPoint:plotPoint forPlotAreaViewPoint:plotAreaPoint];
    
    xax = [[NSDecimalNumber decimalNumberWithDecimal:plotPoint[CPTCoordinateX]] intValue];
    yax = [[NSDecimalNumber decimalNumberWithDecimal:plotPoint[CPTCoordinateY]] doubleValue];
    if (index == selectedIndex && [selectedPlot isEqualToString:(NSString *)plot.identifier]) {
        CPTPlotSymbol *aaplSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        aaplSymbol.fill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:0.267 green:0.5686 blue:0.7254 alpha:1.0]];
        aaplSymbol.size = CGSizeMake(12.0f, 12.0f);
        plot.plotSymbol = aaplSymbol;
        
        if ( symbolTextAnnotation ) {
            [self.hostView.hostedGraph.plotAreaFrame.plotArea removeAnnotation:symbolTextAnnotation];
            [symbolTextAnnotation release];
            symbolTextAnnotation = nil;
        }
        
        
        // Setup a style for the annotation
        CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
        hitAnnotationTextStyle.color    = [CPTColor whiteColor];
        hitAnnotationTextStyle.fontSize = 12.0f;
        hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
        
        // Determine point of symbol in plot coordinates
        NSNumber *x = [NSNumber numberWithFloat:[[[(SBPlotsObject *)[self.modalObjectsArray objectAtIndex:[selectedPlot intValue]] xAxisPoints] objectAtIndex:index]floatValue]];
        NSNumber *y = [NSNumber numberWithFloat:[[[(SBPlotsObject *)[self.modalObjectsArray objectAtIndex:[selectedPlot intValue]] yAxisPoints] objectAtIndex:index]floatValue]];
        NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
        
        // Add annotation
        // First make a string for the y value
        NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
        [formatter setMaximumFractionDigits:2];
        NSString *yString = [formatter stringFromNumber:y];
        
        // Now add the annotation to the plot area
        CPTTextLayer *textLayer = [[[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@" Price:%@ ", yString ] style:hitAnnotationTextStyle] autorelease];
        symbolTextAnnotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:[(SBPlotsObject *)[self.modalObjectsArray objectAtIndex:[selectedPlot intValue]] plotSpace] anchorPlotPoint:anchorPoint];
        symbolTextAnnotation.contentLayer = textLayer;
        symbolTextAnnotation.displacement = CGPointMake(0.0f, 15.0f);
        symbolTextAnnotation.contentLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        symbolTextAnnotation.contentLayer.opacity = 0.7f;
        [self.hostView.hostedGraph.plotAreaFrame.plotArea addAnnotation:symbolTextAnnotation];
        
        selectedIndex = index;
        
        return aaplSymbol;
    }
    
    aaplSymbol = [self drawLineForPlot:plot withColor:[self.colorArray objectAtIndex:[(NSString *)plot.identifier intValue]]];
    
    return aaplSymbol;
}


- (CPTPlotSymbol *)drawLineForPlot:(CPTScatterPlot *)plot withColor:(CPTColor *)iColor {
    
    CPTMutableLineStyle *aScatterLineStyle = [plot.dataLineStyle mutableCopy];
    aScatterLineStyle.lineWidth = 1.0;
    aScatterLineStyle.lineColor = iColor;
    plot.dataLineStyle = aScatterLineStyle;
    CPTMutableLineStyle *aaplSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    aaplSymbolLineStyle.lineColor = iColor;
    
    CPTPlotSymbol * aaplSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    aaplSymbol.fill = [CPTFill fillWithColor:iColor];
    aaplSymbol.lineStyle = aaplSymbolLineStyle;
    aaplSymbol.size = CGSizeMake(4.0f, 4.0f);
    plot.plotSymbol = aaplSymbol;
    return aaplSymbol;
}


- (void)calculatePointsForPlottingGraph {
    BOOL isSameAxis = NO;
    int c = 0;
    
    for (SBPlotsObject *item in self.modalObjectsArray) {
        if (item.isFirstYAxis) {
            c++;
        }
    }
    
    if ((c == [self.modalObjectsArray count]) || c == 0){
        isSameAxis = YES ;
    }
    
    if (isSameAxis && ![self.chartType isEqualToString:kCPStackedBarPlot]) {
        
        for (int i = 0; i < [self.modalObjectsArray count]; i++) {// modal1, modal2, modal3
            NSMutableArray *newArray = [NSMutableArray array];
            
            for (int j = 0; j < [(NSMutableArray*)[[self.modalObjectsArray objectAtIndex:i] yAxisPoints] count]; j++) { // modal1 y1,y2,y3,y4
                
                float pt = [[(NSMutableArray*)[[self.modalObjectsArray objectAtIndex:i] yAxisPoints] objectAtIndex:j] floatValue];//y1
                float newPoint = pt;
                
                for (int k=i+1; k < [self.modalObjectsArray count]; k++) {// modal2, modal3
                    
                    newPoint = newPoint + [[(NSMutableArray*)[[self.modalObjectsArray objectAtIndex:k] yAxisPoints] objectAtIndex:j] floatValue];
                }
                [newArray addObject:[NSString stringWithFormat:@"%f", newPoint]];
                
            }
            
            [[self.modalObjectsArray objectAtIndex:i] setYAxisPoints:newArray];
        }
    }
}


- (void)computeMaximumAndMinimumValues {
    
    self.yPrimaryAxisMax = 0;
    self.ySecondaryAxisMax = 0;
    self.xMax = 0;
    
    self.xMax = [[[self.modalObjectsArray objectAtIndex:0]xAxisPoints] count];
    
    if ([self.chartType isEqualToString:kCPStackedBarPlot]) {
        for (int i = 0; i < [self.modalObjectsArray count]; i++) {// modal1, modal2, modal3
            
            for (int j = 0; j < [(NSMutableArray*)[[self.modalObjectsArray objectAtIndex:i] yAxisPoints] count]; j++) { // modal1 y1,y2,y3,y4
                
                float pt = [[(NSMutableArray*)[[self.modalObjectsArray objectAtIndex:i] yAxisPoints] objectAtIndex:j] floatValue];//y1
                float newPoint = pt;
                
                for (int k=i+1; k < [self.modalObjectsArray count]; k++) {// modal2, modal3
                    
                    newPoint = newPoint + [[(NSMutableArray*)[[self.modalObjectsArray objectAtIndex:k] yAxisPoints] objectAtIndex:j] floatValue];
                    if (self.yPrimaryAxisMax < newPoint) {
                        self.yPrimaryAxisMax = newPoint;
                    }
                }
                
            }
        }
    } else {
        
        for(SBPlotsObject *anObject in self.modalObjectsArray){
            
            if (anObject.isFirstYAxis == YES) {
                
                for (NSString *yAxisValues in anObject.yAxisPoints) {
                    if (self.yPrimaryAxisMax < [yAxisValues doubleValue]) {
                        self.yPrimaryAxisMax = [yAxisValues doubleValue];
                    }
                }
                
            } else {
                
                for (NSString *yAxisValues in anObject.yAxisPoints) {
                    if (self.ySecondaryAxisMax < [yAxisValues doubleValue]) {
                        self.ySecondaryAxisMax = [yAxisValues doubleValue];
                    }
                }
                
            }
            
        }
    }
    
}


- (void)legend:(CPTLegend *)legend tappedOnLegendEntry:(CPTLegendEntry *)legendEntry atIndex:(NSUInteger)index forPlot:(CPTPlot *)plot inRect:(CGRect)rect{
   // implement the action that should be performed when legend is touched
}


- (void)configurePlots {
    // 1 - Get graph and plot space
    [self calculatePointsForPlottingGraph];
    [self computeMaximumAndMinimumValues];    
    
    for (int i = 0; i < [self.modalObjectsArray count]; i++) {
        CPTXYPlotSpace *aPlotSpace;
        if ([[self.modalObjectsArray objectAtIndex:i] isFirstYAxis]) {
            aPlotSpace = (CPTXYPlotSpace *) self.hostView.hostedGraph.defaultPlotSpace;
            aPlotSpace.identifier = [NSString stringWithFormat:@"%d", i];//@"scatterPlot";
            aPlotSpace.allowsUserInteraction = YES;
            [aPlotSpace setDelegate:self];
            
            
            if ([[self.modalObjectsArray objectAtIndex:i] isFirstYAxis]) {
                aPlotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(self.yPrimaryAxisMax + 2)];
            } else {
                aPlotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(self.ySecondaryAxisMax)];
            }
            if ([self.chartType isEqualToString:kCPStackedBarPlot]) {
                aPlotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromDouble(self.xMax)];
                
                CPTBarPlot *aBarPlot = [[CPTBarPlot alloc] init];
                aBarPlot.dataSource = self;
                aBarPlot.delegate = self;
                aBarPlot.identifier = [NSString stringWithFormat:@"%d", i];
                aBarPlot.title = [NSString stringWithFormat:@"Commodity%d", i];
                
                aBarPlot.barBasesVary = YES;
                aBarPlot.barWidth = CPTDecimalFromFloat(0.5f); // bar is full (100%) width
                aBarPlot.fill = [CPTFill fillWithColor:[CPTColor colorWithCGColor:[[self.colorArray objectAtIndex:i] CGColor]]];
                [self.hostView.hostedGraph addPlot:aBarPlot toPlotSpace:aPlotSpace];
                 [self.hostView.hostedGraph.legend insertPlot:aBarPlot atIndex:i];
                [[self.modalObjectsArray objectAtIndex:i] setPlotSpace:aPlotSpace];
                [aBarPlot release];
            } else {
                aPlotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromDouble(self.xMax-1)];
                
                CPTScatterPlot *aScatterPlot = [[CPTScatterPlot alloc] init];
                aScatterPlot.dataSource = self;
                aScatterPlot.delegate = self;
                aScatterPlot.identifier = [NSString stringWithFormat:@"%d", i];
                aScatterPlot.plotSymbolMarginForHitDetection = 15.0f;
                aScatterPlot.title =[NSString stringWithFormat:@"Commodity:%d", i];
                aScatterPlot.areaFill = [CPTFill fillWithColor:[[CPTColor colorWithCGColor:[[self.colorArray objectAtIndex:i] CGColor]] colorWithAlphaComponent:0.6f]];
                aScatterPlot.areaBaseValue = CPTDecimalFromString(@"0.0");
                [self.hostView.hostedGraph addPlot:aScatterPlot toPlotSpace:aPlotSpace];
                [self.hostView.hostedGraph.legend insertPlot:aScatterPlot atIndex:i];
                [[self.modalObjectsArray objectAtIndex:i] setPlotSpace:aPlotSpace];
                [aScatterPlot release];            
            }
            
            self.yPrimaryAxisPlotSpace = (CPTXYPlotSpace *) self.hostView.hostedGraph.defaultPlotSpace;
        } else {
            aPlotSpace = [[[CPTXYPlotSpace alloc] init] autorelease];
            aPlotSpace.identifier = [NSString stringWithFormat:@"%d", i];
            aPlotSpace.allowsUserInteraction = YES;
            [aPlotSpace setDelegate:self];
            
            aPlotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromInt(self.xMax-1)];
            if ([[self.modalObjectsArray objectAtIndex:i] isFirstYAxis]) {
                aPlotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(self.yPrimaryAxisMax + 2)];
            } else {
                aPlotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(self.ySecondaryAxisMax)];
            }            
            
            [self.hostView.hostedGraph addPlotSpace:aPlotSpace];
            
            CPTScatterPlot *aScatterPlot2 = [[CPTScatterPlot alloc] init];
            aScatterPlot2.dataSource = self;
            aScatterPlot2.delegate = self;
            aScatterPlot2.identifier = [NSString stringWithFormat:@"%d", i];
            [[self.modalObjectsArray objectAtIndex:i] setName:[NSString stringWithFormat:@"%d", i]];
            aScatterPlot2.title = [NSString stringWithFormat:@"Commodity%d", i];
            aScatterPlot2.plotSymbolMarginForHitDetection = 15.0f;
            aScatterPlot2.areaFill = [CPTFill fillWithColor:[[CPTColor colorWithCGColor:[[self.colorArray objectAtIndex:i] CGColor]] colorWithAlphaComponent:0.6f]];
            aScatterPlot2.areaBaseValue = CPTDecimalFromString(@"0.0");
            [self.hostView.hostedGraph addPlot:aScatterPlot2 toPlotSpace:aPlotSpace];
             [self.hostView.hostedGraph.legend insertPlot:aScatterPlot2 atIndex:i];
            [[self.modalObjectsArray objectAtIndex:i] setPlotSpace:aPlotSpace];
            [aScatterPlot2 release];
            
            self.ySecondaryAxisPlotSpace = (CPTXYPlotSpace *) aPlotSpace;
        }
        
        [aPlotSpace release];
    }
    
    
}


-(void)configureAxes {
    
    // 1 - Create styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor whiteColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 10.0f;
    
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 2.0f;
	axisLineStyle.lineColor = [CPTColor whiteColor];
    
	CPTMutableTextStyle *axisTextStyle = [CPTMutableTextStyle textStyle];
	axisTextStyle.color = [CPTColor whiteColor];
	axisTextStyle.fontName = @"Helvetica-Bold";
	axisTextStyle.fontSize = 11.0f;
    
	CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor whiteColor];
	tickLineStyle.lineWidth = 2.0f;
    
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 1.0f;
    majorGridLineStyle.lineColor = [[CPTColor grayColor] colorWithAlphaComponent:0.75];
    
    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 1.0f;
    minorGridLineStyle.lineColor = [[CPTColor grayColor] colorWithAlphaComponent:0.25];
    
	// 2 - Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    
	// 3 - Configure x-axis
    CPTAxis *theXAxis = axisSet.xAxis;
    theXAxis.titleTextStyle = axisTextStyle;
    theXAxis.title = kCPDay;
	theXAxis.titleOffset = 15.0f;
	theXAxis.axisLineStyle = axisLineStyle;
	theXAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
	theXAxis.labelTextStyle = axisTextStyle;
	theXAxis.majorTickLineStyle = axisLineStyle;
	theXAxis.majorTickLength = 4.0f;
    theXAxis.labelOffset = 16.0f;
	theXAxis.tickDirection = CPTSignNegative;
    
	NSMutableSet *xLabels = [NSMutableSet setWithCapacity:10];
	NSMutableSet *xLocations = [NSMutableSet setWithCapacity:10];
    int numberOfXAxisPoints = [[[self.modalObjectsArray objectAtIndex:0] xAxisPoints] count];
    
	for (int i = 0; i <  numberOfXAxisPoints; i++) {
        if (i%3 == 0) {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%d", i]  textStyle:theXAxis.labelTextStyle];
            CGFloat location = i;
            label.tickLocation = CPTDecimalFromCGFloat(location);
            label.offset = theXAxis.majorTickLength;
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
		
	}
	theXAxis.axisLabels = xLabels;
	theXAxis.majorTickLocations = xLocations;
    
	// 4 - Configure y-axis
	CPTAxis *theLeftYAxis = axisSet.yAxis;
	theLeftYAxis.title = kCPPrice;
	theLeftYAxis.titleTextStyle = axisTitleStyle;
	theLeftYAxis.titleOffset = 16.0f;
	theLeftYAxis.axisLineStyle = axisLineStyle;
	theLeftYAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
	theLeftYAxis.labelTextStyle = axisTextStyle;
	theLeftYAxis.labelOffset = 16.0f;
	theLeftYAxis.majorTickLineStyle = axisLineStyle;
	theLeftYAxis.majorTickLength = 4.0f;
	theLeftYAxis.minorTickLength = 2.0f;
	theLeftYAxis.tickDirection = CPTSignNegative;
	
	NSMutableSet *yAxisLabels = [NSMutableSet setWithCapacity:10];
	NSMutableSet *yAxisLocations = [NSMutableSet setWithCapacity:10];
    int numberOfyAxisPoints = yPrimaryAxisMax;
    
	for (int i = 0; i <  numberOfyAxisPoints; i++) {
        if (i % 6 == 0 ) {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%d", i]  textStyle:theLeftYAxis.labelTextStyle];
            CGFloat location = i;
            label.tickLocation = CPTDecimalFromCGFloat(location);
            label.offset = theLeftYAxis.majorTickLength;
            [yAxisLabels addObject:label];
            [yAxisLocations addObject:[NSNumber numberWithFloat:location]];
        }
	}
    theLeftYAxis.axisLabels = yAxisLabels;
	theLeftYAxis.majorTickLocations = yAxisLocations;
    
    if ([self.chartType isEqualToString:kCPAreaFillChart]) {
        CPTXYAxis *theRightYAxis = [(CPTXYAxis *)[CPTXYAxis alloc] initWithFrame:CGRectZero];
        theRightYAxis.coordinate = CPTCoordinateY;
        theRightYAxis.orthogonalCoordinateDecimal = CPTDecimalFromInt(self.xMax - 1);
        theRightYAxis.title = kCPAvg;
        theRightYAxis.titleTextStyle = axisTitleStyle;
        theRightYAxis.titleOffset = 15.0f;
        theRightYAxis.axisLineStyle = axisLineStyle;
        theRightYAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
        theRightYAxis.labelTextStyle = axisTextStyle;
        theRightYAxis.labelOffset = 16.0f;
        theRightYAxis.majorTickLineStyle = axisLineStyle;
        theRightYAxis.majorTickLength = 4.0f;
        theRightYAxis.minorTickLength = 2.0f;
        theRightYAxis.tickDirection = CPTSignPositive;
        theRightYAxis.plotSpace = self.ySecondaryAxisPlotSpace;
        
        NSMutableSet *ySecondaryAxisLabels = [NSMutableSet setWithCapacity:10];
        NSMutableSet *ySecondaryAxisLocations = [NSMutableSet setWithCapacity:10];
        int numberOfSecondaryYAxisPoints = self.ySecondaryAxisMax;
        
        for (int i = 0; i <  numberOfSecondaryYAxisPoints; i++) {
            if (i % 30 == 0) {
                CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%d", i]  textStyle:theRightYAxis.labelTextStyle];
                CGFloat location = i;
                label.tickLocation = CPTDecimalFromCGFloat(location);
                label.offset = theRightYAxis.majorTickLength;
                [ySecondaryAxisLabels addObject:label];
                [ySecondaryAxisLocations addObject:[NSNumber numberWithFloat:location]];
            }
            
        }
        theRightYAxis.axisLabels = ySecondaryAxisLabels;
        theRightYAxis.majorTickLocations = ySecondaryAxisLocations;
        
        self.hostView.hostedGraph.axisSet.axes = [NSArray arrayWithObjects:theXAxis, theLeftYAxis, theRightYAxis, nil];
        
    }
}


- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    
    return [[[self.modalObjectsArray objectAtIndex:0] xAxisPoints] count];
}


- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    
    if ([plot isKindOfClass:[CPTScatterPlot class]]) {
        switch (fieldEnum) {
                
            case CPTScatterPlotFieldX:
                return [NSNumber numberWithInteger:index];
                break;
                
            case CPTScatterPlotFieldY:
                return [NSNumber numberWithInteger:[[[(SBPlotsObject *)[self.modalObjectsArray objectAtIndex:[(NSString *)plot.identifier intValue]] yAxisPoints] objectAtIndex:index] intValue]];
                break;
        }        
        
    } else if ([plot isKindOfClass:[CPTBarPlot class]]) {
        int tipValue = 0;
        int baseValue = 0;
        switch (fieldEnum) {
            case CPTBarPlotFieldBarLocation:
                return [NSNumber numberWithInteger:index];
                break;
                
            case CPTBarPlotFieldBarBase:
                for (int i = 0; i < [(NSString *)plot.identifier integerValue]; i++) {
                    tipValue = tipValue + [[[(SBPlotsObject *)[self.modalObjectsArray objectAtIndex:i] yAxisPoints] objectAtIndex:index] integerValue];
                }
                
                return [NSNumber numberWithInteger:tipValue];
                break;
                
            case CPTBarPlotFieldBarTip:
                
                for (int i = 0; i <= [(NSString *)plot.identifier integerValue]; i++) {
                    baseValue = baseValue + [[[(SBPlotsObject *)[self.modalObjectsArray objectAtIndex:i] yAxisPoints] objectAtIndex:index] integerValue];
                }
                
                return [NSNumber numberWithInteger:baseValue];
                break;
                
        }
        
    }
    return [NSDecimalNumber zero];
}


- (void)getPlotForGraph:(CPTPlot *)iPlot andColor:(NSMutableArray *)iColor {
    // implement the action that should be done on tap on the legends..........
    NSLog(@"Legend Tapped");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

