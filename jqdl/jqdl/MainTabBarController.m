//
//  MainTabBarController.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/17.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "MainTabBarController.h"
#import "MapViewController.h"
#import "GonglueViewController.h"
#import "AboutViewController.h"
#import "ViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.superview.backgroundColor = [UIColor whiteColor];

//    self.delegate = self;
//    //去除阴影线
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
//    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
//    //添加中间按钮
//    [self addCenterButtonWithImage:[UIImage imageNamed:@"mainFrame_camera"] highlightImage:[UIImage imageNamed:@"mainFrame_camera"]];
    
    UIImage *img1 = [UIImage imageNamed:@"dl_normal"];
    UIImage *img1_h = [UIImage imageNamed:@"dl_highlight"];
    
    UIImage *img2 = [UIImage imageNamed:@"gl_normal"];
    UIImage *img2_h = [UIImage imageNamed:@"gl_highlight"];
    
    UIImage *img3 = [UIImage imageNamed:@"about_normal"];
    UIImage *img3_h = [UIImage imageNamed:@"about_highlight"];
    
//    MapViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    ViewController *vc1 = [ViewController new];
    vc1.title = @"导览";
    GonglueViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"GonglueViewController"];
    vc2.title = @"攻略";
    AboutViewController *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
    vc3.title = @"关于";
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
        img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        img1_h = [img1_h imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        img2 = [img2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        img2_h = [img2_h imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        img3 = [img3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        img3_h = [img3_h imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"导览" image:img1 selectedImage:img1_h];
        [item1 setTag:0];
        vc1.tabBarItem = item1;
        
        UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"攻略" image:img2 selectedImage:img2_h];
        [item2 setTag:1];
        vc2.tabBarItem = item2;
        
        UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"关于" image:img3 selectedImage:img3_h];
        [item3 setTag:2];
        vc3.tabBarItem = item3;
    }else{
        UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"导览" image:img1 tag:0];
        vc1.tabBarItem = item1;
        
        UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"攻略" image:img2 tag:1];
        vc2.tabBarItem = item2;
        
        UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"关于" image:img3 tag:2];
        vc3.tabBarItem = item3;
    }
    

    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    //    把导航控制器加入到数组
    NSMutableArray *viewArr_ = [NSMutableArray arrayWithObjects:nc1,nc2,nc3, nil];
    
    self.viewControllers = viewArr_;
    self.selectedIndex = 0;
    
    
    [self.tabBar setTintColor:RGB(38, 203, 216)];
    
    
    // 字体颜色 选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0F], NSForegroundColorAttributeName:RGB(38, 203, 216)} forState:UIControlStateSelected];
    
    // 字体颜色 未选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0F],  NSForegroundColorAttributeName:RGB(102, 102, 102)} forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - UITabBarControllerDelegate
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
////    //中间tabBarItem按钮禁用点击
////    if(viewController.tabBarItem.tag == 2){
////        return NO;
////    }else{
////        return YES;
////    }
//    return YES;
//}
//
//#pragma mark - myaction
//
//// Create a custom UIButton and add it to the center of our tab bar
//-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
//{
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
////    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    [button addTarget:self action:@selector(doAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    CGPoint center = self.tabBar.center;
//    center.y = (self.tabBar.frame.size.height-buttonImage.size.height)*0.5+buttonImage.size.height*0.5-5;
//    button.center = center;
//    [self.tabBar addSubview:button];
//}
////中间按钮点击事件
//-(void)doAction{
//    DLog(@"doAction");
//}

@end
