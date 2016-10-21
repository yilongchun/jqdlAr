//
//  WTPoiManager.m
//  WTSimpleARBrowserExample
//
//  Created by Andreas Schacherbauer on 1/23/12.
//  Copyright (c) 2012 Wikitude GmbH. All rights reserved.
//

#import "WTPoiManager.h"
#import "WTPoi.h"

@implementation WTPoiManager

- (id)init
{
    self = [super init];
    if (self) {
        self.pois = [NSMutableArray arrayWithCapacity:20];
    }
    
    return self;
}


- (void)addPoi:(WTPoi *)poiObject
{
    if (poiObject) {
        [self.pois addObject:poiObject];
    }
}

- (WTPoi *)poiForId:(NSInteger)aPoiId
{
    WTPoi *poi = nil;
    
    for (WTPoi *currentPoi in self.pois) {
        if (currentPoi.identifier == aPoiId) {
            poi = currentPoi;
        }
    }
    
    return poi;
}

- (void)removeAllPois
{
    [self.pois removeAllObjects];
}

#pragma mark - == Helper ==
// convert our poi model to a JSON representation string
- (NSString *)convertPoiModelToJson
{
    NSMutableArray *jsonModelRepresentation = [NSMutableArray arrayWithCapacity:self.pois.count];
    
    for (WTPoi *poi in self.pois) {
        [jsonModelRepresentation addObject:[poi jsonRepresentation]];
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonModelRepresentation options:kNilOptions error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
