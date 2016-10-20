//
//  ChooseJqViewController.h
//  jqdl
//
//  Created by Stephen Chin on 15/11/25.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseJqViewController : UIViewController{
    NSMutableArray *dataSource;
}
@property (nonatomic, strong) NSString *categoryListId;
@property (strong, nonatomic) IBOutlet UITableView *mytableview;

@end
