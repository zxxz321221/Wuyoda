//
//  HomeSearchHotCityView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeSearchHotCitySelectDelegate <NSObject>

-(void)selectHotCity:(NSString *)city;

@end

@interface HomeSearchHotCityView : UIView

@property (nonatomic , retain)NSMutableArray *hotCityArr;

@property (nonatomic , weak)id <HomeSearchHotCitySelectDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
