//
//  GoodEvaluateScoreTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/13.
//

#import <UIKit/UIKit.h>
#import "QuestionnaireStarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodEvaluateScoreTableViewCell : UITableViewCell

@property (nonatomic , strong)UILabel *titleLab;

@property (nonatomic , strong)QuestionnaireStarView *startV;

@property (nonatomic , strong)UIView *topLine;
@property (nonatomic , strong)UIView *bottomLine;

@property (nonatomic , assign)BOOL showLine;

@end

NS_ASSUME_NONNULL_END
