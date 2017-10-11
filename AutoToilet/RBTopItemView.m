//
//  RBTopItemView.m
//  AutoToilet
//
//  Created by Riber on 2017/10/9.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import "RBTopItemView.h"
#import "PrefixHeader.h"



@interface RBTopItemView ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *rankLabel; /**< 级别或温度 */
@property (nonatomic, strong) UILabel *titleLabel; /**< 标题 */
@property (nonatomic, strong) UIImageView *buttonBgImageView; /**< 按钮底部背景图 */
@property (nonatomic, strong) UIButton *increaseButton; /**< 增加按钮 */
@property (nonatomic, strong) UILabel *typeLabel; /**< 类型标题 */
@property (nonatomic, strong) UIButton *reduceButton; /**< 减少按钮 */

@property (nonatomic, strong) UIView *rightLineView; /**< 右边的分割线 */

@property (nonatomic, assign) CGFloat currentTemperature; /** 当前温度 */


@end

@implementation RBTopItemView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = rgb(246, 249, 250);
        self.title = title;
        
        [self defaultValueSet];
        [self createUI];
        [self setContentOfView];
    }
    
    return self;
}

- (void)defaultValueSet {
    self.isHaveRightLine = YES;
    self.step = 20;
    self.currentTemperature = self.temperature;
}

- (void)setIsHaveRightLine:(BOOL)isHaveRightLine {
    _isHaveRightLine = isHaveRightLine;
    
    self.rightLineView.hidden = !isHaveRightLine;
}

- (void)setIsRank:(BOOL)isRank {
    _isRank = isRank;
}

- (void)setTemperature:(CGFloat)temperature {
    _temperature = temperature;
    
    self.currentTemperature = _temperature;
    
    [self judgeIsRankAndSetValue];
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
    
    self.buttonBgImageView = [[UIImageView alloc] initWithImage:RBImageNamed(@"itembgimage")];
    self.buttonBgImageView.userInteractionEnabled = YES;
    [self addSubview:self.buttonBgImageView];
    
    [self.buttonBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(kHeight(15));
        make.centerX.equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kWidth(67), kHeight(152)));
    }];
    
    self.increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.increaseButton setImage:RBImageNamed(@"increaseup_n") forState:UIControlStateNormal];
    [self.increaseButton setImage:RBImageNamed(@"increaseup_s") forState:UIControlStateSelected];
    [self.increaseButton addTarget:self action:@selector(increaseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonBgImageView addSubview:self.increaseButton];
    
    [self.increaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonBgImageView).with.offset(0);
        make.left.right.equalTo(self.buttonBgImageView).with.offset(0);
        make.height.mas_equalTo(kHeight(50));
    }];
    
    self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reduceButton setImage:RBImageNamed(@"reducedown_n") forState:UIControlStateNormal];
    [self.reduceButton setImage:RBImageNamed(@"reducedown_s") forState:UIControlStateSelected];
    [self.reduceButton addTarget:self action:@selector(reduceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonBgImageView addSubview:self.reduceButton];
    
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.buttonBgImageView).with.offset(0);
        make.left.right.equalTo(self.buttonBgImageView).with.offset(0);
        make.height.mas_equalTo(kHeight(50));
    }];
    
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.numberOfLines = 0;
    [self setLabel:self.typeLabel andTextAlignment:NSTextAlignmentCenter andTextColor:rgb(84, 92, 103) fontOfSystemSize:kWidth(16)];
    [self.buttonBgImageView addSubview:self.typeLabel];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.increaseButton.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.reduceButton.mas_top).with.offset(0);
        make.centerX.equalTo(self.buttonBgImageView).with.offset(0);
        make.width.mas_equalTo(kWidth(15));
    }];
    
    self.rightLineView = [[UIView alloc] init];
    self.rightLineView.backgroundColor = RBLineColor;
    [self addSubview:self.rightLineView];
    
    [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(kHeight(23));
        make.bottom.equalTo(self).with.offset(-kHeight(23));
        make.right.equalTo(self).with.offset(0);
        make.width.mas_equalTo(0.5);
    }];
}

- (void)setContentOfView {
    self.titleLabel.text = self.title;
    self.typeLabel.text = self.title;
}

- (void)increaseButtonClick:(UIButton *)increaseButton {
    self.increaseButton.selected = YES;
    self.reduceButton.selected = NO;
    
    if (self.isRank) {
        if (self.currentTemperature >= 60) {
            self.currentTemperature = 60;
        }
        else
        {
            self.currentTemperature += self.step;
        }
    }
    else
    {
        self.currentTemperature += self.step;
    }
    
    [self judgeIsRankAndSetValue];
}

- (void)reduceButtonClick:(UIButton *)reduceButton {
    self.reduceButton.selected = YES;
    self.increaseButton.selected = NO;

    if (self.currentTemperature <= 0) {
        self.currentTemperature = 0;
    }
    else
    {
        self.currentTemperature -= self.step;
    }

    [self judgeIsRankAndSetValue];
}

// 判断是否是级别
- (void)judgeIsRankAndSetValue {
    if (self.isRank) {
        if (self.currentTemperature >= 0 && self.currentTemperature <= 20) {
            self.rankLabel.text = [NSString stringWithFormat:@"1 级"];
        }
        else if (self.currentTemperature > 20 && self.currentTemperature <= 40)
        {
            self.rankLabel.text = [NSString stringWithFormat:@"2 级"];
        }
        else
        {
            self.rankLabel.text = [NSString stringWithFormat:@"3 级"];
        }
    }
    else
    {
        self.rankLabel.text = [NSString stringWithFormat:@"%.0f°C", self.currentTemperature];
    }
}


- (void)setAllSelectedNo {
    self.increaseButton.selected = NO;
    self.reduceButton.selected = NO;
}

- (void)setLabel:(UILabel *)factoryLabel andTextAlignment:(NSTextAlignment)textAlignment andTextColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize {
    factoryLabel.textColor = color;
    factoryLabel.font = [UIFont systemFontOfSize:fontSize];
    factoryLabel.textAlignment = textAlignment;
}

@end
