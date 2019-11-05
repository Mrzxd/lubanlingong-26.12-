//
//  DetailTableCell.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/14.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "DetailTableCell.h"

@implementation DetailTableCell 

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线，
    //下分割线
    //设置分割线的颜色
    CGContextSetStrokeColorWithColor(context,RGBHex(0xBFBFBF).CGColor);
    //设置分割线的位置,给1的粗
    CGContextStrokeRect(context,CGRectMake(0, rect.size.height-0.6, rect.size.width,0.6));
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
       
        _label = [[UILabel alloc] initWithFrame:AutoFrame(133, 11, 100, 13)];
        _label.textColor = RGBHex(0x999999);
        _label.font = FontSize(13);
        _label.text = @"育儿嫂";
        [self.contentView addSubview:_label];
    };
    return self;
}

- (void)setTextContent:(NSString *)textContent {
    _textContent = textContent;
    _label.text = textContent;
//    if ([_textContent isEqualToString:@"保洁"]) {
//        _label.textColor = UIColor.blackColor;
//    } else {
//        _label.textColor = RGBHex(0x999999);
//    }
    
}

@end
