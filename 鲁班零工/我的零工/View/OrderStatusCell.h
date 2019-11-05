//
//  OrderStatusCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/22.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderStatusCell : UITableViewCell

@property (nonatomic, strong) UIButton *startWorkButton;
@property (nonatomic, strong) UIButton *MiddleButton;
@property (nonatomic, strong) UIButton *stateButton;
@property (nonatomic, strong) UILabel *waitLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *saleLabel;
@property (nonatomic, strong) UILabel *timeCTLabel;
@property (nonatomic, strong) UILabel *saleCTLabel;

@end

NS_ASSUME_NONNULL_END
