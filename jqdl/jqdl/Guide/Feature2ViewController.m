//
//  Feature2ViewController.m
//  jqdl
//
//  Created by Stephen Chin on 15/12/14.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "Feature2ViewController.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"

@interface Feature2ViewController ()

@end

@implementation Feature2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        //        self.edgesForExtendedLayout = UIRectEdgeNone;
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
    
    _mywebview.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    [_mywebview.scrollView.mj_header beginRefreshing];
    
    
    DLog(@"%@%@%@",kHost,API_VIEW,self.url);
}

-(void)loadData{
    [self.mywebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",kHost,API_VIEW,self.url]]]];
    [_mywebview.scrollView.mj_header endRefreshing];
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
