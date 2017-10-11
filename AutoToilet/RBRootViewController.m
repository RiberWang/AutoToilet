//
//  RBRootViewController.m
//  AutoToilet
//
//  Created by Riber on 2017/10/9.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import "RBRootViewController.h"
#import "RBTopItemView.h"
#import "PrefixHeader.h"

#import "RBMiddleItemView.h"

@interface RBRootViewController ()

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) RBTopItemView *waterView;
@property (nonatomic, strong) RBTopItemView *pressureView;
@property (nonatomic, strong) RBTopItemView *winterView;
@property (nonatomic, strong) RBTopItemView *sitView;
@property (nonatomic, strong) UIView *topLineView;

@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) RBMiddleItemView *rankItemView;
@property (nonatomic, strong) UIImageView *rankImageView;
@property (nonatomic, assign) NSInteger rank;

@property (nonatomic, strong) UIImageView *bottomBgImageView;


@end

@implementation RBRootViewController

- (UIScrollView *)bgScrollView {
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.backgroundColor = [UIColor clearColor];
//        _bgScrollView.bounces = NO;
        [self.view addSubview:_bgScrollView];
        
        [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
    }
    
    return _bgScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"遥控器";
    self.view.backgroundColor = rgb(246, 249, 250);
    
    [self createUI];
    self.rank = 1;
}

- (void)createUI {
    CGFloat width = kSCREENW/4;
    CGFloat height = kHeight(280);
    self.waterView = [[RBTopItemView alloc] initWithFrame:CGRectMake(0, 0, width, height) andTitle:@"水温"];
    [self.bgScrollView addSubview:self.waterView];
    
    self.pressureView = [[RBTopItemView alloc] initWithFrame:CGRectMake(kSCREENW/4, self.waterView.y, width, height) andTitle:@"水压"];
    [self.bgScrollView addSubview:self.pressureView];

    self.winterView = [[RBTopItemView alloc] initWithFrame:CGRectMake(2*kSCREENW/4, self.waterView.y, width, height) andTitle:@"风温"];
    [self.bgScrollView addSubview:self.winterView];

    self.sitView = [[RBTopItemView alloc] initWithFrame:CGRectMake(3*kSCREENW/4, self.waterView.y, width, height) andTitle:@"坐温"];
    self.sitView.isHaveRightLine = NO;
    [self.bgScrollView addSubview:self.sitView];
    
    self.topLineView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(10), height - 0.5, kSCREENW - 2*kWidth(10), 0.5)];
    self.topLineView.backgroundColor = RBLineColor;
    [self.bgScrollView addSubview:self.topLineView];
    
    self.middleView = [[UIView alloc] initWithFrame:CGRectMake(0, height, kSCREENW, kHeight(105))];
    self.middleView.backgroundColor = rgb(246, 249, 250);
    [self.bgScrollView addSubview:self.middleView];
    
    self.rankItemView = [[RBMiddleItemView alloc] initWithFrame:CGRectMake(kWidth(10), kHeight(105 - 67)/2, kWidth(152), kHeight(67))];
    [self.middleView addSubview:self.rankItemView];
    
    RBWeakSelf;
    self.rankItemView.increaseBlcok = ^() {
        if (weakSelf.rank < 5) {
            weakSelf.rank++;
        }
        else
        {
            weakSelf.rank = 5;
        }
        NSString *imageName = [NSString stringWithFormat:@"middlerank%ld", weakSelf.rank];

        weakSelf.rankImageView.image = RBImageNamed(imageName);
    };
    
    self.rankItemView.reduceBlcok = ^() {
        if (weakSelf.rank <= 1) {
            weakSelf.rank = 1;
        }
        else
        {
            weakSelf.rank--;
        }
        NSString *imageName = [NSString stringWithFormat:@"middlerank%ld", weakSelf.rank];
        
        weakSelf.rankImageView.image = RBImageNamed(imageName);
    };
    
    self.rankImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREENW - kWidth(193) - kWidth(12), kHeight(105 - 31)/2, kWidth(193), kHeight(31))];
    self.rankImageView.image = RBImageNamed(@"middlerank1");
    [self.middleView addSubview:self.rankImageView];
    
    self.bottomBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height + kHeight(105), kSCREENW, kHeight(645))];
    self.bottomBgImageView.image = RBImageNamed(@"bottombgimage");
    [self.bgScrollView addSubview:self.bottomBgImageView];
    
    self.bgScrollView.contentSize = CGSizeMake(0, height + kHeight(105) + kHeight(645));
    
    
    self.waterView.temperature = 32;
    self.winterView.temperature = 30;
    self.pressureView.isRank = YES;
    self.pressureView.temperature = 100;
    self.sitView.temperature = 28;

}



@end
