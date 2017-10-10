//
//  RBTopItemView.m
//  AutoToilet
//
//  Created by Riber on 2017/10/9.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import "RBTopItemView.h"
#import "Masonry.h"
#import "PrefixHeader.h"



@interface RBTopItemView ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *rankLabel; /**< 级别或温度 */
@property (nonatomic, strong) UILabel *titleLabel; /**< 标题 */
@property (nonatomic, strong) UIImageView *bgImageView; /**< 底部背景图 */
@property (nonatomic, strong) UIButton *increaseButton; /**< 增加按钮 */
@property (nonatomic, strong) UILabel *typeLabel; /**< 类型标题 */
@property (nonatomic, strong) UIButton *reduceButton; /**< 减少按钮 */


@end

@implementation RBTopItemView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        
        [self createUI];
        [self setContentOfView];
    }
    
    return self;
}

- (void)createUI {
    self.rankLabel = [[UILabel alloc] init];
    [self setLabel:self.rankLabel andTextAlignment:NSTextAlignmentCenter andTextColor:rgb(144, 157, 174) fontOfSystemSize:kWidth(23)];
    [self addSubview:self.rankLabel];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(kHeight(32));
        make.left.right.equalTo(self).with.offset(0);
        make.height.mas_equalTo(kHeight(20));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    [self setLabel:self.titleLabel andTextAlignment:NSTextAlignmentCenter andTextColor:rgb(84, 92, 103) fontOfSystemSize:kWidth(17)];
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rankLabel.mas_bottom).with.offset(kHeight(15));
        make.left.right.equalTo(self).with.offset(0);
        make.height.mas_equalTo(kHeight(20));
    }];
    
    
    self.bgImageView = [[UIImageView alloc] initWithImage:RBImageNamed(@"")];
    self.bgImageView.userInteractionEnabled = YES;
    [self addSubview:self.bgImageView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(kHeight(15));
        make.centerX.equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kWidth(67), kHeight(152)));
    }];
}

- (void)setContentOfView {
    
}

- (void)setLabel:(UILabel *)factoryLabel andTextAlignment:(NSTextAlignment)textAlignment andTextColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize {
    factoryLabel.textColor = color;
    factoryLabel.font = [UIFont systemFontOfSize:fontSize];
    factoryLabel.textAlignment = textAlignment;
}


@end
