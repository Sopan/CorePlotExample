//
//  SBScatterPlots.h
//  scatter
//
//  Copyright (c) 2012 Sopan Shekhar Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBPlotsObject : NSObject 

/*! @property NSMutableArray *xAxisPoints
 @brief contains an array of x-axis points.
 */
@property (nonatomic, retain) NSMutableArray *xAxisPoints;

/*! @property NSMutableArray *yAxisPoints
 @brief contains an array of y-axis points.
 */
@property (nonatomic, retain) NSMutableArray *yAxisPoints;

/*! @property BOOL isFirstYAxis
 @brief would sepicify whether that axis is primary y-Axis.
 */
@property (nonatomic) BOOL isFirstYAxis;

/*! @property NSString *name
 @brief a string that hold a name for the plot.
 */
@property (nonatomic, retain) NSString *name;

/*! @property CPTPlotSpace *plotSpace
 @brief an object of CPTPlotSpace.
 */
@property (nonatomic, retain) CPTPlotSpace *plotSpace;

@end

