//
//  YjfkViewController.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/25.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "YjfkViewController.h"
#import "Data.h"
#import "FeedBack.h"
#import "UITextView+PlaceHolder.h"

@interface YjfkViewController ()

@end

@implementation YjfkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        //        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    self.mytextview.layer.masksToBounds = YES;
    self.mytextview.layer.cornerRadius = 5.0f;
    self.mytextview.layer.borderColor = RGB(38, 203, 216).CGColor;
    self.mytextview.layer.borderWidth = 1.0f;
    [_mytextview addPlaceHolder:@"说出你的体验和宝贵的建议，可以帮助我们改进产品，以便更好的服务您和其他用户"];
    
    self.telTextField.layer.masksToBounds = YES;
    self.telTextField.layer.cornerRadius = 5.0f;
    self.telTextField.layer.borderColor = RGB(38, 203, 216).CGColor;
    self.telTextField.layer.borderWidth = 1.0f;
    
    //添加手势，点击输入框其他区域隐藏键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView =NO;
    [self.view addGestureRecognizer:tapGr];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"反馈" style:UIBarButtonItemStyleDone target:self action:@selector(feedback)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    NSString* phoneModel = [[UIDevice currentDevice] model];
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    [self.mytextview setText:[NSString stringWithFormat:@"设备: %@,系统: %@,应用名称：%@,客户端版本:%@,",phoneModel,phoneVersion,appCurName,appCurVersion]];

    
}

//隐藏键盘
-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [self.mytextview resignFirstResponder];
}

//反馈
-(void)feedback{
    DLog(@"");
    [self.mytextview resignFirstResponder];
    
    [self showHudInView:self.view];
    
    FeedBack *feedback = [[FeedBack alloc] init];
    feedback.siteCode = @"123";
    feedback.idea = [NSString stringWithFormat:@"%@ 联系电话:%@",self.mytextview.text,_telTextField.text];
    feedback.createById = @"";
    
    NSDictionary *params = @{@"param":[feedback toJSONString]};
    
    [[Client defaultNetClient] POST:API_FEEDBACK param:params JSONModelClass:[Data class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSONModel: %@", responseObject);
        Data *res = (Data *)responseObject;
        if (res.resultcode == ResultCodeSuccess) {
            
            [self hideHud];
            [self showHint:@"已反馈，感谢您的支持!"];
            
            double delayInSeconds = 1.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            DLog(@"%@",res.reason);
            [self hideHud];
            [self showHint:res.reason];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        [self hideHud];
        [self showHint:@"反馈失败,请重试!"];
        return;
    }];
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
