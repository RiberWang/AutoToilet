//
//  PrefixHeader.h
//  AutoToilet
//
//  Created by Riber on 2017/10/9.
//  Copyright © 2017年 Riber. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

#import "UIView+Extension.h"
#import "Masonry.h"



#define kSCREENW [UIScreen mainScreen].bounds.size.width
#define kSCREENH [UIScreen mainScreen].bounds.size.height
#define kWidth(iphone6Width) (iphone6Width)*kSCREENW/375
#define kHeight(iphone6Height) (iphone6Height)*kSCREENH/667

#define rgba(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define rgb(r, g, b)  rgba(r, g, b, 1.0f)
#define RBLineColor  rgb(217, 224, 233)

#define RBImageNamed(imageName) imageName?[UIImage imageNamed:(imageName)]:[UIImage imageNamed:@""]

#define RBWeakObj(obj) @autoreleasepool{} __weak typeof(obj) weak##obj = obj;
#define RBWeakSelf @autoreleasepool{} __weak typeof(self) weakSelf = self;


#endif /* PrefixHeader_h */
