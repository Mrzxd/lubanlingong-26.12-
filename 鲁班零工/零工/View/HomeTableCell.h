//
//  HomeTableCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/12.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^GrabdDetailsBlock)(id model);

@interface HomeTableCell : UITableViewCell

@property (nonatomic, strong) GrabdDetailsBlock detailBlock;
@property (nonatomic, strong) PageContentListModel *listModel;

@end

NS_ASSUME_NONNULL_END
