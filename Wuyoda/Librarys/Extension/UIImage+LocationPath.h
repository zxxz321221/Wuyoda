//
//  UIImage+LocationPath.h
//  SmartHouseKeeperIPad_iOS
//
//  Created by kk on 2017/6/15.
//  Copyright © 2017年 别智颖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LocationPath)

//将图片写入cache下的一个目录
+ (BOOL)writeImageToLocation:(UIImage *)image
                locationName:(NSString *)locationName;

//从cache读取一个图片
+ (UIImage *)searchLocationImageWithName:(NSString *)locationName;

@end
