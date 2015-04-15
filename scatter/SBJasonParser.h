//
//  SBJasonParser.h
//  scatter
//
//  Created by Kripa on 11/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBJasonParser : NSObject

- (NSMutableArray *)parseResponseData:(NSMutableString *)iData; 

@end
