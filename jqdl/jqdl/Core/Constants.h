//
//  Constants.h
//  impi
//
//  Created by Chris on 15/3/21.
//  Copyright (c) 2015年 Zoimedia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ResultCodeType){
    ResultCodeSuccess = 200,//操作成功
    ResultCodeFileTooLarge = 201,//上传文件超过大小
    ResultCodeInvalidParam = 202,//参数错误
    ResultCodeNoData = 203,//查询不到结果
    ResultCodeFail = 502//操作失败
};

//高德地图API_KEY
//const static NSString *GAODE_APIKey = @"3623137f302cb22fa65c6860f51246f7";
//狮子关
//const static NSString *GAODE_APIKey = @"c65b82dabcec916a69f8f17e966a4630";

#define kHost @"http://g.ticket168.com/"

/**
 *  西陵峡
 */
//#define kHost @"http://192.168.10.30:8080/"
////#define kHost @"http://www.wxin168.com:8082/"//可以去掉了

//手绘地图
//#define MAP_NAME @"xilingxia"
//手绘地图经纬度
//#define OVERLAY1_X 30.774615
//#define OVERLAY1_Y 111.258972
//#define OVERLAY2_X 30.760523
//#define OVERLAY2_Y 111.279458
////景区列表
//#define API_CATEGORY_LIST @"X002/category/list.c"
////景点列表
//#define API_JINGDIAN_LIST @"X002/category/childList.c"
////景点介绍
//#define API_JINGDIAN_DETAIL @"X002/article/list.c"
////景点详情
//#define API_VIEW @"X002/"
////攻略
//#define API_GONGLUE @"X002/category/lists?type=3"
////意见反馈
//#define API_FEEDBACK @"X002/feedBack/save.c"

/**
 *  狮子关
 */
//手绘地图
#define MAP_NAME @"szg"
//手绘地图经纬度
#define OVERLAY1_Y 109.559000
#define OVERLAY1_X 29.975000
#define OVERLAY2_Y 109.565000
#define OVERLAY2_X 29.971000
//景区列表
#define API_CATEGORY_LIST @"X001/category/list.c"
//景点列表
#define API_JINGDIAN_LIST @"X001/category/childList.c"
//景点介绍
#define API_JINGDIAN_DETAIL @"X001/article/list.c"
//景点详情
#define API_VIEW @"X001/"
//攻略
#define API_GONGLUE @"X001/category/lists?type=3"
//意见反馈
#define API_FEEDBACK @"X001/feedBack/save.c"




#define NAVIGATION_BAR_COLOR RGB(52,170,235)
#define BACKGROUND_COLOR RGB(235,235,235)

@interface Constants : NSObject


@end
