//
//  FeatureViewController.h
//  jqdl
//
//  Created by Stephen Chin on 15/11/23.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryList.h"

@interface FeatureViewController : UIViewController<UIWebViewDelegate>{
    UIWebView *jieshaoWebView;
}

@property (nonatomic, strong) CategoryList *categoryList;
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollview;
@property (weak, nonatomic) IBOutlet UIImageView *jingdianImage;
@property (weak, nonatomic) IBOutlet UILabel *jingdianTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;

@end
