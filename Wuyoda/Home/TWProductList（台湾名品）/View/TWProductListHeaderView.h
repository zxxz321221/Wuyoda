//
//  TWProductListHeaderView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol changeSearchTypeDelegate <NSObject>
//
//-(void)changeSearchCity:(NSString *)city;
//-(void)changeSearchTitle:(NSString *)title;
//-(void)changeSearchPrice:(NSString *)price;
//
//@end

@interface TWProductListHeaderView : UIView

@property (nonatomic , retain)NSMutableArray *recommendArr;

@property (nonatomic , retain)UIButton *addressBtn;
@property (nonatomic , retain)UIButton *typeBtn;
@property (nonatomic , retain)UIButton *priceBtn;

//@property (nonatomic , weak)id <changeSearchTypeDelegate>delegate;

//@property (nonatomic , retain)UITableView *tableView;

//1.搜索结果；2.台湾名品；3.宝岛礼盒
@property (nonatomic , copy)NSString *type;

@end

NS_ASSUME_NONNULL_END
