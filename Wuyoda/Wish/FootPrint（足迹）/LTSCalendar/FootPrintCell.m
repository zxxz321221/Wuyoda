//
//  FootPrintCell.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/16.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "FootPrintCell.h"
#import "FootGoodsModel.h"
//#import "JYTimerUtil.h"
@interface FootPrintCell()//<JYTimerListener>
{
    NSInteger sec;
    NSInteger index;
}
@property (nonatomic , strong)UIView * backV;
@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic , strong) UIImageView * webImg;
@property (nonatomic,strong) UILabel * name;
@property (nonatomic , strong) UIButton * edit;
@property (nonatomic , strong) UILabel * timeL;
@property (nonatomic , strong) UIImageView * timeImg;
//@property (nonatomic , strong) UILabel * bidL;

@property (nonatomic , strong) UIView * markView;
@property (nonatomic , strong) UILabel * markLabel;
@end
@implementation FootPrintCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //kvo监听time值改变（解决cell滚动时内容不及时刷新的问题）
        [self addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//        [[JYTimerUtil sharedInstance] addListener:self];
//        self.contentView.backgroundColor = [Unity getColor:@"#f0f0f0"];
        [self.contentView addSubview:self.backV];
    }
    return self;
}
-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"time"];
    //[[JYTimerUtil sharedInstance] removeListener:self];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //[self onTimer];
}

//-(void)didOnTimer:(JYTimerUtil *)timerUtil timeInterval:(NSTimeInterval)timeInterval
//{
//    [self onTimer];
//}
//-(void)onTimer
//{
//    NSTimeInterval lefTime = [[JYTimerUtil sharedInstance] lefTimeInterval:self.time];
//    //    NSLog(@"left%f",lefTime);
//    if (lefTime>0) {
//        NSInteger days = (int)(lefTime/(3600*24));
//        NSInteger hours = (int)((lefTime-days*24*3600)/3600);
//        NSInteger minute = (int)(lefTime-days*24*3600-hours*3600)/60;
////        NSInteger second = lefTime - days*24*3600 - hours*3600 - minute*60;
//        self.timeL.text = [NSString stringWithFormat:@"%02ld天%02ld时%02ld分",(long)days,(long)hours,(long)minute];\
//        self.markView.hidden = YES;
//        self.markLabel.hidden = YES;
//    }else {
//        self.timeL.text = @"已结束";
//        self.markView.hidden = NO;
//        self.markLabel.hidden = NO;
//    }
//}
- (UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake(0, kWidth(2.5), self.contentView.width,self.contentView.height-kWidth(2.5))];
        _backV.backgroundColor = [UIColor whiteColor];
        _backV.layer.cornerRadius = 5;
        
        [_backV addSubview:self.imgView];
        [_backV addSubview:self.markView];
        [_backV addSubview:self.markLabel];
        [_backV addSubview:self.webImg];
        [_backV addSubview:self.name];
        [_backV addSubview:self.timeImg];
        [_backV addSubview:self.timeL];
        [_backV addSubview:self.read];
//        [_backV addSubview:self.icon];
//        [_backV addSubview:self.bidL];
        [_backV addSubview:self.edit];
        
    }
    return _backV;
}
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _backV.width, kWidth(110))];
//        _imgView.backgroundColor = [UIColor redColor];
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_imgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _imgView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _imgView.layer.mask = cornerRadiusLayer;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds= YES;
    }
    return _imgView;
}
- (UIView *)markView{
    if (!_markView) {
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _backV.width, kWidth(110))];
        // 左上和右上为圆角
        _markView.backgroundColor = [UIColor blackColor];
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_imgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
        cornerRadiusLayer.frame = _imgView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _markView.layer.mask = cornerRadiusLayer;
        _markView.alpha = 0.5;
        _markView.hidden = YES;
    }
    return _markView;
}
- (UILabel *)markLabel{
    if (!_markLabel) {
        _markLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kWidth(45), _markView.width, kWidth(20))];
        _markLabel.text = @"已结束";
        _markLabel.textColor = [UIColor whiteColor];
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.font = [UIFont systemFontOfSize:20];
        _markLabel.hidden = YES;
    }
    return _markLabel;
}
- (UIImageView *)webImg{
    if (!_webImg) {
        _webImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(5), 0, kWidth(25), kWidth(20))];
