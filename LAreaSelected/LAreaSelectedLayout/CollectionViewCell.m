//
//  CollectionViewCell.m
//  LAreaSelected
//
//  Created by 俊杰  廖 on 2017/3/7.
//  Copyright © 2017年 俊杰  廖. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.cornerRadius = 7;
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.font = [UIFont systemFontOfSize:17];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor grayColor];
        [self.label sizeToFit];
        [self.contentView addSubview:self.label];
    }
    return self;
}
@end
