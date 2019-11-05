//
//  OddJobCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/14.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^GrabdDetailsBlock)(id model);
@interface OddJobCell : UITableViewCell
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) GrabdDetailsBlock detailBlock;
@end

NS_ASSUME_NONNULL_END
