//
//  WTPoiManager.h
//  WTSimpleARBrowserExample
//
//  Created by Andreas Schacherbauer on 1/23/12.
//  Copyright (c) 2012 Wikitude GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTPoi;
@interface WTPoiManager : NSObject

@property (nonatomic, strong) NSMutableArray                *pois;

- (void)addPoi:(WTPoi *)poiObject;

- (WTPoi *)poiForId:(NSInteger)aPoiId;

- (void)removeAllPois;

- (NSString *)convertPoiModelToJson;

@end
