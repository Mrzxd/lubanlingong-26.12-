//
//  MapTableCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapTableCell : UITableViewCell

@property (nonatomic, strong) UIView *pointView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *stressLabel;

@end

NS_ASSUME_NONNULL_END
