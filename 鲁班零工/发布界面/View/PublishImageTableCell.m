//
//  ImageTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
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
    _imageButton = [[UIButton alloc] initWithFrame:AutoFrame(15, 15, 100, 100)];
    [_imageButton setImage:[UIImage imageNamed:@"imageButton.png"] forState:UIControlStateNormal];
    _imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageButton.tag = 300;
    [_imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_imageButton];
    
    _imageButton1 = [[UIButton alloc] initWithFrame:AutoFrame(138, 15, 100, 100)];
    _imageButton1.hidden = YES;
    _imageButton1.tag = 301;
    [_imageButton1 setImage:[UIImage imageNamed:@"imageButton.png"] forState:UIControlStateNormal];
    [_imageButton1 addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _imageButton1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageButton1];
    
    _imageButton2 = [[UIButton alloc] initWithFrame:AutoFrame(260, 15, 100, 100)];
    _imageButton2.hidden = YES;
    _imageButton2.tag = 302;
    [_imageButton2 setImage:[UIImage imageNamed:@"imageButton.png"] forState:UIControlStateNormal];
    [_imageButton2 addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _imageButton2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageButton2];
}
- (void)imageButtonAction:(UIButton *)button {
    if (_buttonBlock) {
        _buttonBlock(button);
    }
}

@end
