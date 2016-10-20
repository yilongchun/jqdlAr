//
//  AboutViewController.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/24.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "AboutViewController.h"
#import "Util.h"
#import "YjfkViewController.h"
#import "AboutMeViewController.h"

@interface AboutViewController (){
    UIActivityIndicatorView *indicatorView;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于";
    
    //修改导航栏标题字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor] , NSFontAttributeName : [UIFont boldSystemFontOfSize:19]};
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        //        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    
//    [self.mytableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.mytableview setTableFooterView:v];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 10;
//    }
//    return 5;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 5;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
//    if (indexPath.row == 0) {
//        cell.textLabel.text = @"鼓励我们";
//    }else if (indexPath.row == 1){
//        cell.textLabel.text = @"意见反馈";
//    }else if (indexPath.row == 2){
//        cell.textLabel.text = @"清除缓存";
//    }else if (indexPath.row == 3){
//        cell.textLabel.text = @"关于我们";
//    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"意见反馈";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"关于我们";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        
//        NSString *string = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/hui-min-jia-yuan-tong-jiao/id%@?mt=8&uo=4",@"957244616"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
//        
////        [self showStoreProductInApp:@"957244616"];
//    }
//    if (indexPath.row == 1) {
//        YjfkViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"YjfkViewController"];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if (indexPath.row == 2) {
//        [self clearCache];
//    }
//    if (indexPath.row == 3) {
//        AboutMeViewController *vc = [[AboutMeViewController alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
    if (indexPath.row == 0) {
        YjfkViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"YjfkViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        AboutMeViewController *vc = [[AboutMeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - private
//清理缓存提示
-(void)clearCache{
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    float folderSize = [Util folderSizeAtPath:cachePath];
    
    NSString *msg = [NSString stringWithFormat:@"缓存大小为%.2fM.确定要清理缓存吗?",folderSize];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        [self showHudInView:self.view hint:@"清除中..."];
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //           [Util deleteAllCache];
            [Util removeCache];
            [self hideHud];
            [self showHint:@"清理完成！"];
        });
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

////查看app商店信息
//- (void)showStoreProductInApp:(NSString *)appID{
//    Class isAllow = NSClassFromString(@"SKStoreProductViewController");
//    [self showIndicator];
//    if (isAllow != nil) {
//        SKStoreProductViewController *sKStoreProductViewController = [[SKStoreProductViewController alloc] init];
//        [sKStoreProductViewController.view setFrame:CGRectMake(0, 200, 320, 200)];
//        [sKStoreProductViewController setDelegate:self];
//        [sKStoreProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier: appID}
//                                                completionBlock:^(BOOL result, NSError *error) {
//                                                    if (result) {
//                                                        [self hideIndicator];
//                                                        
//                                                        [self presentViewController:sKStoreProductViewController
//                                                                           animated:YES
//                                                                         completion:nil];
//                                                        
//                                                        
//                                                    }else{
//                                                        [self hideIndicator];
//                                                        NSString *des = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
//                                                        NSLog(@"error:%@",error);
//                                                        NSLog(@"%@",des);
//                                                    }
//                                                }];
//    }
//    //    else{
//    //        //低于iOS6的系统版本没有这个类,不支持这个功能
//    //        NSString *string = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/hui-min-jia-yuan-tong-jiao/id%@?mt=8&uo=4",appID];
//    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
//    //    }
//}

//- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
//{
//    if (viewController)
//    { [viewController dismissViewControllerAnimated:YES completion:nil]; }
//}
//
////加载等待视图
//- (void)showIndicator{
//    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicatorView.autoresizingMask =
//    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
//    | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    [self.view addSubview:indicatorView];
//    [indicatorView sizeToFit];
//    [indicatorView startAnimating];
//    indicatorView.center = self.view.center;
//}
//
//- (void)hideIndicator{
//    [indicatorView stopAnimating];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
