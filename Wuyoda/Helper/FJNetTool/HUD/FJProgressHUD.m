//
//  FJProgressHUD.m
//  DLFramework
//
//  Created by 樊静 on 2019/5/13.
//  Copyright © 2019 樊静. All rights reserved.
//

#import "FJProgressHUD.h"


#define HUDDefaultBackGroundColor [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2]
#define HUDForegroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.6]

@interface FJProgressHUD ()

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,strong) CAReplicatorLayer * replicatorLayer ;

@property (nonatomic,strong) CALayer * mylayer;

@property (nonatomic,strong) CABasicAnimation  * basicAnimation;

@property (nonatomic,strong) UILabel * hintLabel;

@end

@implementation FJProgressHUD

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //        UIWindow * window = [UIApplication sharedApplication].keyWindow ;
        //        [window addSubview:self];

        [self configureUI];
    }
    return self;
}

- (void)configureUI {
    self.defaultBackGroundColor = HUDDefaultBackGroundColor;
    self.foregroundColor = HUDForegroundColor;
    self.count = 10;
}



#pragma  HUD
-(CAReplicatorLayer *)replicatorLayer
{
    if (_replicatorLayer) {
        return _replicatorLayer;
    }
    self.replicatorLayer = [CAReplicatorLayer layer];
    self.replicatorLayer.cornerRadius = 10.0;

    return self.replicatorLayer;
}

-(CALayer *)mylayer
{
    if (_mylayer) {
        return _mylayer;
    }
    self.mylayer = [CALayer layer];
    self.mylayer.masksToBounds = YES;
    return self.mylayer;
}

-(CABasicAnimation *)basicAnimation
{
    if (_basicAnimation) {
        return _basicAnimation;
    }
    self.basicAnimation = [CABasicAnimation animation];
    self.basicAnimation.repeatCount = MAXFLOAT;
    self.basicAnimation.removedOnCompletion = NO;
    self.basicAnimation.fillMode = kCAFillModeForwards;

    return self.basicAnimation;
}

-(void)setDefaultBackGroundColor:(UIColor *)defaultBackGroundColor
{
    _defaultBackGroundColor = defaultBackGroundColor;

    self.replicatorLayer.backgroundColor = defaultBackGroundColor.CGColor;

}

-(void)setForegroundColor:(UIColor *)foregroundColor
{
    _foregroundColor = foregroundColor;

    self.mylayer.backgroundColor = foregroundColor.CGColor;

}

#pragma mark - ShowAnimation method

-(void)showAnimationAtView:(UIView *)view {


    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeSubLayer];
    });
    self.count = 10;
    [self configCircle];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addSubLayer];
    });

}

- (void)showAnimationWithHint:(NSString *)hint {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeSubLayer];
    });
    self.count = 10;
    [self configCircle];

    self.hintText = hint;
    [self setNeedsLayout];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addSubLayer];


    });
}


-(void)configCircle
{
    CGFloat width = 10;

    self.mylayer.frame = CGRectMake(0, 0, width, width);
    self.mylayer.cornerRadius = width / 2;
    self.mylayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);

    self.replicatorLayer.instanceCount = self.count;

    CGFloat angle = 2 * M_PI / self.count;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    self.replicatorLayer.instanceDelay = 1.0 / self.count;

    self.basicAnimation.keyPath = @"transform.scale";
    self.basicAnimation.duration = 1;
    self.basicAnimation.fromValue = @1;
    self.basicAnimation.toValue = @0.1;

}


-(void)configDot
{
    CGFloat width = 15 ;

    self.mylayer.frame = CGRectMake(0, 0, width, width);
    self.mylayer.transform = CATransform3DMakeScale(0, 0, 0);
    self.mylayer.cornerRadius = width / 2;
    self.replicatorLayer.instanceCount = self.count;

    self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(100/3, 0, 0);
    self.replicatorLayer.instanceDelay = 0.8 / self.count;

    self.basicAnimation.keyPath = @"transform.scale";
    self.basicAnimation.duration = 0.8;
    self.basicAnimation.fromValue = @1;
    self.basicAnimation.toValue = @0;

}

-(void)removeSubLayer
{
    [self.replicatorLayer removeFromSuperlayer];
    [self.hintLabel removeFromSuperview];
    [self.mylayer removeFromSuperlayer];
    [self.mylayer removeAnimationForKey:@"HUD"];
    //    [self removeFromSuperview];

}

-(void)addSubLayer
{
    [self.layer addSublayer:self.replicatorLayer];
    [self.replicatorLayer addSublayer:self.mylayer];
    [self.mylayer addAnimation:self.basicAnimation forKey:@"HUD"];

    //    [self.layer setBackgroundColor:[UIColor redColor].CGColor];
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    self.frame = CGRectMake((kScreenWidth - self.width)/2, (kScreenHeight - self.width)/2, self.width, self.width);

    //    self.backgroundColor = [UIColor redColor];

    self.layer.frame = self.frame;
    self.replicatorLayer.frame = self.bounds;


    //    self.replicatorLayer.position = self.center;


    self.mylayer.position = CGPointMake(50,20);

    if (self.hintText) {
        self.defaultBackGroundColor = [UIColor clearColor];
        CGFloat labelW = labelWidth(self.hintLabel);
        CGFloat labelH = labelHeight(self.hintLabel);

        CGFloat x = (self.width - labelW) / 2;
        self.hintLabel.frame = CGRectMake(x, self.height + 15, labelW, labelH);
        [self addSubview:self.hintLabel];
    }


}

- (UILabel *)hintLabel {
    if (!_hintLabel ) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.text = self.hintText;
        _hintLabel.font = [UIFont systemFontOfSize:self.hintTextFont];
        _hintLabel.textColor = [UIColor colorWithHexString:@"6d6d6d" alpha:1];
        _hintLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _hintLabel;
}


@end
