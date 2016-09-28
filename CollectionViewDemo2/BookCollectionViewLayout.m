//
//  BoolCollectionViewLayout.m
//  CollectionViewDemo2
//
//  Created by user on 16/3/10.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BookCollectionViewLayout.h"
#import "BookCollectionReusableView.h"

@interface BookCollectionViewLayout ()
/**
 *  私有属性分区数量
 */
@property (nonatomic, assign) NSInteger section_count;
/**
 *  私有属性分数高度
 */
@property (nonatomic, assign) CGFloat section_height;

@end

@implementation BookCollectionViewLayout

// first layout calls
- (void)prepareLayout {
    [super prepareLayout];
    
    [self registerNib:[UINib nibWithNibName:@"BookCollectionReusableView" bundle:[NSBundle mainBundle]] forDecorationViewOfKind:@"BCRVIEW"];
}


// Subclasses must override this method and use it to return the width and height of the collection view’s content. These values represent the width and height of all the content, not just the content that is currently visible. The collection view uses this information to configure its own content size to facilitate scrolling.
-(CGSize)collectionViewContentSize {
    self.section_count = self.collectionView.numberOfSections;
    self.section_height = self.itemSize.height+self.itemPadding*2;
    return CGSizeMake(self.collectionView.bounds.size.width, self.section_count*self.section_height);
}


// Implement -layoutAttributesForElementsInRect: to return layout attributes for for supplementary or decoration views, or to perform layout in an as-needed-on-screen fashion.

//返回给定rect中包含的item的布局信息（也就是位置信息）

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributes = [NSMutableArray array];
    
    NSLog(@"Elements->:%@",NSStringFromCGRect(rect));
    
    for (int i=0; i<self.section_count; i++) {
        // 这里的item 没有任何作用, 只有分区起作用
        NSIndexPath *section_indexPath = [NSIndexPath indexPathForItem:0 inSection:i];
        [attributes addObject:[self layoutAttributesForDecorationViewOfKind:@"BCRVIEW" atIndexPath:section_indexPath]];
    }
    
    for (int i=0; i<self.section_count; i++) {
        NSInteger item_count = [self.collectionView numberOfItemsInSection:i];
        for (int j=0; j<item_count; j++) {
            NSIndexPath* iten_indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:iten_indexPath]];
        }
    }
    
    //改进 枚举
    return [attributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        //判断两个矩形是否有交叉
        return CGRectIntersectsRect(rect, evaluatedObject.frame);
    }]];
}


// Additionally, all layout subclasses should implement -layoutAttributesForItemAtIndexPath: to return layout attributes instances on demand for specific index paths.
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    CGFloat item_width = self.itemSize.width;
    CGFloat item_height = self.itemSize.height;
    
    NSInteger item_count = [self.collectionView numberOfItemsInSection:path.section];
    CGFloat leftSpace = (self.collectionView.bounds.size.width-item_count*self.itemSize.width)/(item_count-1);
    
    attributes.frame = CGRectMake(leftSpace+(item_width+self.itemSpacing)*path.item, self.itemPadding+self.section_height*path.section, item_width, item_height);

    NSLog(@"Item->:%d, %d, %@, %@",(int)path.section,(int)path.item,NSStringFromCGPoint(attributes.center),NSStringFromCGRect(attributes.frame));

    return attributes;
}


//Decoration View的布局。

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    // This property is used to determine the front-to-back ordering of items during layout. Items with higher index values appear on top of items with lower values. Items with the same value have an undetermined order.
    attributes.zIndex=-1;
    
    attributes.frame=CGRectMake(0, self.section_height*indexPath.section, self.collectionView.bounds.size.width, self.section_height);

    NSLog(@"DecorationView->:%d, %d, %@, %@",(int)indexPath.section,(int)indexPath.item,NSStringFromCGPoint(attributes.center),NSStringFromCGRect(attributes.frame));

    return attributes;
}





@end
