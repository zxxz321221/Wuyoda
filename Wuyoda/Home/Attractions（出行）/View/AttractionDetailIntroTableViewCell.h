//
//  AttractionDetailIntroTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/18.
//

#import <UIKit/UIKit.h>
#import "AttractionModel.h"
#import <WebKit/WebKit.h>

@protocol updateScenicIntroduceDelegate <NSObject>

-(void)updateScenicInftoduceHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_BEGIN

@interface AttractionDetailIntroTableViewCell : UITableViewCell

@property (nonatomic , retain)AttractionModel *model;

@property (nonatomic , retain)WKWebView *webView;

@property (nonatomic , weak)id <updateScenicIntroduceDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
