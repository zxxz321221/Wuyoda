//
//  FootPrintModel.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/12/2.
//

#import "BaseModel.h"
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FootPrintModel : BaseModel

@property (nonatomic , copy)NSString *addtime;
@property (nonatomic , copy)NSString *f_uid;
@property (nonatomic , strong)HomeShopModel *goods;
@property (nonatomic , copy)NSString *goods_table;
@property (nonatomic , copy)NSString *m_uid;
@property (nonatomic , copy)NSString *module;
@property (nonatomic , copy)NSString *isSelect;

@end

NS_ASSUME_NONNULL_END
