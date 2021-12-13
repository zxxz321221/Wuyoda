//
//  HomeTableHeaderView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableHeaderView : UIView

@property (nonatomic , copy) NSString *currentCity;

@property (nonatomic , retain)NSMutableArray *hotCityArr;

@property (nonatomic , retain)NSArray *allCityArr;

@end

NS_ASSUME_NONNULL_END
