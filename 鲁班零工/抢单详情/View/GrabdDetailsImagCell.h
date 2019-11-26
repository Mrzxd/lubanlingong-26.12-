//
//  ImageTableCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrabdDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoadImageBlock)(CGFloat cellHeight);

@interface GrabdDetailsImagCell : UITableViewCell

@property (nonatomic, strong) GrabdDetailsModel *detailModel;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) LoadImageBlock imageBlock;

@end

NS_ASSUME_NONNULL_END
