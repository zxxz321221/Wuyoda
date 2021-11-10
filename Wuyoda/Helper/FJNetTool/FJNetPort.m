//
//  FJNetPort.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJNetPort.h"

// 请求网址前缀
NSString *const HTTP = @"http://new.wuyoda.com/"; // 客户正式服务器
//NSString *const HTTP = @"http://175.24.31.203/"; // 客户测试服务器

NSString *const CODE0 = @"200";

#pragma mark - 登录  7
// 获取Token
NSString *const Login_GetToken = @"mobile/Login/getToken";
// 登录
NSString *const Login_Login_index = @"mobile/Login/login_index";

// 首页
NSString *const Index_index = @"mobile/Index/index";
// 商品详情
NSString *const Store_Detail = @"mobile/Store/detail";
// 加入购物车
NSString *const Special_cart_order = @"mobile/Special/cart_order";
// 购物车列表
NSString *const Store_order_cart = @"mobile/Store/order_cart";
// 购物车调整数量
NSString *const Specia_cart_num = @"mobile/Special/cart_num";
// 确认订单
NSString *const Specia_confirm_order = @"mobile/Special/confirm_order";
// 生成订单
NSString *const Specia_order_create = @"mobile/Special/order_create";

// 新增收获地址
NSString *const Specia_address_add = @"mobile/Special/address_add";

