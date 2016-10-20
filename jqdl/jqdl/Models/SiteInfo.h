//
//  SiteInfo.h
//  jqdl
//
//  Created by Stephen Chin on 15/11/26.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "JSONModel.h"

@interface SiteInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> *id; //主键 <非空>
@property (nonatomic, strong) NSString<Optional> *urlId;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *logo;
@property (nonatomic, strong) NSString<Optional> *keywords;
@property (nonatomic, strong) NSString<Optional> *description;

@end
