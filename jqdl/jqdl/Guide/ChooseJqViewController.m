//
//  ChooseJqViewController.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/25.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "ChooseJqViewController.h"
#import "MJRefresh.h"
#import "Data.h"
#import "CategoryList.h"

@implementation ChooseJqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择景区";
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    
    [self.mytableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.mytableview setTableFooterView:v];
    
    // 下拉刷新
    _mytableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    [self loadData];
}

-(void)loadData{
    NSDictionary *parameters = @{@"type":@"1"};
    [[Client defaultNetClient] POST:API_CATEGORY_LIST param:parameters JSONModelClass:[Data class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"JSONModel: %@", responseObject);
        Data *res = (Data *)responseObject;
        if (res.resultcode == ResultCodeSuccess) {
            
            if (dataSource==nil) {
                dataSource = [NSMutableArray new];
            }else{
                [dataSource removeAllObjects];
            }
            
            NSError *error;
            NSArray *arr = (NSArray*)res.result;
            for (NSDictionary *dic in arr) {
                error = nil;
                CategoryList *categoryList = [[CategoryList alloc] initWithDictionary:dic error:&error];
                DLog(@"%@",categoryList);
                if (error) {
                    DLog(@"%@",error.userInfo);
                    continue;
                }
                [dataSource addObject:categoryList];
            }
            [_mytableview reloadData];
            [_mytableview.mj_header endRefreshing];
        }else {
            DLog(@"%@",res.reason);
            [_mytableview.mj_header endRefreshing];
            [self showHint:res.reason];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error: %@", error);
        [_mytableview.mj_header endRefreshing];
        [self showHint:@"获取失败，请重试!"];
        return;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    CategoryList *info = [dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = info.name;
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:17]];
    
    if (_categoryListId != nil &&  [_categoryListId isEqualToString:info.id]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellStyleDefault;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    CategoryList *info = [dataSource objectAtIndex:indexPath.row];
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:info,@"obj",[NSNumber numberWithBool:YES],@"SHOWFLAG", nil];
    NSNotification *notification =[NSNotification notificationWithName:@"chooseJq" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
