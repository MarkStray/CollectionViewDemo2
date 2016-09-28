//
//  BoolCollectionViewLayout.h
//  CollectionViewDemo2
//
//  Created by user on 16/3/10.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCollectionViewLayout : UICollectionViewLayout
/**
 *  每个照片之间的空隙
 */
@property (nonatomic, assign) CGFloat itemSpacing;
/**
 *  每个照片之间的上下填充
 */
@property (nonatomic, assign) CGFloat itemPadding;
/**
 *  每个照片的大小
 */
@property (nonatomic, assign) CGSize itemSize;


@end
