//
//  RBRootViewController.m
//  AutoToilet
//
//  Created by Riber on 2017/10/9.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import "RBRootViewController.h"
#import "Masonry.h"
#import "RBTopItemView.h"
#import "PrefixHeader.h"

@interface RBRootViewController ()

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) RBTopItemView *waterView;


@end

@implementation RBRootViewController

- (UIScrollView *)bgScrollView {
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.backgroundColor = [UIColor clearColor];
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)createUI {
    self.waterView = [[RBTopItemView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW/4, kHeight(280)) andTitle:@"水温"];
    [self.bgScrollView addSubview:self.waterView];
}



@end
