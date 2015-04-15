//
//  SBJasonParser.m
//  scatter
//
//  Created by Kripa on 11/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SBJasonParser.h"
#import "JSON.h"


@implementation SBJasonParser


#pragma mark - Parse JSON Data

- (NSMutableArray *)parseResponseData:(NSMutableString *)iData {    
    NSLog(@"iData  :%@",iData);
    SBJSON *parser = [[SBJSON alloc] init];      
    // parsing the first level  
    NSMutableArray *data = (NSMutableArray *) [parser objectWithString:iData error:nil]; 
     NSLog(@"iData  :%@",data);
    [parser release];
    return data;
}

@end
