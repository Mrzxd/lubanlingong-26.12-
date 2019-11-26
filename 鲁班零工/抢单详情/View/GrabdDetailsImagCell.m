

//
//  ImageTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "GrabdDetailsImagCell.h"

@implementation GrabdDetailsImagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
         [self setUpUI];
    }
    return self;
}
- (void)setDetailModel:(GrabdDetailsModel *)detailModel {
    _detailModel = detailModel;
    if (detailModel) {
        [self setUpUI];
    }
}
- (void)setUpUI {
    WeakSelf;
     __block UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, (188 + 5), 375, 188)];
    if (_detailModel.imgLink) {
        [self.contentView addSubview:firstImageView];
        [firstImageView sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:_detailModel.imgLink]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                firstImageView.frame = CGRectMake(0, 0, image.size.width<ScreenWidth?:ScreenWidth, image.size.height/( image.size.width/ScreenWidth));
                if (image.size.width < ScreenWidth) {
                     firstImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                }
                weakSelf.cellHeight = image.size.height/( image.size.width/ScreenWidth) +5*ScalePpth;
                if (weakSelf.imageBlock) {
                    weakSelf.imageBlock(weakSelf.cellHeight);
                }
            }
        }];
    }
    UIImageView *secondImageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, (188 + 5), 375, 188)];
    if (_detailModel.imgLink2) {
          [self.contentView addSubview:secondImageView];
        [secondImageView sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:_detailModel.imgLink2]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                   if (image) {
                       secondImageView.frame = CGRectMake(0, (CGRectGetMaxY(firstImageView.frame)+5*ScalePpth), image.size.width<ScreenWidth?:ScreenWidth, image.size.height/( image.size.width/ScreenWidth));
                       if (image.size.width < ScreenWidth) {
                                           secondImageView.frame = CGRectMake(0, (CGRectGetMaxY(firstImageView.frame)+5*ScalePpth), image.size.width, image.size.height);
                                      }
                       weakSelf.cellHeight = (CGRectGetMaxY(secondImageView.frame)+5*ScalePpth);
                       if (weakSelf.imageBlock) {
                                          weakSelf.imageBlock(weakSelf.cellHeight);
                        }
                   }
               }];
    }
     UIImageView *thirdImageView = [[UIImageView alloc] initWithFrame:AutoFrame(0, (188 + 5), 375, 188)];
    if (_detailModel.imgLink3) {
             [self.contentView addSubview:thirdImageView];
           [thirdImageView sd_setImageWithURL:[NSURL URLWithString:[rootUrl stringByAppendingString:_detailModel.imgLink3]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                      if (image) {
                          thirdImageView.frame = CGRectMake(0, (CGRectGetMaxY(secondImageView.frame)+5*ScalePpth), image.size.width<ScreenWidth?:ScreenWidth, image.size.height/( image.size.width/ScreenWidth));
                          if (image.size.width < ScreenWidth) {
                               thirdImageView.frame = CGRectMake(0, (CGRectGetMaxY(secondImageView.frame)+5*ScalePpth), image.size.width, image.size.height);
                          }
                          weakSelf.cellHeight = (CGRectGetMaxY(thirdImageView.frame)+5*ScalePpth);
                          if (weakSelf.imageBlock) {
                                             weakSelf.imageBlock(weakSelf.cellHeight);
                           }
                      }
                }];
    }
}

@end
