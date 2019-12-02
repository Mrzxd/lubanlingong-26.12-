//
//  NSObject+JudgmentClass.h
//  YuTongInHand
//
//  Created by 张昊 on 2019/9/2.
//  Copyright © 2019 huizuchenfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JudgmentClass)
//判断是否为电话号码
- (BOOL)isMobileNumberOnly:(NSString *)mobileNum;
//验证身份证
- (BOOL)verifyIDCardNumber:(NSString *)value;
//验证姓名
- (BOOL)verifyUserName:(NSString *)name;
//验证邮箱
- (BOOL)isValidateEmail:(NSString *)email;

// 判断时间之差 是否已经登录过期(7天期限) thDate 单位 为 秒
- (BOOL)intervalBeOverdueSinceLast:(NSString *)theDate;
//车牌号格式校验(粤A8888澳)，18-05-21，增加新能源车牌校验
- (BOOL)checkCarID:(NSString *)carID;
#pragma mark ---- 将时间戳转换成时间
- (NSString *)getTimeFromTimestamp:(NSString *)time;
//银行卡校验
- (BOOL) checkCardNo:(NSString*) cardNo;
@end

NS_ASSUME_NONNULL_END
