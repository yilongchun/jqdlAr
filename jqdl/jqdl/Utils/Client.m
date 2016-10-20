//
//  Client.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/26.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "Client.h"

@implementation Client

+ (NSString *)baseUrl
{
    //返回你的baseUrl
    return kHost;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        //增加返回的content type类型，适合用个人开发者的简易服务器
        //        [self addresponseSerializerContentTypes:@"text/html"];
        //打开日志
        [self setLogger:YES];
//        if (self.sessionKey==nil) {
//            self.sessionKey = @"";
//        }
//        if (self.sessionUid==nil) {
//            self.sessionUid = @"";
//        }
        
    }
    
    return self;
}

@end
