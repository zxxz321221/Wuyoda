//
//  EvaluateInfoTableViewCell.m
//  Wuyoda
//
//  Created by 赵祥 on 2021/10/13.
//

#import "EvaluateInfoTableViewCell.h"

@interface EvaluateInfoTableViewCell ()<UITextViewDelegate>

@end

@implementation EvaluateInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    
    self.inputTextView = [[W_EnterpriseInvoiceTextView alloc]initWithFrame:CGRectMake(kWidth(24), kWidth(18), kScreenWidth-kWidth(48), kWidth(70))];
    self.inputTextView.textColor = [ColorManager Color333333];
    self.inputTextView.textAlignment = NSTextAlignmentLeft;
    self.inputTextView.font = kFont(14);
    self.inputTextView.placeHolderFont = kFont(14);
    self.inputTextView.placeHolderText = @"评价内容";
    self.inputTextView.placeHolderColor = [ColorManager ColorD7D7D7];
    self.inputTextView.inputText = @"";
    self.inputTextView.limitNumber = 200;
 
    self.inputTextView.layoutManager.allowsNonContiguousLayout = NO;
    self.inputTextView.scrollEnabled = YES;
    CGFloat yMargin = kWidth(12);
    self.inputTextView.textContainerInset = UIEdgeInsetsMake(yMargin,yMargin, yMargin, 0);
 //   self.inputTextView.contentInset = UIEdgeInsetsMake(yMargin, 0, yMargin, 0);

    [self.contentView addSubview:self.inputTextView];
//    [ self.inputTextView textViewStart:^(UITextView *textview) {
//        NSLog(@"start text %@", textview.text);
//    } changeTextInRange:^(UITextView *textview, NSRange range, NSString *text) {
//        NSLog(@"1change text %@", textview.text);
//
//    } changeNotification:^(UITextView *textview) {
//         if (textview.text.length > 200) {
//          textview.text = [textview.text substringToIndex:200];
//             [self showHUDWithText:@"输入已达最大限制" withYOffSet:0];
//         }
//        [self.delegate DynamicDetailCommentViewDelegateStr:textview.text];
//    } end:^(UITextView *textview) {
//        NSLog(@"end text %@", textview.text);
//    }];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
