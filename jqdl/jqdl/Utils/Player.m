//
//  Player.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/27.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "Player.h"


static Player *__helper = nil;

@implementation Player

+(instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __helper = [[super alloc]init];
        __helper.onFailure=^(FSAudioStreamError error,NSString *description){
            NSLog(@"播放过程中发生错误，错误信息：%@",description);
        };
        __helper.onCompletion=^(){
            NSLog(@"播放完成!");
        };
    });
    return __helper;
}


@end
