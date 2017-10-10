//
//  RBMiddleItemView.h
//  AutoToilet
//
//  Created by Riber on 2017/10/10.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

typedef void(^RBMiddleItemIncreaseButtonClickBlock)();
typedef void(^RBMiddleItemReduceButtonClickBlock)();

@interface RBMiddleItemView : UIView

@property (nonatomic, copy) RBMiddleItemIncreaseButtonClickBlock increaseBlcok;
@property (nonatomic, copy) RBMiddleItemReduceButtonClickBlock reduceBlcok;

@end
