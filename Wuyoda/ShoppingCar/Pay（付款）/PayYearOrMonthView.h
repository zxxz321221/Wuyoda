//
//  PayYearOrMonthView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol selectPayDateDelegate <NSObject>

-(void)selectPayDate:(NSString *)date Type:(NSString *)type;

@end

@interface PayYearOrMonthView : UIView

@property (nonatomic , retain)NSArray *dateArr;

@property (nonatomic , copy)NSString *type;

@property (nonatomic , weak)id <selectPayDateDelegate>delegate;

- (void)show;
- (void)close;

@end

NS_ASSUME_NONNULL_END
