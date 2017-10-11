//
//  RBTopItemView.h
//  AutoToilet
//
//  Created by Riber on 2017/10/9.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBTopItemView : UIView

@property (nonatomic, assign) BOOL isHaveRightLine;
@property (nonatomic, assign) BOOL isRank; /** 是否是水压级别 */

@property (nonatomic, assign) CGFloat temperature;

@property (nonatomic, assign) CGFloat step;


- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;

- (void)setAllSelectedNo;

@end
