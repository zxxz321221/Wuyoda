//
//  FJTabBar.h
//  NewHotel
//
//  Created by 樊静 on 2018/8/30.
//  Copyright © 2018年 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FJTabBar_midblock)();

@interface FJTabBar : UITabBar
@property (nonatomic,strong) UIColor * selectedColor;
@property (nonatomic,strong) UIColor * normalColor;

@property(nonatomic,strong) UIFont *normalFont;
@property(nonatomic,strong) UIFont *selectedFont;

@property (nonatomic,strong) UIImageView * middlebBtn;

@property (nonatomic,strong) FJTabBar_midblock midBlock;
@end
