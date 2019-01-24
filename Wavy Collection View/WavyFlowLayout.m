//
//  WavyFlowLayout.m
//  Wavy Collection View
//
//  Created by Yilei Huang on 2019-01-23.
//  Copyright © 2019 Joshua Fanng. All rights reserved.
//

#import "WavyFlowLayout.h"

@implementation WavyFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(100, 50);
    // Set minimum interitem spacing to be huge to force all items to be on their own line
    self.minimumInteritemSpacing = CGFLOAT_MAX;
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    // 修改原有的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray<UICollectionViewLayoutAttributes *> *superAttrs = [super layoutAttributesForElementsInRect:rect];

    // Need to copy attrs from super to avoid cached frame mismatch
    NSMutableArray<UICollectionViewLayoutAttributes *> *newAttrs = [[NSMutableArray alloc] init];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width *0.5;
    
    for (UICollectionViewLayoutAttributes *attrs in superAttrs) {
       // newAttrs.
//        UICollectionViewLayoutAttributes *attributes =
//        [self layoutAttributesForItemAtIndexPath:indexPath];
//        int y = attributes.frame.origin.y-20;
//        attributes.center = CGPointMake(attributes.center.x, arc4random_uniform(y*2)-y);
        CGFloat delta = ABS(attrs.center.x-centerX);
        CGFloat scale = 1 - delta / self.collectionView.frame.size.width;
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        // 设置缩放比例
        
        //int y = self.collectionView.frame.origin.y;
        //NSLog(@"%i",y);
        int randomY = arc4random_uniform(self.collectionView.frame.size.height-attrs.frame.size.height);
        NSLog(@"%f",self.collectionView.frame.size.height-attrs.frame.size.height);
        attrs.center = CGPointMake(attrs.center.x,  arc4random_uniform(attrs.center.y*2-30)+self.collectionView.frame.origin.y);
        int randomH= 720 - randomY;
        if(randomH/2 <= attrs.frame.size.height){
            randomH =attrs.frame.size.height*3;
        }
        attrs.frame = CGRectMake(attrs.center.x, randomY, 100, randomH);
        [newAttrs addObject:attrs];
    }
    // TODO: fill me in!
    

    return newAttrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


@end
