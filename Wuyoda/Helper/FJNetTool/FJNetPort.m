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

NSString *const IMGHTTP = @"http://wuyoda.com/union/"; // 图片域名

NSString *const CODE0 = @"200";

#pragma mark - 登录  7

// apple登录按钮显示
NSString *const AppleLogin_hiden = @"mobile/Control/index";

// 获取Token
NSString *const Login_GetToken = @"mobile/Login/getToken";
// 获取登录状态
NSString *const Login_login_status = @"mobile/Login/login_status";
// 登录
NSString *const Login_Login_index = @"mobile/Login/login_index";
// 发送验证码
NSString *const Login_sendVerify = @"mobile/Login/sendVerify";
// 验证码登录
NSString *const Login_phone_check = @"mobile/Login/phone_check";
//apple登录
NSString *const Login_appleLogin = @"mobile/Login/appleLogin";
//微信登录
NSString *const Login_weixinLogin = @"mobile/Login/weixinLogin";
// 手机号注册
NSString *const Login_phone_register = @"mobile/Login/phone_register";
//邮箱注册
NSString *const Login_email_register = @"mobile/Login/email_register";
//退出登录
NSString *const Login_login_out = @"mobile/Login/login_out";
//账号图形验证码
NSString *const Login_captcha= @"mobile/Login/captcha";

// 首页
NSString *const Index_index = @"mobile/Index/index";
// 首页商品类别
NSString *const Index_category = @"mobile/Index/category";
// 首页商品
NSString *const Index_shop = @"mobile/Index/shop";
// 首页台湾名品
NSString *const Store_twmp = @"mobile/Store/twmp";
// 首页宝岛礼盒
NSString *const Store_bdlh = @"mobile/Store/bdlh";
// 首页特惠商品
NSString *const Store_thsp = @"mobile/Store/thsp";
// 分类
NSString *const Classify_index = @"mobile/Classify/index";
// 分类商品
NSString *const Classify_cat_goods = @"mobile/Classify/cat_goods";
// 分类商品列表
NSString *const Classify_cat_product = @"mobile/Classify/cat_product";
// 分类商品列表顶部图片
NSString *const Classify_cate_file = @"mobile/Classify/cate_file";

// 热门搜索
NSString *const Classify_hot_word = @"mobile/Classify/hot_word";
// 历史搜索
NSString *const Classify_history = @"mobile/Classify/history";
// 删除历史搜索
NSString *const Classify_history_del = @"mobile/Classify/history_del";
// 获取商品列表
NSString *const Store_getProductList = @"mobile/Store/getProductList";
// 商品详情
NSString *const Store_Detail = @"mobile/Store/detail";
// 商品详情加入心愿单
NSString *const Special_favorite_detail = @"mobile/Special/favorite_detail";
// 商品详情移除心愿单
NSString *const Special_favorite_remove = @"mobile/Special/favorite_remove";

// 消息列表
NSString *const Store_notice = @"mobile/Store/notice";
// 消息详情
NSString *const Store_notice_list = @"mobile/Store/notice_list";
// 搜索商品
NSString *const Store_search = @"mobile/Store/search";
// 搜索商品塞选
NSString *const Store_search_list = @"mobile/Store/search_list";
// 推荐城市
NSString *const Store_city_list = @"mobile/Store/city_list";
// 热门景点
NSString *const Store_scenic_list = @"mobile/Store/scenic_list";
// 景点介绍
NSString *const Store_scenic_intro = @"mobile/Store/scenic_intro";

