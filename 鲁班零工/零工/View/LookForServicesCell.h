//
//  LookForServicesCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/19.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LookingForListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LookForServicesCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *modeLabel;

@property (nonatomic, strong) LookingForListModel *listModel;

@end

NS_ASSUME_NONNULL_END
