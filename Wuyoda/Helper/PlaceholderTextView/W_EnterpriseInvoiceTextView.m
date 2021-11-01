//
//  SYPlaceHolderTextView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/8.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import "W_EnterpriseInvoiceTextView.h"

#define originX 5.0
#define originY 5.0

@interface W_EnterpriseInvoiceTextView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderlabel;

@property (nonatomic, copy) void (^startBlock)(UITextView *textview);
@property (nonatomic, copy) void (^changeRankBlock)(UITextView *textview, NSRange range, NSString *text);
@property (nonatomic, copy) void (^changeBlock)(UITextView *textview);
@property (nonatomic, copy) void (^endBlock)(UITextView *textview);

@end

@implementation W_EnterpriseInvoiceTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [ColorManager ColorF2F2F2];
        [self setDefaultInit];
    }
    
    return self;
}


- (void)setDefaultInit
{
    _placeHolderColor = [UIColor colorWithHexString:@"#646268"];
    _placeHolderFont = self.font;
    
    [self setUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 创建视图

- (void)setUI
{
    self.delegate = self;
  //  self.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.placeHolderlabel = [[UILabel alloc] init];
    [self addSubview:self.placeHolderlabel];
    self.placeHolderlabel.textColor = _placeHolderColor;
    self.placeHolderlabel.textAlignment = NSTextAlignmentLeft;
    self.placeHolderlabel.hidden = YES;
//    self.placeHolderlabel.frame = CGRectMake(12, 12, self.width , kWidth(20));
    //self.placeHolderlabel.sd_layout.leftSpaceToView(self, kWidth(15)).centerYEqualToView(self).rightSpaceToView(self, kWidth(12)).heightIs(kWidth(20));
    [self.placeHolderlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kWidth(10));
        make.top.mas_offset(kWidth(8));
    }];
}

//- (void)resetPlaceholderlabel
//{
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    NSDictionary *attributes = @{NSFontAttributeName:self.placeHolderlabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
//
//    CGSize rtSize = [self.placeHolderlabel.text boundingRectWithSize:CGSizeMake(self.placeHolderlabel.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    CGFloat height = ceil(rtSize.height) + 0.5;
//
//    CGRect rect = self.placeHolderlabel.frame;
//    rect.size.height = height;
//    self.placeHolderlabel.frame = rect;
//}

#pragma mark - methord

- (void)textViewStart:(void (^)(UITextView *textview))start
    changeTextInRange:(void (^)(UITextView *textview, NSRange range, NSString *text))changeTextInRange
   changeNotification:(void (^)(UITextView *textview))changeNotification
                  end:(void (^)(UITextView *textview))end
{
    self.startBlock = start;
    self.changeRankBlock = changeTextInRange;
    self.changeBlock = changeNotification;
    self.endBlock = end;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSString *string = textView.text;
    self.placeHolderlabel.hidden = ((!string || 0 >= string.length) ? NO : YES);
    
    if (self.startBlock)
    {
        self.startBlock(textView);
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSString *string = textView.text;
    self.placeHolderlabel.hidden = ((!string || 0 >= string.length) ? NO : YES);
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.changeRankBlock)
    {
        self.changeRankBlock(textView, range, text);
    }
    
    if (self.isEndReturn && ([text isEqualToString:@"\n"]))
    {
        [textView resignFirstResponder];
    }
    
    return YES;
}

- (void)textViewEditChanged:(NSNotification *)notification
{
    
    NSString *string = self.text;
    self.placeHolderlabel.hidden = ((!string || 0 >= string.length) ? NO : YES);
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if ([self isFirstResponder])
            {
                if (_limitNumber != 0)
                {
                    // 默认不限制字数
                    NSString *toBeString = self.text;
                    if (toBeString.length > _limitNumber)
                    {
                        self.text = [toBeString substringToIndex:_limitNumber];
                    }
                }
            }
        }else{
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{
        if ([self isFirstResponder])
        {
            if (_limitNumber != 0)
            {
                // 默认不限制字数
                NSString *toBeString = self.text;
                if (toBeString.length > _limitNumber)
                {
                    self.text = [toBeString substringToIndex:_limitNumber];
                }
            }
        }
    }
    
    if (self.changeBlock)
    {
        self.changeBlock(self);
    }
}
#pragma mark - setter

- (void)setPlaceHolderText:(NSString *)placeHolderText
{
    _placeHolderText = placeHolderText;
    if (_placeHolderText && 0 < _placeHolderText.length)
    {
    self.placeHolderlabel.hidden = NO;
    }
    self.placeHolderlabel.text = placeHolderText;
}

- (void)setPlaceHolderFont:(UIFont *)placeHolderFont
{
    _placeHolderFont = placeHolderFont;
    if (_placeHolderFont)
    {
        self.placeHolderlabel.font = _placeHolderFont;
        
   //     [self resetPlaceholderlabel];
    }
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    self.placeHolderlabel.textColor = _placeHolderColor;
    
}

- (void)setLimitNumber:(NSInteger)limitNumber
{
    _limitNumber = limitNumber;
}
- (void)setInputText:(NSString *)inputText{
    _inputText = inputText;
    self.text = inputText;
    if (_inputText && 0 < _inputText.length) {
        self.placeHolderlabel.text = _placeHolderText;
        self.placeHolderlabel.hidden = YES;
        
    }else{
        if (_placeHolderText && 0 < _placeHolderText.length)
        {
            self.placeHolderlabel.text = _placeHolderText;
            self.placeHolderlabel.hidden = NO;
            
        }else{
            self.placeHolderlabel.text = _placeHolderText;
            self.placeHolderlabel.hidden = YES;
            
        }
    }
   
 //   [self resetPlaceholderlabel];
}
@end
