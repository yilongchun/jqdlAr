//
//  Player.h
//  jqdl
//
//  Created by Stephen Chin on 15/11/27.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSAudioStream.h"

@interface Player : FSAudioStream

+(instancetype)sharedManager;

@end
