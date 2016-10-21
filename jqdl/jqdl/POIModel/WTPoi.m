//
//  WTPoi.m
//  WTSimpleARBrowserExample
//
//  Created by Andreas Schacherbauer on 1/23/12.
//  Copyright (c) 2012 Wikitude GmbH. All rights reserved.
//

#import "WTPoi.h"

#import <CoreLocation/CoreLocation.h>



@implementation WTPoi


+ (WTPoi *)poiWithIdentifier:(NSInteger)identifier location:(CLLocation *)location name:(NSString *)name detailedDescription:(NSString *)detailedDescription
{
    WTPoi *poi = nil;
    
    if ( identifier
         &&
         location
         &&
         name
         &&
         detailedDescription
        )
    {
        poi = [[WTPoi alloc] initWithIdentifier:identifier location:location name:name detailedDescription:detailedDescription];
    }
    
    return poi;
}

- (instancetype)initWithIdentifier:(NSInteger)identifier location:(CLLocation *)location name:(NSString *)name detailedDescription:(NSString *)detailedDescription
{
    self = [super init];
    if (self)
    {
        _identifier = identifier;
        _location = location;
        _name = name;
        _detailedDescription = detailedDescription;
    }
    
    return self;
}



- (NSDictionary*)jsonRepresentation
{
    NSArray *poiObjects = @[@(self.identifier),
                            @(self.location.coordinate.latitude),
                            @(self.location.coordinate.longitude),
                            @(self.location.altitude),
                            self.name,
                            self.detailedDescription];
    
    NSArray *poiKeys = @[@"id",
                         @"latitude",
                         @"longitude",
                         @"altitude",
                         @"name",
                         @"description"];

    NSDictionary *jsonRepresentation = [NSDictionary dictionaryWithObjects:poiObjects forKeys:poiKeys];

    return jsonRepresentation;
}

@end
