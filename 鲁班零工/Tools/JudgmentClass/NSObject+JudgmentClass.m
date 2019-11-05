//
//  NSObject+JudgmentClass.m
//  YuTongInHand
//
//  Created by 张兴栋 on 2019/9/2.
//  Copyright © 2019 huizuchenfeng. All rights reserved.
//

#import "NSObject+JudgmentClass.h"

@implementation NSObject (JudgmentClass)

//判断是否为电话号码
- (BOOL)isMobileNumberOnly:(NSString *)mobileNum
{
    NSString * MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES) { return YES; }
    else { return NO; }
}

//验证身份证
    //必须满足以下规则
    //1. 长度必须是18位，前17位必须是数字，第十八位可以是数字或X
    //2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
    //3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
    //4. 第17位表示性别，双数表示女，单数表示男
    //5. 第18位为前17位的校验位
    //算法如下：
    //（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
    //（2）余数 ＝ 校验和 % 11
    //（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
    //6. 出生年份的前两位必须是19或20
- (BOOL)verifyIDCardNumber:(NSString *)value
{
     value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
     if ([value length] != 18) {
             return NO;
         }
     NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
     NSString *leapMmdd = @"0229";
     NSString *year = @"(19|20)[0-9]{2}";
     NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
     NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
     NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
     NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
     NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
     NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];

     NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
     if (![regexTest evaluateWithObject:value]) {
             return NO;
        }
     int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
             + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
             + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
             + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
             + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
             + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
             + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
             + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
             + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
     NSInteger remainder = summary % 11;
     NSString *checkBit = @"";
     NSString *checkString = @"10X98765432";
     checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
     return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

- (BOOL)verifyUserName:(NSString *)name {
    NSString *realNamePattern = @"^[\u4e00-\u9fa5]{0,}";
    NSPredicate *realNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",realNamePattern];
    if(![realNamePredicate evaluateWithObject:name]){
        return NO;
 } else
    return YES;
}

- (BOOL)isValidateEmail:(NSString *)email {
    NSString *userRegexp = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";   //邮箱格式
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userRegexp];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)intervalBeOverdueSinceLast:(NSString *)theDate {
//    NSArray *timeArray = [theDate componentsSeparatedByString:@"."];
//    theDate = [timeArray objectAtIndex:0];
//    NSDateFormatter *date = [[NSDateFormatter alloc] init];
//    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *lastedDate = [date dateFromString:theDate];
    if (!theDate) {//没有数据，说明没有登录或者注册过，去登录或者注册
        return YES;
    }
    NSTimeInterval lasted = [theDate doubleValue];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    NSTimeInterval differenceValue = fabs(lasted - now);
    NSString *diffVl = [NSString stringWithFormat:@"%lf",differenceValue];
    diffVl= [diffVl substringToIndex:diffVl.length - 7];
    if ([diffVl integerValue] > (24 *3600 *7)) {//7天期限 超过7天YES表示已过期
        return YES;
    }
    return NO;
}
//车牌号格式校验(粤A8888澳)，18-05-21，增加新能源车牌校验
- (BOOL)checkCarID:(NSString *)carID;
{
    if (carID.length==7) {
        //普通汽车，7位字符，不包含I和O，避免与数字1和0混淆
        NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{4}[a-hj-np-zA-HJ-NP-Z0-9\u4e00-\u9fa5]$";
        NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
        return [carTest evaluateWithObject:carID];
    }else if(carID.length==8){
        //新能源车,8位字符，第一位：省份简称（1位汉字），第二位：发牌机关代号（1位字母）;
        //小型车，第三位：只能用字母D或字母F，第四位：字母或者数字，后四位：必须使用数字;([DF][A-HJ-NP-Z0-9][0-9]{4})
        //大型车3-7位：必须使用数字，后一位：只能用字母D或字母F。([0-9]{5}[DF])
        NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}([0-9]{5}[d|f|D|F]|[d|f|D|F][a-hj-np-zA-HJ-NP-Z0-9][0-9]{4})$";
        NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
        return [carTest evaluateWithObject:carID];
    }
    return NO;
}

@end
