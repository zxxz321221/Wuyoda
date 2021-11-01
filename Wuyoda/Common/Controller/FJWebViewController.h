//
//  FJWebViewController.h
//  LotteryTicketNews
//
//  Created by 樊静 on 2017/6/7.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJBaseViewController.h"

@interface FJWebViewController : FJBaseViewController


@property(nonatomic,copy)NSString *url;
/**
 0: 关于
 1:证照信息
 2:用户服务协议
 3:退款声明协议
 */
@property(nonatomic,assign)NSInteger type;

@end
