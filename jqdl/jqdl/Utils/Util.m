//
//  Util.m
//  jqdl
//
//  Created by Stephen Chin on 15/11/25.
//  Copyright © 2015年 Stephen Chin. All rights reserved.
//

#import "Util.h"

@implementation Util

+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        DLog(@"folderSizeAtPath 文件数 ：%lu",(unsigned long)[childerFiles count]);
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
//SDWebImage框架自身计算缓存的实现
//        folderSize+=[[SDImageCache sharedImageCache] getSize];
        return folderSize/(1024.0*1024.0);
    }
    return 0;
}

+(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
//    [[SDImageCache sharedImageCache] cleanDisk];
}

+(void)removeCache
{
    //===============清除缓存==============
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    DLog(@"%@",cachePath);
    
    float folderSize = [self folderSizeAtPath:cachePath];
    DLog(@"大小%f",folderSize);
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    DLog(@"removeCache 文件数 ：%lu",(unsigned long)[files count]);
    
    for (NSString *p in files)
    {
//        DLog(@"文件 ：%@",p);
        NSError *error;
        NSString *path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

//清空缓存
+(void)deleteAllCache{
//    NSString *extension1 = @"jpg";
//    NSString *extension2 = @"wav";
//    NSString *extension3 = @"amr";
//    NSString *extension4 = @"mp3";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        DLog(@"%@",filename);
//        if ([filename rangeOfString:@"localeDraft"].location==NSNotFound) {
//            //不是现场草稿
//            if ([[filename pathExtension] isEqualToString:extension1] || [[filename pathExtension] isEqualToString:extension2] || [[filename pathExtension] isEqualToString:extension3] || [[filename pathExtension] isEqualToString:extension4]) {
//                [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
//            }
//        }
    }
    [self showLabel:@"清理完成！"];
    //删除tmp/下图片
    contents = [fileManager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
    e = [contents objectEnumerator];
    while ((filename = [e nextObject])){
        DLog(@"%@",filename);
//        [fileManager removeItemAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:filename] error:NULL];
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"clearCache" object:nil userInfo:nil];
}

+(void)showLabel:(NSString *)hint{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

@end
