//
//  FJProgressHUD.h
//  DLFramework
//
//  Created by 樊静 on 2019/5/13.
//  Copyright © 2019 樊静. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJProgressHUD : UIView
@property (nonatomic,strong) UIColor  *defaultBackGroundColor;//

@property (nonatomic,strong) UIColor  *foregroundColor;

@property (nonatomic,copy) NSString * hintText;
@property (nonatomic,assign) NSInteger hintTextFont;


- (void)showAnimationAtView:(UIView *)view ;
- (void)showAnimationWithHint:(NSString *)hint;
- (void)removeSubLayer;


@end

NS_ASSUME_NONNULL_END
