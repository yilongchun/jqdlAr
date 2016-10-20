//
//  FeedBack.h
//  FlashChat
//
//  Created by user on 13-4-2.
//  Copyright (c) 2013年 DaoDao. All rights reserved.
//

#import "JSONModel.h"

@interface FeedBack : JSONModel

@property (nonatomic, strong) NSString<Optional> *siteCode;//站点
@property (nonatomic, strong) NSString<Optional> *idea;//反馈
@property (nonatomic, strong) NSString<Optional> *createById;// 反馈人ID



@end
