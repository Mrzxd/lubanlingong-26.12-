//
//  EmployerCenterOrderDetailCell3.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/25.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "EmployerCenterOrderDetailCell3.h"

@implementation EmployerCenterOrderDetailCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGBHex(0xF7F7F7);
        self.contentView.backgroundColor = RGBHex(0xF7F7F7);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    };
    return self;
}

- (void)setUI {
    UIView *contentView = [[UIView alloc] initWithFrame:AutoFrame(7.5, 0, 360, 160)];
    contentView.backgroundColor = UIColor.whiteColor;
    contentView.layer.cornerRadius = 5;
    [self.contentView addSubview:contentView];
    
    
    UILabel *_typelabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 15, 100, 14)];
    _typelabel.font = [UIFont boldSystemFontOfSize:14 *ScalePpth];
    _typelabel.textColor = RGBHex(0x333333);
    _typelabel.text = @"照片信息";
    [contentView addSubview:_typelabel];
    [contentView addSubview:self.imageView1];
    [contentView addSubview:self.imageView2];
    [contentView addSubview:self.imageView3];
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] initWithFrame:AutoFrame(15, 44, 100, 100)];
        _imageView1.contentMode = UIViewContentModeScaleAspectFit;
        _imageView1.image = [UIImage imageNamed:@"photoImage1.png"];
    }
    return _imageView1;
}
- (UIImageView *)imageView2 {
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] initWithFrame:AutoFrame(130, 44, 100, 100)];
        _imageView2.contentMode = UIViewContentModeScaleAspectFit;
        _imageView2.image = [UIImage imageNamed:@"photoImage2.png"];
    }
    return _imageView2;
}
- (UIImageView *)imageView3 {
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] initWithFrame:AutoFrame(245, 44, 100, 100)];
        _imageView3.contentMode = UIViewContentModeScaleAspectFit;
        _imageView3.image = [UIImage imageNamed:@"photoImage2.png"];
    }
    return _imageView3;
}
@end
