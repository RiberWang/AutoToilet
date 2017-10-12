//
//  RBBottomItemView.m
//  AutoToilet
//
//  Created by Riber on 2017/10/13.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import "RBBottomItemView.h"
#import "PrefixHeader.h"

@interface RBBottomItemView ()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemTitleLabel;


@property (nonatomic, copy) NSString *itemImageName;
@property (nonatomic, copy) NSString *itemTitle;

@end

@implementation RBBottomItemView

- (instancetype)initWithFrame:(CGRect)frame andItemImageName:(NSString *)itemImageName itemTitle:(NSString *)itemTitle {
    if (self = [super initWithFrame:frame]) {
        self.itemImageName = itemImageName;
        self.itemTitle = itemTitle;
        
        [self createUI];
        [self addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)createUI {
    self.itemTitleLabel = [[UILabel alloc] init];
    self.itemTitleLabel.text = self.itemTitle;
    self.itemTitleLabel.textColor = [UIColor whiteColor];
    self.itemTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.itemTitleLabel.font = [UIFont systemFontOfSize:kWidth(17)];
    [self addSubview:self.itemTitleLabel];
    
    [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).with.offset(0);
        make.bottom.equalTo(self).with.offset(0);
        make.height.mas_equalTo(kHeight(16));
    }];
    
    self.itemImageView = [[UIImageView alloc] init];
    self.itemImageView.image = RBImageNamed(self.itemImageName);
    [self addSubview:self.itemImageView];
    
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).with.offset(0);
        make.bottom.equalTo(self.itemTitleLabel.mas_top).with.offset(-kHeight(5));
        make.size.mas_equalTo(CGSizeMake(kWidth(89), kWidth(89)));
    }];
    
}

- (void)itemClick:(UIControl *)control {
    NSLog(@"%zi", control.tag);
    
}

@end
