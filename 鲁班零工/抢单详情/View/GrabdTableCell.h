//
//  GrabdTableCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "GrabdDetailsModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GrabdTableCell : UITableViewCell

@property (nonatomic, strong) GrabdDetailsModel *detailModel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *sendLabel;
@end

NS_ASSUME_NONNULL_END
