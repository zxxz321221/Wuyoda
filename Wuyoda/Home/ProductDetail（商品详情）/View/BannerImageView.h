//
//  BannerImageView.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerImageView : UIView

@property (nonatomic , retain)NSArray *bannerArr;

@property (nonatomic , assign)NSInteger currentPage;

@end

NS_ASSUME_NONNULL_END
