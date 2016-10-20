//
//  Data.h
//  FlashChat
//
//  Created by user on 13-9-26.
//  Copyright (c) 2013年 DaoDao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Data : JSONModel
@property (nonatomic, assign) int resultcode;// 结果编码
@property (nonatomic, strong) NSString *reason;// 操作消息
@property (nonatomic, strong) NSObject<Optional> *result;// 结果对象


@end
