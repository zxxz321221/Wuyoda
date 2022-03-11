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
 0:消息，1:购物指南，2.配送说明，3.售后服务，4.公司介绍 ，5.联系我们，6.品牌介绍

 */
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)NSString *uid;

@property (nonatomic , copy)NSString *ordersn;

@end