//        _webImg.image = [UIImage imageNamed:@"footyahoo"];
    }
    return _webImg;
}
- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(kWidth(5), _imgView.bottom, _backV.width-kWidth(10), kWidth(20))];
//        _name.text = @"非经典款沙拉酱付款大连市静安看了非经典款啦记录";
        _name.textAlignment = NSTextAlignmentLeft;
        _name.textColor = [ColorManager Color333333];
        _name.font = [UIFont systemFontOfSize:12];
    }
    return _name;
}
- (UIImageView *)timeImg{
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(5), _name.bottom+kWidth(4), kWidth(12), kWidth(12))];
        _timeImg.image = [UIImage imageNamed:@"foottime"];
    }
    return _timeImg;
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake(_timeImg.right+kWidth(5), _name.bottom, self.contentView.width-kWidth(27), kWidth(20))];
        _timeL.text = @"1天4时44分";
        _timeL.textColor = [ColorManager Color999999];
        _timeL.font = [UIFont systemFontOfSize:12];
    }
    return _timeL;
}
- (UIButton *)read{
    if (!_read) {
        _read = [[UIButton alloc]initWithFrame:CGRectMake(kWidth(5), _name.bottom+kWidth(22), kWidth(16), kWidth(16))];
        [_read addTarget:self action:@selector(readClick:) forControlEvents:UIControlEventTouchUpInside];
        [_read setImage:[UIImage imageNamed:@"没选"] forState:UIControlStateNormal];
        [_read setImage:[UIImage imageNamed:@"read"] forState:UIControlStateSelected];
        _read.hidden = YES;
    }
    return _read;
}
//- (UIImageView *)icon{
//    if (!_icon) {
//        _icon = [[UIImageView alloc]initWithFrame:CGRectMake([Unity countcoordinatesW:5], _name.bottom+[Unity countcoordinatesH:24], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12])];
//        _icon.image = [UIImage imageNamed:@"footcount"];
//    }
//    return _icon;
//}
//- (UILabel *)bidL{
//    if (!_bidL) {
//        _bidL = [[UILabel alloc]initWithFrame:CGRectMake(_timeL.left, _timeL.bottom, [Unity countcoordinatesW:30], [Unity countcoordinatesH:20])];
//        _bidL.text = @"9999";
//        _bidL.textColor = LabelColor9;
//        _bidL.font = [UIFont systemFontOfSize:FontSize(12)];
//    }
//    return _bidL;
//}
- (UIButton *)edit{
    if (!_edit) {
        _edit = [[UIButton alloc]initWithFrame:CGRectMake(_backV.width-kWidth(21), _timeL.bottom+kWidth(2), kWidth(16),kWidth(16))];
        [_edit addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
        [_edit setBackgroundImage:[UIImage imageNamed:@"footedit"] forState:UIControlStateNormal];
    }
    return _edit;
}
- (void)configWithSection:(NSInteger)section IndexPath:(NSInteger)indexPath IsEdit:(BOOL)isEdit{
    if (isEdit) {
        self.read.hidden = NO;
//        self.icon.frame = CGRectMake([Unity countcoordinatesW:16]+10, [Unity countcoordinatesH:154], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12]);
//        self.bidL.frame = CGRectMake(self.icon.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:150], [Unity countcoordinatesW:30], [Unity countcoordinatesH:20]);
    }else{
        self.read.hidden = YES;
//        self.icon.frame = CGRectMake([Unity countcoordinatesW:5], [Unity countcoordinatesH:154], [Unity countcoordinatesW:12], [Unity countcoordinatesH:12]);
//        self.bidL.frame = CGRectMake(self.icon.right+[Unity countcoordinatesW:5], [Unity countcoordinatesH:150], [Unity countcoordinatesW:30], [Unity countcoordinatesH:20]);
    }
    sec = section;
    index = indexPath;
}
- (void)readClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(shoppingCellDelegate:WithSelectButton:)])
    {
        [self.delegate shoppingCellDelegate:self WithSelectButton:sender];
    }
}
- (void)editClick{
    [self.delegate withOfDelete:sec IndexPath:index];
}
/**
 *  模型赋值
 */
- (void)setModel:(FootGoodsModel *)model{
    self.read.selected = model.isSelect;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.image]] placeholderImage:[UIImage imageNamed:@"Loading"]];
    if ([model.source isEqualToString:@"yahoo"]) {
        self.webImg.image = [UIImage imageNamed:@"footyahoo"];
    }else{
        self.webImg.image = [UIImage imageNamed:@"footeaby"];
    }
    self.name.text = model.name;
}
@end
