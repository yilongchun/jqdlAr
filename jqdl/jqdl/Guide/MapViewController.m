//
//  MapViewController.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/18.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "MapViewController.h"
#import "FeatureViewController.h"
#import "ChooseJqViewController.h"
#import "LBXScanViewController.h"
#import "Data.h"
#import "CategoryList.h"
#import "Feature2ViewController.h"


@interface MapViewController (){
    NSString *firsetParams;
    
    
    ChooseJqViewController *jqvc;
    
}

@property (nonatomic, strong) UIButton *locationBtn;


@end
@implementation MapViewController
//用于控制定位
BOOL locationFlag;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //修改导航栏标题字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor] , NSFontAttributeName : [UIFont boldSystemFontOfSize:19]};
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftItemMenu"] style:UIBarButtonItemStyleDone target:self action:@selector(saoyisao)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"rightItemMenu"] style:UIBarButtonItemStyleDone target:self action:@selector(chooseJq)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    locationFlag = NO;
    
    //导航条底部添加蓝色背景图 用来控制导航条隐藏和显示的切换
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    imageview.image = [UIImage imageNamed:@"nav_bg"];
    [self.view addSubview:imageview];
    
    //选择景区
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseJq:) name:@"chooseJq" object:nil];
    //景点详情
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showJdDetail:) name:@"showJdDetail" object:nil];
    
    //加载数据
    [self loadJqList];
}


#pragma mark - private

//扫一扫
-(void)saoyisao{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    style.colorAngle = [UIColor colorWithRed:38./255 green:203./255. blue:216./255. alpha:1.0];
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    style.animationImage = imgLine;
    
    LBXScanViewController *vc = [LBXScanViewController new];
    vc.style = style;
    vc.isQQSimulator = YES;
    vc.title = @"扫描二维码";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    LBXScanViewController *vc = [LBXScanViewController new];
    vc.style = style;
    vc.title = @"扫描二维码";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


//进入景区列表选择
-(void)chooseJq{
    if (jqvc == nil) {
        jqvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseJqViewController"];
        jqvc.hidesBottomBarWhenPushed = YES;
        
    }
    jqvc.categoryListId = categoryList.id;
    [self.navigationController pushViewController:jqvc animated:YES];
    
}

//选择景区完成
- (void)chooseJq:(NSNotification *)text{
    
    
    
    if ([text.userInfo[@"obj"] isKindOfClass:[CategoryList class]]) {
        categoryList = (CategoryList *)text.userInfo[@"obj"];
        firsetParams = categoryList.urlCode;
        NSNumber *flag = text.userInfo[@"SHOWFLAG"];
        
        
        [self loadJingdian:categoryList.id showHud:[flag boolValue]];

    }
}

//加载景点列表
-(void)loadJingdian:(NSString *)ids showHud:(BOOL)flag{
    if (flag) {
        [self showHudInView:self.view hint:@"加载中"];
    }
    
    NSDictionary *parameters = @{@"parentId":ids};
    [[Client defaultNetClient] POST:API_JINGDIAN_LIST param:parameters JSONModelClass:[Data class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSONModel: %@", responseObject);
        Data *res = (Data *)responseObject;
        if (res.resultcode == ResultCodeSuccess) {
            
            if (jingdianDataSource==nil) {
                jingdianDataSource = [NSMutableArray new];
            }else{
                [jingdianDataSource removeAllObjects];
            }
            
            
            NSError *error;
            NSArray *arr = (NSArray*)res.result;
            NSMutableArray *annotations = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                error = nil;
                CategoryList *jingdianList = [[CategoryList alloc] initWithDictionary:dic error:&error];
                DLog(@"%@\t%f\t%f",jingdianList.name,[jingdianList.lon floatValue],[jingdianList.lat floatValue]);
                if (error) {
                    DLog(@"%@",error.userInfo);
                    continue;
                }
                if ([jingdianList.lat floatValue] != 0 && [jingdianList.lon floatValue] != 0) {
                    [jingdianDataSource addObject:jingdianList];
                    
                }
                
                
            }
            if ([annotations count] != 0) {
                
            }
            [self hideHud];
        }else {
            DLog(@"%@",res.reason);
            [self hideHud];
            [self showHint:res.reason];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        [self hideHud];
        [self showHint:@"获取失败，请重试!"];
        return;
    }];
}

//跳转景点介绍
- (void)showJdDetail:(NSNotification *)text{
//    if ([text.userInfo[@"obj"] isKindOfClass:[CustomAnnotationView class]]) {
//        
//        
//        CustomAnnotationView *anno = (CustomAnnotationView *)text.userInfo[@"obj"];
////        FeatureViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FeatureViewController"];
////        vc.hidesBottomBarWhenPushed = YES;
////        vc.categoryList = anno.categoryList;
//        
//        Feature2ViewController *vc = [[Feature2ViewController alloc] init];
//        vc.title = anno.categoryList.name;
//        NSString *secondParams = anno.categoryList.urlCode;
//        vc.url = [NSString stringWithFormat:@"view-%@-",secondParams];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

//加载景区列表 读取第一个默认加载
-(void)loadJqList{
    [self showHudInView:self.view hint:@"加载中"];
    
    NSDictionary *parameters = @{@"type":@"1"};
    [[Client defaultNetClient] POST:API_CATEGORY_LIST param:parameters JSONModelClass:[Data class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"JSONModel: %@", responseObject);
        Data *res = (Data *)responseObject;
        if (res.resultcode == ResultCodeSuccess) {
            
            NSError *error;
            NSArray *arr = (NSArray*)res.result;
            
            if ([arr count] > 0) {
                error = nil;
                categoryList = [[CategoryList alloc] initWithDictionary:[arr objectAtIndex:0] error:&error];
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:categoryList,@"obj",[NSNumber numberWithBool:NO],@"SHOWFLAG", nil];
                NSNotification *notification =[NSNotification notificationWithName:@"chooseJq" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }else{
                [self hideHud];
                [self showHint:@"暂无景区数据"];
            }
        }else {
            DLog(@"%@",res.reason);
            [self hideHud];
            [self showHint:res.reason];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        [self hideHud];
        [self showHint:@"获取失败!"];
        return;
    }];
}

@end
