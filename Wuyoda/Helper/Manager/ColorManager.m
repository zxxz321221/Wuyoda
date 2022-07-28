//
//  ColorManager.m
//  SunflowerFramework
//
//  Created by 樊静 on 2020/6/19.
//  Copyright © 2020 Sunflower. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager
+(UIColor *)MainColor {
  return [self whiteColor:[UIColor colorWithHexString:@"#FD462D"] blackColor:[UIColor colorWithHexString:@"#FD462D"]];
}
+(UIColor *)WhiteColor {
    return [self whiteColor:[UIColor whiteColor] blackColor:[UIColor whiteColor]];
}
+(UIColor *)BlackColor {
    return [self whiteColor:[UIColor blackColor] blackColor:[UIColor blackColor]];

}

+(UIColor *)Color7F7F7F{
    return [self whiteColor:[UIColor colorWithHexString:@"#7F7F7F"] blackColor:[UIColor colorWithHexString:@"#7F7F7F"]];
}

+(UIColor *)Color777777{
    return [self whiteColor:[UIColor colorWithHexString:@"#777777"] blackColor:[UIColor colorWithHexString:@"#777777"]];
}
+(UIColor *)ColorF7F7F7{
    return [self whiteColor:[UIColor colorWithHexString:@"#F7F7F7"] blackColor:[UIColor colorWithHexString:@"#F7F7F7"]];
}
+(UIColor *)ColorF2F2F2{
    return [self whiteColor:[UIColor colorWithHexString:@"#F2F2F2"] blackColor:[UIColor colorWithHexString:@"#F2F2F2"]];
}
+(UIColor *)ColorE2E2E2{
    return [self whiteColor:[UIColor colorWithHexString:@"#E2E2E2"] blackColor:[UIColor colorWithHexString:@"#E2E2E2"]];
}
+(UIColor *)Color666666{
    return [self whiteColor:[UIColor colorWithHexString:@"#666666"] blackColor:[UIColor colorWithHexString:@"#666666"]];
}
+(UIColor *)Color999999{
    return [self whiteColor:[UIColor colorWithHexString:@"#999999"] blackColor:[UIColor colorWithHexString:@"#999999"]];
}
+(UIColor *)Color555555{
    return [self whiteColor:[UIColor colorWithHexString:@"#555555"] blackColor:[UIColor colorWithHexString:@"#555555"]];
}
+(UIColor *)Color333333{
    return [self whiteColor:[UIColor colorWithHexString:@"#333333"] blackColor:[UIColor colorWithHexString:@"#333333"]];
}
+(UIColor *)ColorAAAAAA{
    return [self whiteColor:[UIColor colorWithHexString:@"#AAAAAA"] blackColor:[UIColor colorWithHexString:@"#AAAAAA"]];
}
+(UIColor *)ColorCCCCCC{
    return [self whiteColor:[UIColor colorWithHexString:@"#CCCCCC"] blackColor:[UIColor colorWithHexString:@"#CCCCCC"]];
}
+(UIColor *)ColorD7D7D7{
    return [self whiteColor:[UIColor colorWithHexString:@"#D7D7D7"] blackColor:[UIColor colorWithHexString:@"#D7D7D7"]];
}
+(UIColor *)Color008A70{
    return [self whiteColor:[UIColor colorWithHexString:@"#008A70"] blackColor:[UIColor colorWithHexString:@"#008A70"]];
}
+(UIColor *)Color0300BF{
    return [self whiteColor:[UIColor colorWithHexString:@"#0300BF"] blackColor:[UIColor colorWithHexString:@"#0300BF"]];
}
+(UIColor *)Color4B7A02{
    return [self whiteColor:[UIColor colorWithHexString:@"#4B7A02"] blackColor:[UIColor colorWithHexString:@"#4B7A02"]];
}
+(UIColor *)ColorE1FFCA{
    return [self whiteColor:[UIColor colorWithHexString:@"#E1FFCA"] blackColor:[UIColor colorWithHexString:@"#E1FFCA"]];
}
+(UIColor *)ColorD8001B{
    return [self whiteColor:[UIColor colorWithHexString:@"#D8001B"] blackColor:[UIColor colorWithHexString:@"#D8001B"]];
}
+(UIColor *)ColorF5D3D7{
    return [self whiteColor:[UIColor colorWithHexString:@"#F5D3D7"] blackColor:[UIColor colorWithHexString:@"#F5D3D7"]];
}
+(UIColor *)ColorB8741A{
    return [self whiteColor:[UIColor colorWithHexString:@"#B8741A"] blackColor:[UIColor colorWithHexString:@"#B8741A"]];
}
+(UIColor *)ColorF7E6CE{
    return [self whiteColor:[UIColor colorWithHexString:@"#F7E6CE"] blackColor:[UIColor colorWithHexString:@"#F7E6CE"]];
}
+(UIColor *)Color7F4D12{
    return [self whiteColor:[UIColor colorWithHexString:@"#7F4D12"] blackColor:[UIColor colorWithHexString:@"#7F4D12"]];
}
+(UIColor *)Color3399FF{
    return [self whiteColor:[UIColor colorWithHexString:@"#3399FF"] blackColor:[UIColor colorWithHexString:@"#3399FF"]];
}
+(UIColor *)Color09AFFF{
    return [self whiteColor:[UIColor colorWithHexString:@"#09AFFF"] blackColor:[UIColor colorWithHexString:@"#09AFFF"]];
}
+(UIColor *)Color990900{
    return [self whiteColor:[UIColor colorWithHexString:@"#990900"] blackColor:[UIColor colorWithHexString:@"#990900"]];
}
+(UIColor *)ColorFA8B18{
    return [self whiteColor:[UIColor colorWithHexString:@"#FA8B18"] blackColor:[UIColor colorWithHexString:@"#FA8B18"]];
}
+(UIColor *)ColorFFF1F0{
    return [self whiteColor:[UIColor colorWithHexString:@"#FFF1F0"] blackColor:[UIColor colorWithHexString:@"#FFF1F0"]];
}
+(UIColor *)ColorFE3C3D{
    return [self whiteColor:[UIColor colorWithHexString:@"#FE3C3D"] blackColor:[UIColor colorWithHexString:@"#FE3C3D"]];
}
+(UIColor *)ColorFB9A3A{
    return [self whiteColor:[UIColor colorWithHexString:@"#FB9A3A"] blackColor:[UIColor colorWithHexString:@"#FB9A3A"]];
}
+(UIColor *)ColorFD817C{
    return [self whiteColor:[UIColor colorWithHexString:@"#FD817C"] blackColor:[UIColor colorWithHexString:@"#FD817C"]];
}

+(UIColor *)RandomColor {
    return [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
}



+(UIColor *)whiteColor:(UIColor *)white blackColor:(UIColor *)black {

    if (@available(iOS 13.0, *)) {
        UIColor *color =  [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
               if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                   return black;
               }
               return white;
           }];
           return color;
       }
           return white;
}
@end
