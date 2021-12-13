//
//  FJNetPort.h
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const HTTP;

extern NSString *const IMGHTTP;

extern NSString *const CODE0;

#pragma mark - 登录
// 获取token
extern NSString *const Login_GetToken;
// 登录
extern NSString *const Login_Login_index;
// 发送验证码
extern NSString *const Login_sendVerify;
// 验证码登录
extern NSString *const Login_phone_check;
// apple登录
extern NSString *const Login_appleLogin;
// 微信登录
extern NSString *const Login_weixinLogin;



// 首页
extern NSString *const Index_index;
// 首页商品
extern NSString *const Index_shop;
// 首页台湾名品
extern NSString *const Store_twmp;
// 首页报道礼盒
extern NSString *const Store_bdlh;
// 首页特惠商品
extern NSString *const Store_thsp;
// 商品列表
extern NSString *const Store_getProductList;
// 商品详情
extern NSString *const Store_Detail;
// 消息列表
extern NSString *const Store_notice;
// 消息详情
extern NSString *const Store_notice_list;
// 首页搜索
extern NSString *const Store_search;
// 搜索塞选
extern NSString *const Store_search_list;
// 推荐城市
extern NSString *const Store_city_list;
// 热门景点
extern NSString *const Store_scenic_list;
// 景点介绍
extern NSString *const Store_scenic_intro;


// 加入购物车
extern NSString *const Special_cart_order;
// 购物车列表
extern NSString *const Store_order_cart;
// 购物车调整数量
extern NSString *const Special_cart_num;
// 购物车删除
extern NSString *const Special_cart_del;
// 移入心愿单
extern NSString *const Special_favorite_add;
// 获取心愿单
extern NSString *const Special_favorites;
// 移出心愿单
extern NSString *const Special_favorite_del;
// 历史足迹月份
extern NSString *const Store_foot_list;
// 历史足迹
extern NSString *const Store_footprint;
// 历史足迹移入心愿单
extern NSString *const Store_foot_add;
// 历史足迹删除
extern NSString *const Store_foot_del;


// 确认订单
extern NSString *const Special_confirm_order;
// 订单计算总价
extern NSString *const Special_order_total;
// 生成订单
extern NSString *const Special_order_create;
// 支付订单
extern NSString *const Special_order_pay;
// 修改订单地址
extern NSString *const Special_modify_address;
// 银行卡列表
extern NSString *const Special_bank;
// 银行卡列表
extern NSString *const Special_umf_pay;

// 收货地址列表
extern NSString *const Special_address_list;
// 新增收货地址
extern NSString *const Special_address_add;
// 修改收货地址
extern NSString *const Special_address_edit;
// 删除收货地址
extern NSString *const Special_address_del;
// 默认收货地址
extern NSString *const Special_get_address;
// 查询全国所有省
extern NSString *const Special_pro_address;
// 查询全国所有省
extern NSString *const Special_city_address;
// 查询全国所有省
extern NSString *const Special_county_address;

// 查询订单列表
extern NSString *const Special_orders;
// 查询订单详情
extern NSString *const Special_orders_list;
// 取消订单
extern NSString *const Special_cancel_order;
// 确认收货
extern NSString *const Special_receiv;

// 注销账号
extern NSString *const Login_cancel;
// 购物指南
extern NSString *const Store_shopprocess;
// 配送说明
extern NSString *const Store_deliveryfaq;
// 售后服务
extern NSString *const Store_return_policy;
// 公司介绍
extern NSString *const Store_aboutus;
// 联系我们
extern NSString *const Store_recruitment;

// 修改密码
extern NSString *const Login_pass_save;
// 修改手机
extern NSString *const Login_phone_save;
// 修改邮箱
extern NSString *const Login_email_save;
// 修改邮箱
extern NSString *const Login_perfect;

