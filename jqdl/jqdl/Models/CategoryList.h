//
//  CategoryList.h
//  jqdl
//
//  Created by Stephen Chin on 15/11/26.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "JSONModel.h"
#import "SiteInfo.h"

@interface CategoryList : JSONModel

@property (nonatomic, strong) NSString<Optional> *id; //主键 <非空>
@property (nonatomic, strong) SiteInfo<Optional> *site; //站点
@property (nonatomic, strong) NSString<Optional> *name; //栏目名称
@property (nonatomic, strong) NSString<Optional> *urlCode;//code
@property (nonatomic, strong) NSString<Optional> *voice;//音频
@property (nonatomic, strong) NSNumber<Optional> *lon;//经度
@property (nonatomic, strong) NSNumber<Optional> *lat;//维度
@property (nonatomic, strong) NSString<Optional> *locationAddr; //地址定位
@property (nonatomic, strong) NSString<Optional> *type; //类型（1，景点，2攻略，3，景区特色，）
@property (nonatomic, strong) NSString<Optional> *image; //栏目图片
@property (nonatomic, strong) NSString<Optional> *href; //连接地址
@property (nonatomic, strong) NSString<Optional> *description; //描述（用于检索）
@property (nonatomic, strong) NSString<Optional> *keywords; //关键字（用于检索）

@end
