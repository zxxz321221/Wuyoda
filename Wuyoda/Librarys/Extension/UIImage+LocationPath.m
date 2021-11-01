//
//  UIImage+LocationPath.m
//  SmartHouseKeeperIPad_iOS
//
//  Created by kk on 2017/6/15.
//  Copyright © 2017年 别智颖. All rights reserved.
//

#import "UIImage+LocationPath.h"

@implementation UIImage (LocationPath)

+ (BOOL)writeImageToLocation:(UIImage *)image
                locationName:(NSString *)locationName {
    NSString *path = [UIImage locationImagePath];
    path = [path stringByAppendingFormat:@"/%@.png", locationName];
    DLog(@"image path === %@", path);
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    if ([UIImagePNGRepresentation(image) writeToFile:path atomically:YES]) {
        DLog(@"存储图片成功");
        return YES;
    }
    return NO;
}

+ (UIImage *)searchLocationImageWithName:(NSString *)locationName {
    NSString *path = [UIImage locationImagePath];
    path = [path stringByAppendingFormat:@"/%@.png", locationName];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    DLog(@"image2 path == %@ is size %@", path, NSStringFromCGSize(image.size));
    return image;
}

+ (NSString *)locationImagePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

@end
