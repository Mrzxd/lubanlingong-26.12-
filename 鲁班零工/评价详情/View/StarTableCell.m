
//
//  StarTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/16.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "StarTableCell.h"

@interface StarTableCell () <HCRatingViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation StarTableCell

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
    _nameLabel = [[UILabel alloc] initWithFrame:AutoFrame(16, 19, 80, 14)];
    _nameLabel.font  = [UIFont boldSystemFontOfSize:14*ScalePpth];
    _nameLabel.textColor = RGBHex(0x999999);
    [self.contentView addSubview:_nameLabel];
    
    _ratingView = [[HCRatingView alloc] initWithFrame:AutoFrame(245, 10, 140, 30)];
    _ratingView.isFull = NO; //设置是否允许半颗星
    [_ratingView setImagesDeselected:@"details_no_collected" partlySelected:@"星3" fullSelected:@"details_collected" userInteractionEnabled:NO andDelegate:self]; //设置星星的图片，如果isfull == YES 则partlySelected为半颗星的图
    [self.ratingView disPlayRating:4];//设置默认分数
    [self.contentView addSubview:_ratingView];
}
-(void) ratingChanged:(float)newRating{
    
    NSLog(@"____分数:%.1f",newRating);
}
@end
