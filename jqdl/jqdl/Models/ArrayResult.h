//
//  ArrayResult.h
//  ImageBasedChat
//
//  Created by Chris on 14/12/23.
//  Copyright (c) 2014年 Zoimedia. All rights reserved.
//

#import "JSONModel.h"

@interface ArrayResult : JSONModel
@property (nonatomic, assign) int resultcode;// 结果编码
@property (nonatomic, strong) NSString<Optional> *reason;// 操作消息
@property (nonatomic, strong) NSArray<Optional> *result;// 结果对象
@end
