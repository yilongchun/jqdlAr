//
//  AboutMeViewController.m
//  jqdl
//
//  Created by Stephen Chin on 15/12/1.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UILabel *versionLabel;
@property (strong, nonatomic) UILabel *rightsOneLabel;
@property (strong, nonatomic) UILabel *rightsTwoLabel;

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"关于我们";
    
    [_mytableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    NSString *jieshao = @"        狮子关为宣恩三大古雄关之一，此地山势雄伟，有大小岩山五座，山形状似狮子，扼守县城东南要口，古称“五狮镇关”，因而得名狮子关。景区内因喀斯特地貌形成的自然山水资源极为丰富，整体由三段峡谷围合而成，全长约9.6公里，是罕见的峡谷环线结构，峡谷内洞穴、象形石、瀑布等景点遍布其中，景区内的古迹河水电站建筑既有土家民居之风，又有自然生态之韵，建筑与山水相得益彰，景区内的原始猕猴群，经过多年的保护和喂养，俨然成为猕猴活动的天堂，上百只猕猴栖居跳跃，与人和谐共生。\n        宣恩县土家族八宝铜铃舞第20代传人、恩施州民间艺术大师、湖北省非物质文化遗产项目代表性传承人81岁高龄的田宗堂先生世居宣恩，在狮子关景区内设立了八宝铜铃舞非物质文化遗产传承基地，开设学堂，将这一非遗文化发扬光大。\n        原汁原味的狮子关景区，在“十里画廊、百尺飞瀑、千年绝壁”之间，设有多种旅游线路，电瓶车、自行车、徒步游任意选择。";
    
    UILabel *jieshaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, Main_Screen_Width-30, 0)];
    jieshaoLabel.text = jieshao;
    jieshaoLabel.font = [UIFont systemFontOfSize:15.0f];
    jieshaoLabel.numberOfLines = 0;
    jieshaoLabel.textColor = [UIColor darkGrayColor];
    
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:jieshao];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:3];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [jieshao length])];
    [jieshaoLabel setAttributedText:attributedString1];
    
    [_mytableview addSubview:jieshaoLabel];
    [jieshaoLabel sizeToFit];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(jieshaoLabel.frame) + 20, 0, 21)];
    label1.text = @"景区服务电话：";
    label1.font = [UIFont systemFontOfSize:15.0f];
    label1.textColor = [UIColor darkGrayColor];
    [_mytableview addSubview:label1];
    [label1 sizeToFit];
    
    UILabel *phone1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 8, label1.frame.origin.y, 0, 21)];
    phone1.text = @"0718-5840999";
    phone1.font = [UIFont systemFontOfSize:15.0f];
    phone1.textColor = [UIColor blueColor];
    phone1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tel1)];
    [phone1 addGestureRecognizer:tap1];
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",phone1.text]];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    phone1.attributedText = content;
    [_mytableview addSubview:phone1];
    [phone1 sizeToFit];
    
    
    
    UILabel *phone2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 8, CGRectGetMaxY(phone1.frame) + 8, 0, 21)];
    phone2.text = @"13687194160";
    phone2.font = [UIFont systemFontOfSize:15.0f];
    phone2.textColor = [UIColor blueColor];
    phone2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tel2)];
    [phone2 addGestureRecognizer:tap2];
    
    NSMutableAttributedString *content2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",phone2.text]];
    NSRange contentRange2 = {0,[content2 length]};
    [content2 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange2];
    phone2.attributedText = content2;
    
    [_mytableview addSubview:phone2];
    [phone2 sizeToFit];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(phone2.frame) + 8, Main_Screen_Width - 30, 0)];
    addressLabel.text = @"地址：湖北省恩施土家族苗族自治州宣恩县狮子关风景区";
    addressLabel.font = [UIFont systemFontOfSize:15.0f];
    addressLabel.numberOfLines = 0;
    addressLabel.textColor = [UIColor darkGrayColor];
    [_mytableview addSubview:addressLabel];
    [addressLabel sizeToFit];
    
    
    
    
    NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width/2 - 50, CGRectGetMaxY(addressLabel.frame) + 30, 100, 100)];
    [_logoImageView setImage:[UIImage imageNamed:@"1024X1024"]];
    _logoImageView.layer.cornerRadius = 10;
    _logoImageView.layer.masksToBounds = YES;
    [_mytableview addSubview:_logoImageView];
    
    _versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_logoImageView.frame) +  8, Main_Screen_Width, 21)];
    _versionLabel.text = [NSString stringWithFormat:@"%@ V%@",[infoDict objectForKey:@"CFBundleDisplayName"] ,version];
    _versionLabel.font = [UIFont systemFontOfSize:14.0f];
    _versionLabel.textColor = [UIColor darkGrayColor];
    _versionLabel.textAlignment = NSTextAlignmentCenter;
    NSLog(@"_versionLabel frame:%@",NSStringFromCGRect(_versionLabel.frame));
    [_mytableview addSubview:_versionLabel];
    
    _rightsOneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_versionLabel.frame) + 6, Main_Screen_Width, 21)];
    _rightsOneLabel.font = [UIFont systemFontOfSize:11.f];
    _rightsOneLabel.textColor = [UIColor lightGrayColor];
    _rightsOneLabel.text = @"中亿百纳 版权所有";
    _rightsOneLabel.textAlignment = NSTextAlignmentCenter;
    [_mytableview addSubview:_rightsOneLabel];
    
    _rightsTwoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_rightsOneLabel.frame)+6, Main_Screen_Width, 21)];
    _rightsTwoLabel.font = [UIFont systemFontOfSize:11.f];
    _rightsTwoLabel.textColor = [UIColor lightGrayColor];
    _rightsTwoLabel.text = @"Copyright ©2014-2015 Zoi.All Rights Reserved.";
    _rightsTwoLabel.textAlignment = NSTextAlignmentCenter;
    [_mytableview addSubview:_rightsTwoLabel];
    
    
    
}

-(void)tel1{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"0718-5840999" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:07185840999"]];
    }];
    [alertController addAction:cancel];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)tel2{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"13687194160" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:13687194160"]];
    }];
    [alertController addAction:cancel];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return CGRectGetMaxY(_rightsTwoLabel.frame) + 10;
    }
    return 44;
}

#pragma mark - Setup Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.row)
    {
        case 0:
            cell.hidden = YES;
            //        case 1:
            //            [cell.imageView setImage:[UIImage imageNamed:@"myProfile_setting_about_icon_tips"]];
            //            cell.textLabel.text = @"使用小技巧";
            break;
        case 1:
            [cell.imageView setImage:[UIImage imageNamed:@"myProfile_setting_about_icon_agreement"]];
            cell.textLabel.text = @"服务条款";
            break;
        case 2:
            [cell.imageView setImage:[UIImage imageNamed:@"myProfile_setting_about_icon_weibo"]];
            cell.textLabel.text = @"官方微博";
            cell.detailTextLabel.text = @"微博号：图拍APP";
            break;
        case 3:
            [cell.imageView setImage:[UIImage imageNamed:@"myProfile_setting_about_icon_weixin"]];
            cell.textLabel.text = @"官方微信";
            cell.detailTextLabel.text = @"微信号：tupai0717";
            break;
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
        case 1:{
            
        }
            break;
        case 2:
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/impi"]];
            break;
        case 3:
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weixin.qq.com/r/NkgwKIPEx964rcdL9x0k"]];
            break;
        default:
            break;
    }
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
