//
//  TWProductConditionView.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol selectTWProductConditionDelegate <NSObject>

-(void)selectCondition:(NSString *)condition;

@end

@interface TWProductConditionView : UIView

//@property (nonatomic , retain)UIPickerView *pickerView;

@property (nonatomic , retain)NSArray *dataArr;

@property (nonatomic , weak)id <selectTWProductConditionDelegate>delegate;

-(void)show;
-(void)close;

@end

NS_ASSUME_NONNULL_END
