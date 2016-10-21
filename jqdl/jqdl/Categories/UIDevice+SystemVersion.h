//
//  UIDevice+SystemVersion.h
//  SDKExamples
//
//  Created by Andreas Schacaherbauer on 10/3/13.
//  Copyright (c) 2013 Wikitude. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NSString WTiOSVersion;
extern NSString * const kWTiOSVersion_7;
extern NSString * const kWTiOSVersion_8;


@interface UIDevice (SystemVersion)

+ (BOOL)isRunningiOS:(WTiOSVersion *)iOSVersion;

@end
