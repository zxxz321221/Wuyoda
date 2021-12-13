//
//  AddressListTableViewCell.h
//  Wuyoda
//
//  Created by 赵祥 on 2021/9/27.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol updateAddressDelegate <NSObject>

-(void)deleteAddressWithModel:(AddressModel *)model;

-(void)updateNormalAddressWithModel:(AddressModel *)model;

@end

@interface AddressListTableViewCell : UITableViewCell

@property (nonatomic , retain)AddressModel *model;

@property (nonatomic , weak) id <updateAddressDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
