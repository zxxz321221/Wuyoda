//
//  CityDetailHeaderView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/22.
//

#import <UIKit/UIKit.h>
#import "CityDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol updateCityHeaderHeightDelegate <NSObject>

-(void)updateCityHeaderHeight:(CGFloat)height;

@end

@interface CityDetailHeaderView : UIView

@property (nonatomic , retain)CityDetailModel *model;

@property (nonatomic , weak)id <updateCityHeaderHeightDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
