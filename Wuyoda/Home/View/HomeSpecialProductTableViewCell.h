//
//  HomeSpecialProductTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SpecailProductTypeSelectDelegate <NSObject>

-(void)selectSpecailProductType:(NSInteger)index;

@end

@interface HomeSpecialProductTableViewCell : UITableViewCell

@property (nonatomic , assign)NSInteger typeIndex;

@property (nonatomic , retain)NSArray *typeArr;

@property (nonatomic , weak)id <SpecailProductTypeSelectDelegate>delegate;

@property (nonatomic , retain)NSArray *shopArr;

@end

NS_ASSUME_NONNULL_END
