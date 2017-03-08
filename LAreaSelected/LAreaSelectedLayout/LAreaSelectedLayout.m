	//
//  LAreaSelectedLayout.m
//  LAreaSelected
//
//  Created by 俊杰  廖 on 2017/3/7.
//  Copyright © 2017年 俊杰  廖. All rights reserved.
//

#import "LAreaSelectedLayout.h"

static CGFloat minimumLineSpacing = 10.0;
static CGFloat minimumInteritemSpacing = 10.0;
static UIEdgeInsets collectionEdgeInsets = {0 ,0 ,0 ,0};

@interface LAreaSelectedLayout()
@property (nonatomic,strong) NSMutableArray *attrsArray;
@property (nonatomic,assign) CGFloat itemMaxX;
@property (nonatomic,assign) CGFloat itemMaxY;
@property (nonatomic,assign) CGFloat contentHeight;
@end

@implementation LAreaSelectedLayout

- (CGFloat)getminimumLineSpacing {
    if ([self.delegate respondsToSelector:@selector(minimumLineSpacing:)]) {
        return [self.delegate minimumLineSpacing:self];
    }
    return minimumLineSpacing;
}

- (CGFloat)getMinimumInteritemSpacing {
    if ([self.delegate respondsToSelector:@selector(minimumInteritemSpacing:)]) {
        return [self.delegate minimumInteritemSpacing:self];
    }
    return minimumInteritemSpacing;
}

- (UIEdgeInsets)getCollectionEdgeInsets {
    if ([self.delegate respondsToSelector:@selector(collectionEdgeInsets:)]) {
        return [self.delegate collectionEdgeInsets:self];
    }
    return collectionEdgeInsets;
}



- (void)prepareLayout {
    [super prepareLayout];
    [self.attrsArray removeAllObjects];
    self.itemMaxX = [self getCollectionEdgeInsets].left;
    self.itemMaxY = [self getCollectionEdgeInsets].top;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<itemCount; ++i) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.attrsArray addObject:attr];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    CGSize itemSize = [self.delegate getContentSize:self indexPath:indexPath];
    //itemsize 宽度大于剩余宽度
    if (collectionViewWidth - self.itemMaxX - [self getCollectionEdgeInsets].right < itemSize.width) {
        //maxX重置为边距
        self.itemMaxX = [self getCollectionEdgeInsets].left;
        //maxY加item的高度和行间距  换行
        self.itemMaxY += itemSize.height + [self getminimumLineSpacing];
        
    }else {
        //当前item不是这一行的第一个item
        if (self.itemMaxX != [self getCollectionEdgeInsets].left) {
            self.itemMaxX += [self getMinimumInteritemSpacing] ;
        }
    }
    attr.frame = CGRectMake(self.itemMaxX, self.itemMaxY, itemSize.width, itemSize.height);
    self.itemMaxX = CGRectGetMaxX(attr.frame);
    self.contentHeight = self.itemMaxY + itemSize.height;
    return attr;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + [self getCollectionEdgeInsets].bottom);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _attrsArray;
}

@end
