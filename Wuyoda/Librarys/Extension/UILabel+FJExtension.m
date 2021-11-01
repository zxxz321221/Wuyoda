//
//  UILabel+FJExtension.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "UILabel+FJExtension.h"
#import <CoreText/CoreText.h>

@implementation UILabel (FJExtension)

////部分文字添加中划线，文字颜色
//- (void)attributeWith:(NSString*)first second:(NSString*)second font:(UIFont *)font{
//
//    NSRange range1 = NSMakeRange(0, first.length);
//
//    NSRange range2 = NSMakeRange(first.length, second.length);
//
//    NSMutableAttributedString *astring = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",first,second]];
//
//    NSDictionary *attributes = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[ColorManager ColorBlackTextbbbbbb],NSForegroundColorAttributeName:[ColorManager ColorBlackTextbbbbbb],NSFontAttributeName:font};
//
//    [astring addAttributes:attributes range:range2];
//
//    [astring addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleNone) range:range1];
//
//    [astring addAttribute:NSForegroundColorAttributeName value:[ColorManager ColorBlackText111111] range:range1];
//
//    self.attributedText = astring;
//}

- (void)addShadowWithString:(NSString *)string shadowColor:(UIColor *)shadowColor shadowOffSet:(CGSize)offset stringColor:(UIColor *)textColor font:(UIFont *)font {
    if (!string) {
        return;
    }
    if (!textColor) {
        textColor = [UIColor whiteColor];
    }
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = shadowColor;
    shadow.shadowOffset = offset;
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:string];
    [attrM addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor,NSShadowAttributeName:shadow,NSVerticalGlyphFormAttributeName:@0} range:NSMakeRange(0, attrM.length)];
    self.attributedText = [attrM copy];
}

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText withAttrColor:(UIColor *)color withFont:(CGFloat )font {
    if (!attrText || !text) {
        return;
    }
    NSRange range = [text rangeOfString:attrText];
    
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [muStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:color} range:range];
    
    self.attributedText = muStr;
}

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2 withAttrColor:(UIColor *)color1 withFont:(CGFloat )font1 withAttrColor:(UIColor *)color2 withFont:(CGFloat )font2{
    
    
    
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [self stirng:text withSubstr:attrText1 withAttrColor:color1 withFont:font1 muStr:muStr];
    [self stirng:text withSubstr:text2 withAttrColor:color2 withFont:font2 muStr:muStr];
    
    
    self.attributedText = muStr;
}

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2  andText3:(NSString *)text3 withAttrColor:(UIColor *)color withFont:(CGFloat )font {
    
    
    
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [self stirng:text withSubstr:attrText1 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text2 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text3 withAttrColor:color withFont:font muStr:muStr];
    
    self.attributedText = muStr;
}

- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2  andText3:(NSString *)text3 andText4:(NSString *)text4 withAttrColor:(UIColor *)color withFont:(CGFloat )font {
    
    
       NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [self stirng:text withSubstr:attrText1 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text2 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text3 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text4 withAttrColor:color withFont:font muStr:muStr];
    
    self.attributedText = muStr;
}


- (void)needAttributeWithorigialText:(NSString *)text shouldAttributText:(NSString * ) attrText1 andText2:(NSString *)text2 andText3:(NSString *)text3 andText4:(NSString *)text4 andText5:(NSString *)text5 withAttrColor:(UIColor *)color withFont:(CGFloat )font {
    
    
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [self stirng:text withSubstr:attrText1 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text2 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text3 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text4 withAttrColor:color withFont:font muStr:muStr];
    [self stirng:text withSubstr:text5 withAttrColor:color withFont:font muStr:muStr];
    
    self.attributedText = muStr;
}



-(void)stirng:(NSString *)str withSubstr:(NSString *)subStr withAttrColor:(UIColor *)color withFont:(CGFloat )font muStr:(NSMutableAttributedString *)muStr{
    
    NSRange range = [str rangeOfString:[NSString stringWithFormat:@"%@",subStr]];
    
    [muStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:color} range:range];
    
    if ([str componentsSeparatedByString:subStr].count == 1) {
        return;
    }
    
    for (NSInteger i = 0; i < str.length; i += range.length) {
        
        if (i < str.length - range.length) {
            
            NSString *sub = [str substringWithRange:NSMakeRange(i, range.length)];
            
            NSRange subRange = NSMakeRange(i, range.length);
            
            if ([sub isEqualToString:subStr]) {
                
                [muStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:color} range:subRange];
                
            }
            
        }
    }
}

#pragma mark - 设置字间距， 行间距
- (void)setColumnSpace:(CGFloat)columnSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

- (void)setRowSpace:(CGFloat)rowSpace
{
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

@end
