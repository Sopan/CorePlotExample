//
//  SBFirstViewController.h
//  scatter
//
//  Copyright (c) 2012 Sopan Shekhar Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "SBPlotsObject.h"

@interface SBViewController : UIViewController <CPTPlotDataSource, CPTPlotSpaceDelegate, CPTScatterPlotDataSource, CPTScatterPlotDelegate, UIActionSheetDelegate>{
    NSUInteger selectedIndex;
    CPTPlotSpaceAnnotation *symbolTextAnnotation;
    NSString *selectedPlot;
}

/*! @property CPTGraphHostingView *hostView
 @brief An object of CPTGraphHostingView.
 */
@property (nonatomic, strong) CPTGraphHostingView *hostView;

/*! @property NSMutableArray *modalObjectsArray
 @brief contains an array of objects of modal objects.
 */
@property (nonatomic, retain) NSMutableArray *modalObjectsArray;

/*! @property NSMutableArray *colorArray
 @brief contains an array of color.
 */
@property (nonatomic, retain) NSMutableArray *colorArray;

@end
