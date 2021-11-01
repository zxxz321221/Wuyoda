//
//  UIImage+Addition.m
//  BytalkApp
//
//  Created by zhihuiguan on 13-4-10.
//  Copyright (c) 2013年 zhihuiguan. All rights reserved.
//

#import "UIImage+Addition.h"
#define PREVIEW_IMAGE_HEIGHT 46.0
#define PREVIEW_IMAGE_WIDTH 60.0
#define MAX_WIDTH_OF_LITTLE_IMAGE       80.0  // 图片缩略图的最大边长.
CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};
@implementation UIImage (Addition)

//获取网络图片的高度
+ (CGSize)getImageSizeWithURL:(id)URL {
    NSURL * url = nil;
        if ([URL isKindOfClass:[NSURL class]]) {
            url = URL;
        }
        if ([URL isKindOfClass:[NSString class]]) {
            url = [NSURL URLWithString:URL];
        }
        if (!URL) {
            return CGSizeZero;
        }
        CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
        CGFloat width = 0, height = 0;
        
        if (imageSourceRef) {
            
            // 获取图像属性
            CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
            
            //以下是对手机32位、64位的处理
            if (imageProperties != NULL) {
                
                CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
                
    #if defined(__LP64__) && __LP64__
                if (widthNumberRef != NULL) {
                    CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
                }
                
                CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
                
                if (heightNumberRef != NULL) {
                    CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
                }
    #else
                if (widthNumberRef != NULL) {
                    CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
                }
                
                CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
                
                if (heightNumberRef != NULL) {
                    CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
                }
    #endif
                /***************** 此处解决返回图片宽高相反问题 *****************/
                // 图像旋转的方向属性
                NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
                CGFloat temp = 0;
                switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                    case UIImageOrientationLeft: // 向左逆时针旋转90度
                    case UIImageOrientationRight: // 向右顺时针旋转90度
                    case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                    case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                        temp = width;
                        width = height;
                        height = temp;
                    }
                        break;
                    default:
                        break;
                }
                /***************** 此处解决返回图片宽高相反问题 *****************/

                CFRelease(imageProperties);
            }
            CFRelease(imageSourceRef);
        }
        return CGSizeMake(width, height);
}

// 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    if (color) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
    return nil;
}

// 自定长宽缩放
+(UIImage*)scaleToSize:(UIImage*)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (void)createPreviewImageScaleToSize:(NSString *)orgImagePath{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    CGSize size = CGSizeMake(PREVIEW_IMAGE_WIDTH, PREVIEW_IMAGE_HEIGHT);
    // 原始图片
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:orgImagePath];
    
    if (image.size.width>image.size.height) {
        size = CGSizeMake(100.0, 80.0);
    }
    
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 缩略图的名称： 在现有的图片后面，加.png
    NSString *previewImgPath = [orgImagePath stringByAppendingString:@".png"];
    
    // 保存之。
    [UIImageJPEGRepresentation(scaledImage, 0.75) writeToFile:previewImgPath atomically:YES];

}

