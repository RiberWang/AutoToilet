//
//  RBRootViewController.m
//  AutoToilet
//
//  Created by Riber on 2017/10/9.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import "RBRootViewController.h"
#import "PrefixHeader.h"

#import "RBTopItemView.h"
#import "RBMiddleItemView.h"
#import "RBBottomItemView.h"

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
@property (nonatomic, strong) RBBottomItemView *tbQingXiView;
@property (nonatomic, strong) RBBottomItemView *nxZhuanYongView;
@property (nonatomic, strong) RBBottomItemView *anmoView;
@property (nonatomic, strong) RBBottomItemView *stopView;



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
    
    self.rank = 1;

    [self createUI];
    [self setContentOfData];
}

- (void)createUI {
    [self createTopView];
    [self createMiddleView];
    [self createBottomView];
}

- (void)setContentOfData {
    self.waterView.temperature = 32;
    self.pressureView.isRank = YES;
    self.pressureView.temperature = 1;
    self.winterView.temperature = 30;
    self.sitView.temperature = 28;
}

- (void)createTopView {
    CGFloat width = kSCREENW/4;
    CGFloat height = kHeight(280);
    self.waterView = [[RBTopItemView alloc] initWithFrame:CGRectMake(0, 0, width, height) andTitle:@"水温"];
    [self.bgScrollView addSubview:self.waterView];
    
    self.pressureView = [[RBTopItemView alloc] initWithFrame:CGRectMake(self.waterView.maxX, self.waterView.y, width, height) andTitle:@"水压"];
    [self.bgScrollView addSubview:self.pressureView];
    
    self.winterView = [[RBTopItemView alloc] initWithFrame:CGRectMake(self.pressureView.maxX, self.waterView.y, width, height) andTitle:@"风温"];
    [self.bgScrollView addSubview:self.winterView];
    
    self.sitView = [[RBTopItemView alloc] initWithFrame:CGRectMake(self.winterView.maxX, self.waterView.y, width, height) andTitle:@"坐温"];
    self.sitView.isHaveRightLine = NO;
    [self.bgScrollView addSubview:self.sitView];
    
    self.topLineView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(10), height - 0.5, kSCREENW - 2*kWidth(10), 0.5)];
    self.topLineView.backgroundColor = RBLineColor;
    [self.bgScrollView addSubview:self.topLineView];
}

- (void)createMiddleView {
    self.middleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.waterView.maxY, kSCREENW, kHeight(105))];
    self.middleView.backgroundColor = rgb(246, 249, 250);
    [self.bgScrollView addSubview:self.middleView];
    
    self.rankItemView = [[RBMiddleItemView alloc] initWithFrame:CGRectMake(kWidth(10), (self.middleView.height - kHeight(67))/2, kWidth(152), kHeight(67))];
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
    
    self.rankImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREENW - kWidth(193) - kWidth(12), (self.middleView.height - kHeight(31))/2, kWidth(193), kHeight(31))];
    self.rankImageView.image = RBImageNamed(@"middlerank1");
    [self.middleView addSubview:self.rankImageView];
}

- (void)createBottomView {
    CGFloat margin = (kSCREENW - 4*kWidth(89))/5;
    
    self.bottomBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.middleView.maxY, kSCREENW, kHeight(645))];
    self.bottomBgImageView.image = RBImageNamed(@"bottombgimage");
    self.bottomBgImageView.userInteractionEnabled = YES;
    [self.bgScrollView addSubview:self.bottomBgImageView];
    
    self.bgScrollView.contentSize = CGSizeMake(0, self.middleView.maxY + self.bottomBgImageView.height);
    
    // 布局子视图
    CGFloat itemWidth = kWidth(89);
    CGFloat itemHeight = kHeight(150);
    self.tbQingXiView = [[RBBottomItemView alloc] initWithFrame:CGRectMake(margin, 0, itemWidth, itemHeight) andItemImageName:@"at_tbqingxi" itemTitle:@"臀部清洗"];
    self.tbQingXiView.tag = 0;
    [self.bottomBgImageView addSubview:self.tbQingXiView];
    
    self.nxZhuanYongView = [[RBBottomItemView alloc] initWithFrame:CGRectMake(self.tbQingXiView.maxX + margin, self.tbQingXiView.y, itemWidth, itemHeight) andItemImageName:@"at_nvzhuanyong" itemTitle:@"女性专用"];
    self.nxZhuanYongView.tag = 1;
    [self.bottomBgImageView addSubview:self.nxZhuanYongView];

    self.anmoView = [[RBBottomItemView alloc] initWithFrame:CGRectMake(self.nxZhuanYongView.maxX + margin, self.tbQingXiView.y, itemWidth, itemHeight) andItemImageName:@"at_anmo" itemTitle:@"按摩"];
    self.anmoView.tag = 2;
    [self.bottomBgImageView addSubview:self.anmoView];

    self.stopView = [[RBBottomItemView alloc] initWithFrame:CGRectMake(self.anmoView.maxX + margin, self.tbQingXiView.y, itemWidth, itemHeight) andItemImageName:@"at_stop" itemTitle:@"停止"];
    self.stopView.tag = 3;
    [self.bottomBgImageView addSubview:self.stopView];
}



@end
