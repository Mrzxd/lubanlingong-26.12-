//
//  RemingView.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/13.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PublishBlock)(NSInteger index);

@interface RemingView : UIView

@property (nonatomic, strong) PublishBlock block;

@end

NS_ASSUME_NONNULL_END
