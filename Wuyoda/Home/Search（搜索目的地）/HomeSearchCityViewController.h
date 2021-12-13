//
//  HomeSearchCityViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/16.
//

#import "FJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HomeSearchCitySelectDelegate <NSObject>

-(void)selectCity:(NSString *)city;

@end

@interface HomeSearchCityViewController : FJBaseViewController

@property (nonatomic , retain)NSMutableArray *hotCityArr;

@property (nonatomic , retain)NSArray *allCityArr;

@property (nonatomic , weak)id <HomeSearchCitySelectDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
