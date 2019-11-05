
//
//  EmployerCertificationThreeCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/17.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "EmployerCertificationThreeCell.h"

@implementation EmployerCertificationThreeCell

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
    UILabel *_nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 20, 80, 15)];
    _nameLabel.font  = [UIFont systemFontOfSize:15*ScalePpth];
    _nameLabel.textColor = RGBHex(0x333333);
    _nameLabel.text = @"身份证照片";
    [self.contentView addSubview:_nameLabel];
    
    UIButton *fullfacePhoto = [[UIButton alloc] initWithFrame:AutoFrame(90, 50, 196, 126)];
    [fullfacePhoto setImage:[UIImage imageNamed:@"front"] forState:UIControlStateNormal];
    fullfacePhoto.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:fullfacePhoto];
    
    UILabel *fullfacePhotoLabel = [[UILabel alloc] initWithFrame:AutoFrame(100, 190, 175, 13)];
    fullfacePhotoLabel.font  = [UIFont systemFontOfSize:13*ScalePpth];
    fullfacePhotoLabel.textColor = RGBHex(0xcccccc);
    fullfacePhotoLabel.text = @"上传身份证正面照";
    fullfacePhotoLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:fullfacePhotoLabel];
    
    UIButton *negativePhoto = [[UIButton alloc] initWithFrame:AutoFrame(90, 241, 196, 126)];
    [negativePhoto setImage:[UIImage imageNamed:@"contrary"] forState:UIControlStateNormal];
    negativePhoto.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:negativePhoto];
    
    UILabel *negativePhotoLabel = [[UILabel alloc] initWithFrame:AutoFrame(100, 381, 175, 13)];
    negativePhotoLabel.font  = [UIFont systemFontOfSize:13*ScalePpth];
    negativePhotoLabel.textColor = RGBHex(0xcccccc);
    negativePhotoLabel.text = @"上传身份证反面照";
    negativePhotoLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:negativePhotoLabel];
    
}

- (void)setIsServiceAuthenticationController:(BOOL)isServiceAuthenticationController {
    _isServiceAuthenticationController = isServiceAuthenticationController;
    if (isServiceAuthenticationController) {
        UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(38*ScalePpth, self.frame.size.height - 75*ScalePpth, 300*ScalePpth, 45*ScalePpth)];
        [loginButton setTitle:@"提交" forState:UIControlStateNormal];
        [loginButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        loginButton.titleLabel.font = FontSize(17);
        loginButton.backgroundColor = RGBHex(0xFFD301);
        loginButton.layer.cornerRadius = 45.0/2*ScalePpth;
        loginButton.layer.masksToBounds = YES;
        loginButton.clipsToBounds = YES;
        [self.contentView addSubview:loginButton];
    }
}

@end
