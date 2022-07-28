//
//  SearchNavigationView.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchNavigationView : UIView

@property (nonatomic , retain)UITextField *searchField;

@property (nonatomic , retain)UIButton *searchBtn;

@property (nonatomic , retain)UIButton *shopCartBtn;

//1.搜索按钮 2.购物车按钮
@property (nonatomic , copy)NSString *type;

@end

NS_ASSUME_NONNULL_END
