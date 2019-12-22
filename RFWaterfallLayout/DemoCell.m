//
//  DemoCell.m
//  RFWaterfallLayout
//
//  Created by archerLj on 2019/12/22.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "DemoCell.h"

@interface DemoCell()
@property (nonatomic, strong) UIView *view1;
@end

@implementation DemoCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.view1 = [[UIView alloc] init];
        self.view1.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.view1];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.view1.frame = self.contentView.bounds;
}

@end
