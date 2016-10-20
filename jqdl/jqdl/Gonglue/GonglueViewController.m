//
//  GonglueViewController.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/24.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "GonglueViewController.h"
#import "URBSegmentedControl.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"

@interface GonglueViewController ()

@property(nonatomic, strong) UIView *view1;
@property(nonatomic, strong) UIView *view2;

@end

@implementation GonglueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //修改导航栏标题字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor] , NSFontAttributeName : [UIFont boldSystemFontOfSize:19]};
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
                self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    
    
    _mywebview.backgroundColor=[UIColor clearColor];
//    for (UIView *_aView in [_mywebview subviews])
//    {
//        if ([_aView isKindOfClass:[UIScrollView class]])
//        {
//            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条
//            
//            for (UIView *_inScrollview in _aView.subviews)
//            {
//                
//                if ([_inScrollview isKindOfClass:[UIImageView class]])
//                {
//                    _inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
//                }
//            }
//        } 
//    }
    
    
    
    
//    [self.mywebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHost,API_GONGLUE]]]];

    
    _mywebview.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    [_mywebview.scrollView.mj_header beginRefreshing];
//    //添加顶部选项卡
//    [[URBSegmentedControl appearance] setSegmentBackgroundColor:[UIColor whiteColor]];
//    NSArray *titles = [NSArray arrayWithObjects:[@"详情" uppercaseString], [@"餐饮" uppercaseString], [@"住宿" uppercaseString], @"娱乐", @"线路", nil];
//    URBSegmentedControl *control = [[URBSegmentedControl alloc] initWithItems:titles];
//    control.frame = CGRectMake(10.0, 64 + 10.0,App_Frame_Width - 20, 40.0);
//    control.segmentBackgroundColor = RGB(38, 203, 216);
//    [self.view addSubview:control];
//    control.baseColor = [UIColor whiteColor];//；内圈背景颜色
////    control.baseGradient = [UIColor redColor];
//    control.strokeColor = [UIColor whiteColor];//外圈边框颜色
////    control.imageColor = [UIColor redColor];
//    [control addTarget:self action:@selector(handleSelection:) forControlEvents:UIControlEventValueChanged];
//    [control setControlEventBlock:^(NSInteger index, URBSegmentedControl *segmentedControl) {
//        NSLog(@"URBSegmentedControl: control block - index=%li", (long)index);
//    
//        
//    }];
}

-(void)loadData{
    [self.mywebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHost,API_GONGLUE]]]];
    [_mywebview.scrollView.mj_header endRefreshing];
}

- (void)handleSelection:(id)sender {
    NSLog(@"URBSegmentedControl: value changed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
