//
//  EmployerCertificationThreeCell.h
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface EmployerCertificationThreeCell : UITableViewCell

@property (nonatomic, assign) BOOL isServiceAuthenticationController;
@property (nonatomic, strong) PhotoBlock photoBlock;
@property (nonatomic, strong) UIButton *fullfacePhoto;
@property (nonatomic, strong) UIButton *negativePhoto;

@end

NS_ASSUME_NONNULL_END
