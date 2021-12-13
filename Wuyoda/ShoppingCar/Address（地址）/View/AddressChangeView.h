//
//  AddressChangeView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddressChangeSelectDelegate <NSObject>

-(void)selectAddress:(NSString *)proStr CityStr:(NSString *)cityStr AreaStr:(NSString *)areaStr;

@end

@interface AddressChangeView : UIView

@property (nonatomic  , weak) id <AddressChangeSelectDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
