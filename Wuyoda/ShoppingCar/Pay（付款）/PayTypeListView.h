//
//  PayTypeListView.h
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol selectPayTypeDelegate <NSObject>

-(void)selectPayType:(NSString *)type;

@end

@interface PayTypeListView : UIView

@property (nonatomic , weak)id <selectPayTypeDelegate>delegate;

- (void)show;
- (void)close;

@end

NS_ASSUME_NONNULL_END
