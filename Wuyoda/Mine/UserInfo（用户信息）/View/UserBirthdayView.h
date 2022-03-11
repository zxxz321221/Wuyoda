//
//  UserBirthdayView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UserInfoBirthdayDelegate <NSObject>

-(void)selectUserBirthday:(NSString *)birthday;

@end

@interface UserBirthdayView : UIView

@property (nonatomic , weak)id <UserInfoBirthdayDelegate>delegate;

-(void)show;
-(void)close;

@end

NS_ASSUME_NONNULL_END
