//
//  DataModel.h
//  HuoZhiShop
//
//  Created by MAC02 on 2021/1/13.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
