
//
//  MineTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/13.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "MineTableCell.h"

@implementation MineTableCell {
    UIImageView *imageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}

- (void)setUI {
    
    imageView = [[UIImageView alloc] initWithFrame:AutoFrame(15, 19, 17, 19)];
    [self.contentView addSubview:imageView];
    
    self.textLabels = [[UILabel alloc] initWithFrame:AutoFrame(46, 21, 100, 15)];
    self.textLabels.textColor = [UIColor blackColor];
    self.textLabels.font  = FontSize(15);
    [self.contentView addSubview:self.textLabels];
}

- (void)setImages:(NSString *)images {
    _images = images;
    imageView.image = [UIImage imageNamed:images];
    [imageView sizeToFit];
}

@end
