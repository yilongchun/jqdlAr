//
//  FeatureViewController.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/23.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "FeatureViewController.h"
#import "Data.h"
#import "CategoryList.h"

@interface FeatureViewController ()

@end

@implementation FeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        //        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    
//    self.view.backgroundColor = BACKGROUND_COLOR;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.title = @"景点介绍";
    self.jingdianTitle.text = self.categoryList.name;
    
    
    
    [self loadData];
}

//分享
-(void)share{
    NSString *textToShare = self.categoryList.name;
    UIImage *imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHost,self.categoryList.image]]]];
    NSURL *urlToShare = [NSURL URLWithString:@"wwww.xxxx.com"];
    NSMutableArray *activityItems =[NSMutableArray array];
    [activityItems addObject:textToShare];
    if (imageToShare != nil) {
        [activityItems addObject:imageToShare];
    }
    [activityItems addObject:urlToShare];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems  applicationActivities:nil];
    [self presentViewController:activityController  animated:YES completion:nil];
}

-(void)loadData{
    [self showHudInView:self.view];
    
    NSDictionary *parameters = @{@"categoryId":self.categoryList.id};
    [[Client defaultNetClient] POST:API_JINGDIAN_DETAIL param:parameters JSONModelClass:[Data class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSONModel: %@", responseObject);
        Data *res = (Data *)responseObject;
        if (res.resultcode == ResultCodeSuccess) {
            
            NSArray *arr = (NSArray*)res.result;
            
            if ([arr count] > 0) {
                NSDictionary *info = [arr objectAtIndex:0];
                
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHost,[info objectForKey:@"image"]]]]];
                
                DLog(@"%f %f",image.size.height,image.size.width);
                
                self.jingdianImage.image = image;
                
                
                
//                self.imageHeightConstraint.constant = (image.size.height / image.size.width) * Main_Screen_Width;
//                
//                DLog(@"%f %f",self.jingdianImage.frame.size.height,self.jingdianImage.frame.size.width);
                
                jieshaoWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.imageHeightConstraint.constant, self.view.frame.size.width, 1)];
                jieshaoWebView.delegate = self;
                [self.myscrollview addSubview:jieshaoWebView];
                [jieshaoWebView loadHTMLString:[NSString stringWithFormat:@"%@",[info objectForKey:@"description"]] baseURL:nil];
            }
            
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

-(void)viewDidLayoutSubviews
{
    [self.myscrollview setContentSize:CGSizeMake(self.view.frame.size.width, jieshaoWebView.frame.origin.y + jieshaoWebView.frame.size.height)];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    UIScrollView *tempView=(UIScrollView *)[jieshaoWebView.subviews objectAtIndex:0];
    tempView.scrollEnabled=NO;
    CGSize webSize = [webView sizeThatFits:CGSizeZero];
    DLog(@"webViewDidFinishLoad\t%f",webSize.height);
    [jieshaoWebView setFrame:CGRectMake(jieshaoWebView.frame.origin.x, jieshaoWebView.frame.origin.y, jieshaoWebView.frame.size.width, webSize.height)];
    [self hideHud];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = YES;
//    
//    //去除导航栏下方的横线
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
//    
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
