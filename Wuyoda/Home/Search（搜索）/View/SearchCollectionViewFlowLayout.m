//
//  SearchCollectionViewFlowLayout.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/5/24.
//

#import "SearchCollectionViewFlowLayout.h"
#import "SearchModel.h"

@implementation SearchCollectionViewFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *answer = [NSMutableArray array];
    
    for (int i = 0; i<array.count; i++) {
        UICollectionViewLayoutAttributes *layoutAttributes = [array objectAtIndex:i];
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
            
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            
            if(layoutAttributes.indexPath.section == 0){
                SearchModel *model = [self.hotArr objectAtIndex:layoutAttributes.indexPath.row];
                CGFloat stringWidth = [model.name boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.width;
                if (layoutAttributes.indexPath.row == 0) {
                    layoutAttributes.frame = CGRectMake(kWidth(20), kWidth(54), stringWidth+kWidth(15), kWidth(24));
                    
                }else{
                    UICollectionViewLayoutAttributes *beforLayout = answer.lastObject;
                    if (beforLayout.size.width+beforLayout.frame.origin.x+stringWidth  + kWidth(15) > kScreenWidth-kWidth(40)) {
                        layoutAttributes.frame = CGRectMake(kWidth(20), beforLayout.frame.origin.y+kWidth(24)+kWidth(10), stringWidth+kWidth(15), kWidth(24));
                    }else{
                        layoutAttributes.frame = CGRectMake(beforLayout.size.width+beforLayout.frame.origin.x+kWidth(10), beforLayout.frame.origin.y, stringWidth+kWidth(15), kWidth(24));
                    }
                }
            }else{
                SearchModel *model = [self.historyArr objectAtIndex:layoutAttributes.indexPath.row];
                CGFloat stringWidth = [model.search boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.width;
                if (layoutAttributes.indexPath.row == 0) {
                    UICollectionViewLayoutAttributes *beforLayout = answer.lastObject;
                    layoutAttributes.frame = CGRectMake(kWidth(20), beforLayout.frame.origin.y+kWidth(24)+kWidth(64), stringWidth+kWidth(15), kWidth(24));
                    
                }else{
                    UICollectionViewLayoutAttributes *beforLayout = answer.lastObject;
                    if (beforLayout.size.width+beforLayout.frame.origin.x+stringWidth + kWidth(15)> kScreenWidth-kWidth(40)) {
                        layoutAttributes.frame = CGRectMake(kWidth(20), beforLayout.frame.origin.y+kWidth(24)+kWidth(10), stringWidth+kWidth(15), kWidth(24));
                    }else{
                        layoutAttributes.frame = CGRectMake(beforLayout.size.width+beforLayout.frame.origin.x+kWidth(10), beforLayout.frame.origin.y, stringWidth+kWidth(15), kWidth(24));
                    }
                }
            }
            
            
            [answer addObject:layoutAttributes];
        }else{
            if (layoutAttributes.indexPath.section == 1) {
                
                if (self.hotArr.count) {
                    UICollectionViewLayoutAttributes *beforLayout = [answer objectAtIndex:self.hotArr.count-1];
                    layoutAttributes.frame = CGRectMake(kWidth(0), beforLayout.frame.origin.y+kWidth(24)+kWidth(10), kScreenWidth, kWidth(35));
                }else{
                    UICollectionViewLayoutAttributes *beforLayout = answer.lastObject;
                    layoutAttributes.frame = CGRectMake(kWidth(0), beforLayout.frame.origin.y+kWidth(35)+kWidth(10), kScreenWidth, kWidth(35));
                }
                
                
            }
            [answer addObject:layoutAttributes];
        }
        
    }
    
    return answer;
}

@end
