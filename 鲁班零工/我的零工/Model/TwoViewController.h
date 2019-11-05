//
//  TwoViewController.h
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//

#import "ZXDBaseViewController.h"

typedef void (^OrderDetailBlock)(NSInteger type);

@interface TwoViewController : ZXDBaseViewController

@property (nonatomic, strong) OrderDetailBlock orderDetailBlock;

@end