// 立即购买
NSString *const Special_buy_now = @"mobile/Special/buy_now";
// 加入购物车
NSString *const Special_cart_order = @"mobile/Special/cart_order";
// 购物车列表
NSString *const Store_order_cart = @"mobile/Store/order_cart";
// 购物车调整数量
NSString *const Special_cart_num = @"mobile/Special/cart_num";
// 购物车删除
NSString *const Special_cart_del = @"mobile/Special/cart_del";
// 移入心愿单
NSString *const Special_favorite_add = @"mobile/Special/favorite_add";
// 获取心愿单
NSString *const Special_favorites = @"mobile/Special/favorites";
// 移出心愿单
NSString *const Special_favorite_del = @"mobile/Special/favorite_del";
// 历史足迹月份
NSString *const Store_foot_list = @"mobile/Store/foot_list";
// 历史足迹
NSString *const Store_footprint = @"mobile/Store/footprint";
// 历史足迹移入心愿单
NSString *const Store_foot_add = @"mobile/Store/foot_add";
// 历史足迹删除
NSString *const Store_foot_del = @"mobile/Store/foot_del";


// 确认订单
NSString *const Special_confirm_order = @"mobile/Special/confirm_order";
// 订单计算总价
NSString *const Special_order_total = @"mobile/Special/order_total";
// 生成订单
NSString *const Special_order_create = @"mobile/Special/order_create";
// 生成订单
NSString *const Special_order_pay = @"mobile/Special/order_pay";
// 修改订单地址
NSString *const Special_modify_address = @"mobile/Special/modify_address";
// 银行卡列表
NSString *const Special_bank = @"mobile/Special/bank";
// 银行卡支付以及获取验证码
NSString *const Special_umf_pay = @"mobile/Special/umf_pay";
// 订单支付
NSString *const Special_juhe_pay = @"mobile/Special/juhe_pay";
// 订单支付结果
NSString *const Special_pay_result= @"mobile/Special/pay_result";

// 收获地址列表
NSString *const Special_address_list = @"mobile/Special/address_list";
// 新增收获地址
NSString *const Special_address_add = @"mobile/Special/address_add";
// 修改收获地址
NSString *const Special_address_edit = @"mobile/Special/address_edit";
// 删除收获地址
NSString *const Special_address_del = @"mobile/Special/address_del";
// 设置默认收获地址
NSString *const Special_get_address = @"mobile/Special/get_address";
// 查询全国所有省
NSString *const Special_pro_address  = @"mobile/Special/pro_address";
// 查询全国所有市
NSString *const Special_city_address  = @"mobile/Special/city_address";
// 查询全国所有区
NSString *const Special_county_address  = @"mobile/Special/county_address";


// 查询订单列表
NSString *const Special_orders  = @"mobile/Special/orders";
// 订单详情
NSString *const Special_orders_list  = @"mobile/Special/orders_list";
// 取消订单
NSString *const Special_cancel_order  = @"mobile/Special/cancel_order";
// 确认收货
NSString *const Special_receiv  = @"mobile/Special/receiv";
// 确认收货
NSString *const Special_buy_again  = @"mobile/Special/buy_again";

// 注销账号
NSString *const Login_cancel  = @"mobile/Login/cancel";
// 购物指南
NSString *const Store_shopprocess  = @"mobile/Store/shopprocess";
// 配送说明
NSString *const Store_deliveryfaq  = @"mobile/Store/deliveryfaq";
// 售后服务
NSString *const Store_return_policy  = @"mobile/Store/return_policy";
// 公司介绍
NSString *const Store_aboutus = @"mobile/Store/aboutus";
// 品牌介绍
NSString *const Store_brand_list = @"mobile/Store/brand_list";
// 联系我们
NSString *const Store_recruitment = @"mobile/Store/recruitment";

// 修改密码
NSString *const Login_pass_save = @"mobile/Login/pass_save";
// 修改手机
NSString *const Login_phone_save = @"mobile/Login/phone_save";
// 修改邮箱
NSString *const Login_email_save = @"mobile/Login/email_save";
// 修改个人信息
NSString *const Login_perfect = @"mobile/Login/perfect";

// 物流信息
NSString *const website_getOrderInfo = @"mobile/Special/synquery";

// 付款信息
NSString *const Special_bank_list = @"mobile/Special/bank_list";
// 添加银行卡
NSString *const Special_bank_add = @"mobile/Bank/bank_add";
