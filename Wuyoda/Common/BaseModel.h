//
//  BaseModel.h
//  SunflowerFramework
//
//  Created by 樊静 on 2020/6/4.
//  Copyright © 2020 Sunflower. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject
//id
@property (nonatomic, copy)NSString *ID;
//code
@property (nonatomic, copy)NSString *code;
@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *data;

//关于信息
@property (nonatomic, copy)NSString *introduce;
//证照信息
@property (nonatomic, copy)NSString *certificate;
//用户协议
@property (nonatomic, copy)NSString *agreement;
//退款协议
@property (nonatomic, copy)NSString *salesReturn;
@end

NS_ASSUME_NONNULL_END
