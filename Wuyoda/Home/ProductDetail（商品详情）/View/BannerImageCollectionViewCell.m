//
//  BannerImageCollectionViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/1/11.
//

#import "BannerImageCollectionViewCell.h"

@interface BannerImageCollectionViewCell ()<UIScrollViewDelegate>

@property (nonatomic , retain)UIScrollView *scrollV;

@property (nonatomic , retain)UIImageView *imageV;

@end

@implementation BannerImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollV.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.scrollV];
    
    self.imageV = [[UIImageView alloc]initWithFrame:self.scrollV.bounds];
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.imageV.center = self.scrollV.center;
    self.imageV.userInteractionEnabled = YES;
    [self.imageV setImage:kGetImage(@"home_top")];
    [self.scrollV addSubview:self.imageV];
    
    self.scrollV.contentSize = CGSizeMake(kScreenWidth, 0);
    self.scrollV.delegate = self;
    self.scrollV.maximumZoomScale = 2.0;
    self.scrollV.minimumZoomScale = 1.0;
    self.scrollV.showsVerticalScrollIndicator = NO;
    self.scrollV.showsHorizontalScrollIndicator = NO;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageV;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat xcenter = scrollView.center.x;
    CGFloat ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    [self.imageV setCenter:CGPointMake(xcenter, ycenter)];
}

-(void)setModel:(BannerModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgbig]];
}

@end
