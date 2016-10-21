//
//  NSURL+ParameterQuery.m
//  SDKExamples
//
//  Created by Andreas Schacherbauer on 25/09/14.
//  Copyright (c) 2014 Wikitude. All rights reserved.
//

#import "NSURL+ParameterQuery.h"

@implementation NSURL (ParameterQuery)

- (NSDictionary *)URLParameter
{
    NSMutableDictionary *urlParameters = nil;
    NSString *urlString = [self absoluteString];
    
    NSRange optionsRange = [urlString rangeOfString:@"?"];
    if (optionsRange.location != NSNotFound) {
        urlString = [urlString substringFromIndex:optionsRange.location+1 ];
        
        urlParameters = [NSMutableDictionary dictionary];
        NSArray *pairs = [urlString componentsSeparatedByString:@"&"];
        if (pairs.count > 0) {
            for (NSString *pair in pairs) {
                NSArray *componentPair = [pair componentsSeparatedByString:@"="];
                NSString *key = [[componentPair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
                NSString *value = [[componentPair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
                
                [urlParameters setObject:value forKey:key];
            }
        }
    }
    
    return urlParameters;
}

@end
