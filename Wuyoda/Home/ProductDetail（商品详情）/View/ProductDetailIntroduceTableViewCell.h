//
//  ProductDetailIntroduceTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/15.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol updateProductIntroduceDelegate <NSObject>

-(void)updateProductInftoduceHeight:(CGFloat)height;

@end

@interface ProductDetailIntroduceTableViewCell : UITableViewCell

@property (nonatomic , retain)HomeShopModel *model;

@property (nonatomic , retain)WKWebView *webView;

@property (nonatomic , weak)id <updateProductIntroduceDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
