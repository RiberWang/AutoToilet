//
//  RBMiddleItemView.m
//  AutoToilet
//
//  Created by Riber on 2017/10/10.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import "RBMiddleItemView.h"
#import "PrefixHeader.h"
#import "Masonry.h"

@interface RBMiddleItemView ()

@property (nonatomic, strong) UIImageView *buttonBgImageView; /**< 按钮底部背景图 */
@property (nonatomic, strong) UIButton *increaseButton; /**< 增加按钮 */
@property (nonatomic, strong) UILabel *titleLabel; /**< 类型标题 */
@property (nonatomic, strong) UIButton *reduceButton; /**< 减少按钮 */

@end

@implementation RBMiddleItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI {
    self.buttonBgImageView = [[UIImageView alloc] initWithImage:RBImageNamed(@"middlebuttonbgimage")];
    self.buttonBgImageView.userInteractionEnabled = YES;
    [self addSubview:self.buttonBgImageView];
    
    [self.buttonBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
    
    self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reduceButton setImage:RBImageNamed(@"reduceleft_n") forState:UIControlStateNormal];
    [self.reduceButton setImage:RBImageNamed(@"reduceleft_s") forState:UIControlStateSelected];
    [self.reduceButton addTarget:self action:@selector(reduceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonBgImageView addSubview:self.reduceButton];
    
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.buttonBgImageView).with.offset(0);
        make.left.equalTo(self.buttonBgImageView).with.offset(0);
        make.width.mas_equalTo(kWidth(50));
    }];
    
    self.increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.increaseButton setImage:RBImageNamed(@"increaseright_n") forState:UIControlStateNormal];
    [self.increaseButton setImage:RBImageNamed(@"increaseright_s") forState:UIControlStateSelected];
    [self.increaseButton addTarget:self action:@selector(increaseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonBgImageView addSubview:self.increaseButton];
    
    [self.increaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.buttonBgImageView).with.offset(0);
        make.right.equalTo(self.buttonBgImageView).with.offset(0);
        make.width.mas_equalTo(kWidth(50));
    }];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = rgb(84, 92, 103);
    self.titleLabel.font = [UIFont systemFontOfSize:kWidth(16)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.buttonBgImageView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reduceButton.mas_right).with.offset(0);
        make.right.equalTo(self.increaseButton.mas_left).with.offset(0);
        make.top.bottom.equalTo(self.buttonBgImageView).with.offset(0);
    }];
    
    self.titleLabel.text = @"管位";
}

- (void)increaseButtonClick:(UIButton *)increaseButton {
    self.increaseButton.selected = YES;
    self.reduceButton.selected = NO;
    
    if (self.increaseBlcok) {
        self.increaseBlcok();
    }
    else
    {
        NSLog(@"Block is not exist!");
    }
}

- (void)reduceButtonClick:(UIButton *)reduceButton {
    self.reduceButton.selected = YES;
    self.increaseButton.selected = NO;
    
    if (self.reduceBlcok) {
        self.reduceBlcok();
    }
    else
    {
        NSLog(@"Block is not exist!");
    }
}

@end
