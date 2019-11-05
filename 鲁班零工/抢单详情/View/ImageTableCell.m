

//
//  ImageTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "PublishImageTableCell.h"

@implementation PublishImageTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, 0, 375, 188)];
    firstImageView.contentMode = UIViewContentModeScaleAspectFit;
    firstImageView.image = [UIImage imageNamed:@"firstImage.png"];
    [self.contentView addSubview:firstImageView];
    
    UIImageView *secondImageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, (188 + 5), 375, 188)];
    secondImageView.contentMode = UIViewContentModeScaleAspectFit;
    secondImageView.image = [UIImage imageNamed:@"second.png"];
    [self.contentView addSubview:secondImageView];
}

@end
