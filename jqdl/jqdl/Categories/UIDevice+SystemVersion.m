//
//  UIDevice+SystemVersion.m
//  SDKExamples
//
//  Created by Andreas Schacaherbauer on 10/3/13.
//  Copyright (c) 2013 Wikitude. All rights reserved.
//

#import "UIDevice+SystemVersion.h"



NSString * const kWTiOSVersion_7 = @"7.0";
NSString * const kWTiOSVersion_8 = @"8.0";


@implementation UIDevice (SystemVersion)

+ (BOOL)isRunningiOS:(WTiOSVersion *)iOSVersion;
{
    BOOL isRunningiOS = NO;

    NSComparisonResult systemCheckResult = [[[UIDevice currentDevice] systemVersion] compare:iOSVersion options:NSNumericSearch];
    if ( NSOrderedDescending == systemCheckResult || NSOrderedSame == systemCheckResult) {
        isRunningiOS = YES;
    }
    
    return isRunningiOS;
}

@end
