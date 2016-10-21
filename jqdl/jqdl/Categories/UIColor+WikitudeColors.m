//
//  UIColor+WikitudeColors.m
//  SDKExamples
//
//  Created by Andreas Schacherbauer on 23/09/14.
//  Copyright (c) 2014 Wikitude. All rights reserved.
//

#import "UIColor+WikitudeColors.h"

#import "UIDevice+SystemVersion.h"



@implementation UIColor (WikitudeColors)

+ (UIColor *)wikitudeColor
{
    return [UIColor colorWithRed:1.0f green:0.50f blue:0.14f alpha:1.0f];
}

+ (UIColor *)recentURLsInputAccessoryViewColor
{
    if ( [UIDevice isRunningiOS:kWTiOSVersion_8] ) {
        return [UIColor colorWithRed:0.76f green:0.78f blue:0.80f alpha:1.0f];
    }
    else
    {
        return [UIColor colorWithRed:0.82f green:0.84f blue:0.86f alpha:1.0f];
    }
}

@end
