//
//  ClassicalTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import "ClassicalTableViewCell.h"

@interface ClassicalTableViewCell ()

@property (nonatomic , retain)UIView *bgV;

@property (nonatomic , retain)UILabel *titleLab;

@end

@implementation ClassicalTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth(100), kWidth(50))];
    [self.contentView addSubview:self.bgV];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth(100), kWidth(50))];
    self.titleLab.text = @"个人洗护";
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLab];
}

-(void)setModel:(ClassicalModel *)model{
    self.titleLab.text = model.category_name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.bgV.backgroundColor = [ColorManager ColorFFF1F0];
        self.titleLab.textColor = [ColorManager MainColor];
        self.titleLab.font = kBoldFont(16);
    }else{
        self.bgV.backgroundColor = [ColorManager WhiteColor];
        self.titleLab.textColor = [ColorManager Color333333];
        self.titleLab.font = kFont(14);
    }
    // Configure the view for the selected state
}

@end
