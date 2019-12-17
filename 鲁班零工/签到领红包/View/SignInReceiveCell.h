//
//  SignInReceiveCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/11/22.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "PageContentListModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignInReceiveCell : UITableViewCell

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) PageContentListModel *listModel;

@end

NS_ASSUME_NONNULL_END
