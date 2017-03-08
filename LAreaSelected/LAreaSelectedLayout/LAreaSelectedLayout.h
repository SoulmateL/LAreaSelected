//
//  LAreaSelectedLayout.h
//  LAreaSelected
//
//  Created by 俊杰  廖 on 2017/3/7.
//  Copyright © 2017年 俊杰  廖. All rights reserved.
//


#import <UIKit/UIKit.h>
@protocol LAreaSelectedDelegate<NSObject>

@required

- (CGSize)getContentSize:(UICollectionViewLayout *)layout indexPath:(NSIndexPath *)indexPath;

@optional

- (CGFloat)minimumLineSpacing:(UICollectionViewLayout *)layout;

- (CGFloat)minimumInteritemSpacing:(UICollectionViewLayout *)layout;

- (UIEdgeInsets)collectionEdgeInsets:(UICollectionViewLayout *)layout;

@end

@interface LAreaSelectedLayout : UICollectionViewLayout

@property (nonatomic,weak) id<LAreaSelectedDelegate> delegate;

@end
