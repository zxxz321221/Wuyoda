//
//  TWProductListViewController.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import "FJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWProductListViewController : FJBaseViewController

//1.搜索结果；2.台湾名品；3.宝岛礼盒
@property (nonatomic , copy)NSString *type;

@property (nonatomic , copy)NSString *searchStr;

@property (nonatomic , retain)NSArray *allCityArr;

@property (nonatomic , copy)NSString *currentCity;

@end

NS_ASSUME_NONNULL_END
