//
//  MapViewController.h
//  jqdl
//
//  Created by Stephen Chin on 15/11/18.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryList.h"

@interface MapViewController : UIViewController{
    NSMutableArray *jingdianDataSource;
    CategoryList *categoryList;//景区
}


@end
