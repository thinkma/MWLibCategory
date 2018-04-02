//
//  NSString+Category.m
//  My_iOS_Dev_Tools
//
//  Created by RenSihao on 16/7/8.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSString (Category)

static BOOL IsNullOrNil(id value)
{
    if ([value isKindOfClass:[NSNull class]] || value ==nil || [value isEqual:[NSNull null]] || value == NULL)
    {
        return YES;
    }
    return NO;
}

//判断字符串是否为空,字符串不可以为空格
+ (BOOL)isEmpty:(NSString *)str
{
    if (IsNullOrNil(str))
    {
        return YES;
    }
    if([str stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0)
    {
        return YES;
    }
    
    return NO;
}

//判断字符串是否为空,字符串可以为空格
+ (BOOL)isNull:(NSString *)str
{
    if (IsNullOrNil(str))
    {
        return YES;
    }
    
    if(str.length == 0)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isValid
{
    if ([NSString isNull:self] || [NSString isEmpty:self])
    {
        return NO;
    }
    
    return YES;
}

+ (NSString *)random64BitString
{
    char english[32];
    
    char number[32];
    
    for (int x=0;x<32;english[x++] = (char)('a' + (arc4random_uniform(26))));
    
    for (int x=0;x<32;number[x++] = (char)('0'+(arc4random_uniform(10))));
    
    NSString *englishBytes = [[NSString alloc] initWithBytes:english length:32 encoding:NSUTF8StringEncoding];
    NSString *numberBytes = [[NSString alloc] initWithBytes:number length:32 encoding:NSUTF8StringEncoding];
    
    
    return [englishBytes stringByAppendingString:numberBytes];
}
//中文编码
+ (NSString*)encodeStr:(NSString *)str
{
    CFStringRef url = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8);
    
    NSString *ret = [NSString stringWithFormat:@"%@",(__bridge NSString*)url];
    CFRelease(url);
    
    return ret;
}

+ (NSString*)URLencode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding {
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    
    NSInteger len = [escapeChars count];
    
    NSMutableString *temp = [[originalString stringByAddingPercentEscapesUsingEncoding:stringEncoding]
                             mutableCopy];
    
    NSInteger i;
    for (i = 0; i < len; i++) {
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString:temp];
    
    return outStr;
}

/*
 对指定的参数进行url编码
 入参sourceString 是希望进行编码的字符串
 返回值是编码后的字符串,此方法对!*'();:@&=+$,/?%#[]都做了编码
 */
+(NSString *) encodeUrlStr:(NSString *)sourceString
{
    NSString *encodedString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)sourceString,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                        kCFStringEncodingUTF8 ));
    return encodedString;
}


//判断是不是纯数字
- (BOOL)isNumText
{
    if([self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

/**第一个字符
 */
- (char)firstCharacter
{
    if(self.length > 0)
    {
        return [self characterAtIndex:0];
    }
    else
    {
        return 0;
    }
}

//百度搜索链接
+ (NSString*)baiduURLForKey:(NSString *)key
{
    NSString *url = [NSString stringWithFormat:@"http://www.baidu.com/s?word=%@", key];
    url = [[self class] encodeStr:url];
    return url;
}

/**获取字符串所占位置大小
 *@param font 字符串要显示的字体
 *@param width 每行最大宽度
 *@return 字符串大小
 */
- (CGSize)stringSizeWithFont:(UIFont*) font contraintWith:(CGFloat) width
{
    CGSize size;
    CGSize contraintSize = CGSizeMake(width, CGFLOAT_MAX);

#ifdef __IPHONE_7_0
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    
    size = [self boundingRectWithSize:contraintSize  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
#else
        size = [self sizeWithFont:font constrainedToSize:contraintSize lineBreakMode:NSLineBreakByCharWrapping];
#endif
    
    return size;
}

#pragma mark- md5

- (NSString*)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark- 验证合法性

//判断手机号是否合法
- (BOOL)isMobileNumber
{
    
    if(self.length != 11)
    {
        return NO;
    }
    
    return YES;
    
    /**
     
     * 手机号码:
     
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     
     * 电信号段: 133,149,153,170,173,177,180,181,189
     
     */
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    
    /**
     
     * 中国移动：China Mobile
     
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     
     */
    
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    
    /**
     
     * 中国联通：China Unicom
     
     * 130,131,132,145,155,156,170,171,175,176,185,186
     
     */
    
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    
    /**
     
     * 中国电信：China Telecom
     
     * 133,149,153,170,173,177,180,181,189
     
     */
    
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        
        || ([regextestcm evaluateWithObject:self] == YES)
        
        || ([regextestct evaluateWithObject:self] == YES)
        
        || ([regextestcu evaluateWithObject:self] == YES))
        
    {
        
        return YES;
        
    }
    
    else
        
    {
        
        return NO;
        
    }
}

//特殊字符验证
- (BOOL)isIncludeSpecialCharacter
{
    NSRange urgentRange = [self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

//验证邮政编码
- (BOOL)isZipCode
{
    if(self.length != 6)
    {
        return NO;
    }
    return YES;
}

//验证固定电话
- (BOOL)isTelPhoneNumber
{
    if(self.length >= 7)
        return YES;
    
    NSString *phoneRegex = @"^(\\d{3,4}\\-?)?\\d{7,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    if(![predicate evaluateWithObject:self])
    {
        return NO;
    }
    return YES;
}

//邮箱验证
- (BOOL)isEmail
{
    //邮箱正则表达式验证
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    
    if(![predicate evaluateWithObject:self])
    {
        return NO;
    }
    return YES;
}


//身份证
- (BOOL)isCardId
{
    if(self.length > 18)
    {
        return NO;
    }
    
    
    NSString *regex18 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    
    NSPredicate *predicate18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex18];
    
    if(![predicate18 evaluateWithObject:self])
    {
        return NO;
    }
    return YES;
}

//是否是网址
- (BOOL)isURL
{
    NSString *urlRegex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSString *str = [NSString encodeStr:self];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",urlRegex];
    
    if(![predicate evaluateWithObject:str])
    {
        urlRegex = @"\\b(https?)://(?:(\\S+?)(?::(\\S+?))?@)?([a-zA-Z0-9\\-.]+)(?::(\\d+))?((?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
        predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",urlRegex];
        if(![predicate evaluateWithObject:str])
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return YES;
}

/**判断是否是整数
 */
- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

/**判断是否为浮点数
 */
- (BOOL)isPureFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


/**
 判断密码格式
 */
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 7){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{7,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

/**
 判断密码格式6-16位
 */
+(BOOL)judgePassWordLegalLetterOrNum:(NSString *)pass
{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}


/**
判断仅输入字母或数字
 */
+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

/**
 判断全字母
 */
+ (BOOL)inputShouldLetter:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

/**
 判断全数字
 */
+ (BOOL)inputShouldNumber:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

/**
 判断全汉字
 */
+ (BOOL)inputShouldChinese:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}



@end
