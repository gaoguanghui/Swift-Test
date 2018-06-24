//
//  CollectionViewCell.m
//  弹出选择框
//
//  Created by jinjin on 2018/6/23.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = UIColor.blueColor;
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_label];
    }
    return self;
}

@end
