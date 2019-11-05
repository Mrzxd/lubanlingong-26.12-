
//
//  SendTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "SendTableCell.h"

@implementation SendTableCell

//- (void)drawRect:(CGRect)rect {
//
//    [super drawRect:rect];
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    //上分割线，
//    //下分割线
//    //设置分割线的颜色
//    CGContextSetStrokeColorWithColor(context,RGBHex(0xBFBFBF).CGColor);
//    //设置分割线的位置,给1的粗
//    CGContextStrokeRect(context,CGRectMake(0, rect.size.height-0.6, rect.size.width,0.6));
//
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    _sendLabel = [[UILabel alloc] initWithFrame:AutoFrame(15, 19, 80, 14)];
    _sendLabel.font  = [UIFont systemFontOfSize:14*ScalePpth];
    _sendLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:_sendLabel];
    
    _rightLabel = [[UILabel alloc] initWithFrame:AutoFrame(140, 19, 199, 11)];
    _rightLabel.font  = [UIFont systemFontOfSize:11*ScalePpth];
    _rightLabel.textColor = RGBHex(0x333333);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(200, 19, 10, 12)];
    imageView.image = [UIImage imageNamed:@"home_location"];
    [self.contentView addSubview:imageView];
}

@end