+ (void)createPreviewImage:(NSString *)orgImagePath{
    // 缩略图的名称： 在现有的图片后面，加.png
    NSString *previewImgPath = [orgImagePath stringByAppendingString:@".png"];
    
    // 原始图片
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:orgImagePath];
    
    // 原始的大小
    unsigned long imgHeight = CGImageGetHeight(image.CGImage);
    unsigned long imgWidth = CGImageGetWidth(image.CGImage);
    
    
    CGSize tgtSize = CGSizeZero;
    
    if (imgHeight < MAX_WIDTH_OF_LITTLE_IMAGE && imgWidth < MAX_WIDTH_OF_LITTLE_IMAGE) {
        // 如果图片的边长小于 最大边长, 显示图片的实际大小.
        [UIImagePNGRepresentation(image) writeToFile:previewImgPath atomically:YES];
        switch (image.imageOrientation) {
            case UIImageOrientationUp:
            case UIImageOrientationDown:
                tgtSize = CGSizeMake(imgWidth, imgHeight);
                break;
            case UIImageOrientationLeft:
            case UIImageOrientationRight:
                tgtSize = CGSizeMake(imgHeight , imgWidth);
                break;
            default:
                break;
        }
    }else{
        // 以长边为准,算出图片缩小的倍率
        float resizeRate = MAX(imgHeight, imgWidth) / MAX_WIDTH_OF_LITTLE_IMAGE;
        
        switch (image.imageOrientation) {
            case UIImageOrientationUp:
            case UIImageOrientationDown:
                tgtSize = CGSizeMake(imgWidth / resizeRate, imgHeight /resizeRate);
                break;
            case UIImageOrientationLeft:
            case UIImageOrientationRight:
                tgtSize = CGSizeMake(imgHeight /resizeRate, imgWidth / resizeRate);
                break;
            default:
                break;
        }
    }
    
    // 生成缩略图，
    UIImage *imageToShow = [UIImage scaleToSize:image size:tgtSize];
    
    // 保存之。
    [UIImageJPEGRepresentation(imageToShow, 0.75) writeToFile:previewImgPath atomically:YES];
    //[UIImagePNGRepresentation(imageToShow) writeToFile:previewImgPath atomically:YES];
}

+ (void)createPreviewImageForVideo:(NSString *)orgImagePath videoPath:(NSString *)vPath{
    // 缩略图的名称： 在现有的图片后面，加.png
    NSString *previewImgPath = [vPath stringByAppendingString:@".png"];
    
    // 原始图片
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:orgImagePath];
    
    // 原始的大小
    unsigned long imgHeight = CGImageGetHeight(image.CGImage);
    unsigned long imgWidth = CGImageGetWidth(image.CGImage);
    
    
    CGSize tgtSize = CGSizeZero;
    
    if (imgHeight < MAX_WIDTH_OF_LITTLE_IMAGE && imgWidth < MAX_WIDTH_OF_LITTLE_IMAGE) {
        // 如果图片的边长小于 最大边长, 显示图片的实际大小.
        [UIImagePNGRepresentation(image) writeToFile:previewImgPath atomically:YES];
        switch (image.imageOrientation) {
            case UIImageOrientationUp:
            case UIImageOrientationDown:
                tgtSize = CGSizeMake(imgWidth, imgHeight);
                break;
            case UIImageOrientationLeft:
            case UIImageOrientationRight:
                tgtSize = CGSizeMake(imgHeight , imgWidth);
                break;
            default:
                break;
        }
    }else{
        // 以长边为准,算出图片缩小的倍率
        float resizeRate = MAX(imgHeight, imgWidth) / MAX_WIDTH_OF_LITTLE_IMAGE;
        
        switch (image.imageOrientation) {
            case UIImageOrientationUp:
            case UIImageOrientationDown:
                tgtSize = CGSizeMake(imgWidth / resizeRate, imgHeight /resizeRate);
                break;
            case UIImageOrientationLeft:
            case UIImageOrientationRight:
                tgtSize = CGSizeMake(imgHeight /resizeRate, imgWidth / resizeRate);
                break;
            default:
                break;
        }
    }
    
    // 生成缩略图，
    UIImage *imageToShow = [UIImage scaleToSize:image size:tgtSize];
    
    // 保存之。
    [UIImageJPEGRepresentation(imageToShow, 0.75) writeToFile:previewImgPath atomically:YES];
    //[UIImagePNGRepresentation(imageToShow) writeToFile:previewImgPath atomically:YES];

}

//保存PNG到Caches下
+ (void)savePNGImage:(UIImage *)image toCachesWithName:(NSString *) fileName {
    
    NSArray *dirArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [dirArray firstObject];
    path = [path stringByAppendingPathComponent:fileName];
//    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]
//                      stringByAppendingPathComponent:fileName];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [imageData writeToFile:path atomically:YES];
//    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    NSLog(@"%@",path);
}

+ (NSString *)getPNGImageFilePathFromCache:(NSString *)fileName {
    
    NSArray *dirArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [dirArray firstObject];
    path = [path stringByAppendingPathComponent:fileName];

    return path;
}

- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;

    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

//把URL转成image
+ (UIImage *)getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

@end
