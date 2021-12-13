//
//  FootView.m
//  GlobalBuyer
//
//  Created by 桂在明 on 2019/5/7.
//  Copyright © 2019 薛铭. All rights reserved.
//

#import "FootView.h"
@interface FootView()

@property (nonatomic,strong) UIView * backView;
@property (nonatomic, strong) UIButton * collectionBtn;
@property (nonatomic , strong) UIButton * deleteBtn;
@property (nonatomic , strong) UILabel * collectionL;
@property (nonatomic , strong) UILabel * deleteL;
@property (nonatomic , strong) UIButton * cancelBtn;
@property (nonatomic , strong) UIButton * shareBtn;
@property (nonatomic , strong) UILabel * shareL;
@end
@implementation FootView

+(instancetype)setFootView:(UIView *)view{
    FootView * footView = [[FootView alloc]initWithFrame:view.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:footView];
    return footView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.hidden = YES;
        [self addSubview:self.backView];
    }
    return self;
}
-(UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenWidth, kScreenWidth, kWidth(150))];
        _backView.backgroundColor = [ColorManager ColorD7D7D7];
        
//        [_backView addSubview:self.shareBtn];
//        [_backView addSubview:self.shareL];
        [_backView addSubview:self.collectionBtn];
        [_backView addSubview:self.deleteBtn];
        [_backView addSubview:self.collectionL];
        [_backView addSubview:self.deleteL];
        [_backView addSubview:self.cancelBtn];
    }
    return _backView;
}
//- (UIButton *)shareBtn{
//    if (!_shareBtn) {
//        _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-[Unity countcoordinatesW:135])/4, [Unity countcoordinatesH:20], [Unity countcoordinatesW:45], [Unity countcoordinatesH:45])];
//        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"footshare"] forState:UIControlStateNormal];
//        [_shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _shareBtn;
//}
- (UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(80), kWidth(20), kWidth(45), kWidth(45))];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"footcollection"] forState:UIControlStateNormal];
        [_collectionBtn addTarget:self action:@selector(collectionClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionBtn;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-kWidth(125), kWidth(20), kWidth(45), kWidth(45))];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"footdelete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
//- (UILabel *)shareL{
//    if (!_shareL) {
//        _shareL = [[UILabel alloc]initWithFrame:CGRectMake(_shareBtn.left, _shareBtn.bottom+[Unity countcoordinatesH:10], _shareBtn.width, [Unity countcoordinatesH:20])];
//        _shareL.text = @"分享";
//        _shareL.textColor = [Unity getColor:@"#333333"];
//        _shareL.font = [UIFont systemFontOfSize:14];
//        _shareL.textAlignment = NSTextAlignmentCenter;
//    }
//    return _shareL;
//}
- (UILabel *)collectionL{
    if (!_collectionL) {
        _collectionL = [[UILabel alloc]initWithFrame:CGRectMake(_collectionBtn.left, _collectionBtn.bottom+kWidth(10), _collectionBtn.width, kWidth(20))];
        _collectionL.text = @"收藏";
        _collectionL.textColor = [ColorManager Color333333];
        _collectionL.font = [UIFont systemFontOfSize:14];
        _collectionL.textAlignment = NSTextAlignmentCenter;
    }
    return _collectionL;
}
- (UILabel *)deleteL{
    if (!_deleteL) {
        _deleteL = [[UILabel alloc]initWithFrame:CGRectMake(_deleteBtn.left, _deleteBtn.bottom+kWidth(10), _deleteBtn.width, kWidth(20))];
        _deleteL.text = @"删除";
        _deleteL.textColor = [ColorManager Color333333];
        _deleteL.font = [UIFont systemFontOfSize:14];
        _deleteL.textAlignment = NSTextAlignmentCenter;
    }
    return _deleteL;
}
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kWidth(110), kScreenWidth, kWidth(40))];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[ColorManager Color333333] forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (void)cancelClick{
    [self hiddenFootView];
}
- (void)shareClick{
    [self.delegate footShare];
}
- (void)collectionClick{
    [self.delegate footCollection];
}
- (void)deleteClick{
    [self.delegate footDelete];
}
- (void)showFootView{
    self.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView setFrame:CGRectMake(0, kScreenHeight-kWidth(150), kScreenWidth, kWidth(150))];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }completion:nil];
}
- (void)hiddenFootView{
    [UIView animateWithDuration:0.5 animations:^{
        [self.backView setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kWidth(150))];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    }completion:nil];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
}
- (void)delayMethod{
    self.hidden = YES;
}
@end
