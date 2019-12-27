//
//  SMTools.m
//  router
//
//  Created by Rking on 2018/8/14.
//  Copyright © 2018年 Wireless Department. All rights reserved.
//

#import "SMTools.h"
// 工具库
#import "SVProgressHUD.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

// 获取mac地址需要导入的库
#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#define ORIGINAL_MAX_WIDTH 640.0f

@implementation SMTools

+ (UIColor *)randomColor
{
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
}
+(NSString *)mqttMsgid
{
    //时间戳，毫秒
    NSString *timeStampString = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
    //取后8位
    NSString *subStr = [timeStampString substringWithRange:NSMakeRange(timeStampString.length-8, 8)];
    //随机数（取10-20）
    int randomNum = rand() % 10 + 10;
    //拼接字符串
    NSString *randomString = [NSString stringWithFormat:@"%d%@",randomNum,subStr];
    return randomString;
}
+ (UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(float)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha*1.0];
}
#pragma mark -----------------------------------------------------------json--->nsdictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark ----------------------------------------------------- 字典转JSON

+(NSData *)convertDictToData:(NSDictionary *)dict
{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    return jsonData;
}
+ (NSString *)convertToJsonString:(NSDictionary *)dict {
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
    }
    else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}
#pragma mark -----------------------------------------------------------网络 Mac 地址和ip地址
+ (NSString *)currentWifiSSID
{
    NSString *ssid = @"";
    NSArray *ifs = (__bridge   id)CNCopySupportedInterfaces();
    for (NSString *ifname in ifs) {
        NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
        if (info[@"SSID"])
        {
            ssid = info[@"SSID"];
        }
    }
    return ssid;
}
+ (NSString *)getWiFiMac{
    
    NSString *ssid = @"Not Found";
    
    NSString *macIp = @"Not Found";
    
    CFArrayRef myArray =CNCopySupportedInterfaces();
    
    if (myArray != nil) {
        
        CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray,0));
        
        if (myDict != nil) {
            
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            
            //ssid = [dict valueForKey:@"SSID"];           //WiFi名称
            
            macIp = [dict valueForKey:@"BSSID"];     //Mac地址
            
        }
        
    }
    
    return macIp;
}
// 获取设备IP地址
+(NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // 检索当前接口,在成功时,返回0
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // 循环链表的接口
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // 检查接口是否en0 wifi连接在iPhone上
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // 得到NSString从C字符串
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // 释放内存
    freeifaddrs(interfaces);
    return address;
}
#pragma mark ----------------------------------------------------------- 数值转换
//NSData转16进制字符串
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
//16进制字节转10进制字符串
+ (NSString *)convertDataToString:(NSData *)data{
    if (!self || [data length] == 0) {
        return @"";
    }
    NSMutableString *hexString = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [hexString appendString:hexStr];
            } else {
                [hexString appendFormat:@"0%@", hexStr];
            }
        }
    }];
    //转换为十进制字符串
    NSString *string = [NSString stringWithFormat:@"%lu",strtoul([hexString UTF8String],0,16)];
    return string;
}
//16进制字符串转NSData
+ (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

+(NSInteger)convertHexString:(NSString *)string
{
    NSString * temp10 = [NSString stringWithFormat:@"%lu",strtoul([string UTF8String],0,16)];
    //转成数字
    NSInteger cycleNumber = [temp10 integerValue];
    return cycleNumber;
}
+ (NSString *)getHexByDecimal:(NSUInteger)decimal
{
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}


#pragma mark ----------------------------------------------------------- 编码与验证
+(uLong)crc32:(NSData *)data
{
    uLong crc = crc32(0L, Z_NULL, 0);
    crc = crc32(crc, data.bytes, (uInt)data.length);
    return crc;
}
+ (NSString *)decode:(NSString *)base64String
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}
+ (NSString *)encode:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;
}

#pragma mark ----------------------------------------------------------- 时间戳转格式化时间
+(NSString *)timeWithTimeInterval:(NSInteger )time
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString=[formatter stringFromDate:date];
    return timeString;
}

#pragma mark ----------------------------------------------------------- 判断注册方式
+(BOOL)isLoginViaPhone
{
    NSArray *array = [NSLocale preferredLanguages];
    NSString *preferredLan = array[0];
    //zh-Hans-CN 简体中文
    //zh-Hant-HK 🇭🇰繁体
    //zh-Hant-CN 繁体中文
    if ([preferredLan isEqualToString:@"zh-Hans-CN"])
    {
        return YES ;
    }
    return NO;
}


+(NSString *)timeConvertor:(NSInteger )second
{
    NSString *timeLenghtString;
    if (second<60) {
        //小于1分钟
        timeLenghtString = @"在线时长 刚刚";
    }else if (second<60*60)
    {
        //小于一小时
        timeLenghtString = [NSString stringWithFormat:@"在线时长 %ld分钟",second/60];
    }else if (second<60*60*24)
    {
        //小于1天
        timeLenghtString = [NSString stringWithFormat:@"在线时长 %ld小时",second/3600];
    }else
    {
        //大于1天
        timeLenghtString = [NSString stringWithFormat:@"在线时长 %ld天",second/(2600*24)];
    }
    return timeLenghtString;
}
+(NSDictionary *)trafficSpeedConvertor:(NSInteger )bytes
{
    NSString  *trafficValue;
    NSString  *trafficUnit;
    if (bytes==0) {
        
        trafficValue = @"0";
        trafficUnit = @"KB/s";
    }else if (bytes<1024) {
        //小于1KB
        trafficValue = [NSString stringWithFormat:@"%.0f",bytes*1.0];
        trafficUnit = @"B/s";
    }else if (bytes<1024*1024)
    {
        //小于1MB
        trafficValue = [NSString stringWithFormat:@"%.2f",bytes/1024.0];
        trafficUnit = @"KB/s";
    }else if (bytes<1024*1024*1024)
    {
        //小于1GB
        trafficValue = [NSString stringWithFormat:@"%.2f",bytes/(1024.0*1024)];
        trafficUnit = @"MB/s";
    }else
    {
        //大于1GB
        trafficValue = [NSString stringWithFormat:@"%.2f",bytes/(1024.0*1024*1024)];
        trafficUnit = @"GB/s";
    }
    return @{@"speedValue":trafficValue,@"speedUnit":trafficUnit};
}
+(NSString *)trafficValueUnitConvertor:(NSInteger )bytes
{
    NSString  *trafficValue;
    if (bytes==0) {
        
        trafficValue = @"0 KB/s";
    }else if (bytes<1024) {
        //小于1KB
        trafficValue = [NSString stringWithFormat:@"%.0f B/s",bytes*1.0];
    }else if (bytes<1024*1024)
    {
        //小于1MB
        trafficValue = [NSString stringWithFormat:@"%.1f KB/s",bytes/1024.0];
    }else if (bytes<1024*1024*1024)
    {
        //小于1GB
        trafficValue = [NSString stringWithFormat:@"%.1f MB/s",bytes/(1024.0*1024)];
    }else
    {
        //大于1GB
        trafficValue = [NSString stringWithFormat:@"%.1f GB/s",bytes/(1024.0*1024*1024)];
    }
    return trafficValue;
}
+(NSString *)trafficConvertor:(NSInteger )bytes
{
    NSString  *trafficString;
    if (bytes==0) {
        
        trafficString = @"0 KB";
    }else if (bytes<1024) {
        //小于1KB
        trafficString = [NSString stringWithFormat:@"%.0f B",bytes*1.0];
    }else if (bytes<1024*1024)
    {
        //小于1MB
        trafficString = [NSString stringWithFormat:@"%.2f KB",bytes/1024.0];
    }else if (bytes<1024*1024*1024)
    {
        //小于1GB
        trafficString = [NSString stringWithFormat:@"%.2f MB",bytes/(1024.0*1024)];
    }else
    {
        //大于1GB
        trafficString = [NSString stringWithFormat:@"%.2f GB",bytes/(1024.0*1024*1024)];
    }
    return trafficString;
}

// 获取相册权限
+ (BOOL)isPhotoAvailabel
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}

-(NSString *)numberHide:(NSString*)numberString{
    NSString *subNumberString = [numberString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return subNumberString;
}

/*隐藏规则
 如果用户名是邮箱且@前的数字长度大于3，则将邮箱的第三位到@之间的字符做*号处理，如果没有不做*号显示
 如果用户名是手机号 则如 168****1122
 */
+(NSString *)accountStringHide:(NSString *)string
{
    if (!string || !string.length) {
        return nil;
    }
    NSString *result;
    if ([string containsString:@"@"]) {
        NSRange range = [string rangeOfString:@"@"];
        NSString *subString = [string substringToIndex:range.location];
        NSString *tmpString = string;
        if (subString.length>3) {
            NSInteger stringLengthToReplace = range.location-2;
            for (int i=0; i<stringLengthToReplace; i++) {
                NSString *subNumberString = [tmpString stringByReplacingCharactersInRange:NSMakeRange(2+i, 1) withString:@"*"];
                tmpString = subNumberString;
            }
        }
        result = tmpString;
    }else
    {
        result = [string stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    
    return result;
}

#pragma mark - 获取设备列表图片名称
+ (NSString *)deviceListWithMac:(NSString *)macStr {
    
    if (!macStr) {
        return @"unknow";
    }
    
    // 取前6位mac地址 加两组:
    NSString *macRemote = [[macStr substringToIndex:8] uppercaseString];
    
    // 获取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"device.plist" ofType:nil];
    NSArray *images = [NSArray arrayWithContentsOfFile:path];
    
    // 匹配
    for (NSDictionary *dic in images) {
        for (NSString *macLocal in dic[@"mac"]) {
            if ([macRemote isEqualToString:macLocal]) {
                return dic[@"brand"];
            }
        }
    }
    
    return @"unknow";
}
+ (NSString *)sunmiDeviceImageNameWithModel:(NSString *)modelStr {
    
    if (!modelStr) {
        //默认图片颜色
        return @"unknow";
    }
    
    // 获取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"device.plist" ofType:nil];
    NSArray *images = [NSArray arrayWithContentsOfFile:path];
    
    // 匹配
    for (NSDictionary *dic in images) {
        for (NSString *macLocal in dic[@"model"]) {
            if ([[modelStr uppercaseString] isEqualToString:macLocal]) {
                return dic[@"brand"];
            }
        }
    }
    return @"unknow";
}
+(NSString *)sunmiDeviceTypeWithModelString:(NSString *)modelStr
{
    if (!modelStr) {
        return nil;
    }
    
    // 获取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"device.plist" ofType:nil];
    NSArray *images = [NSArray arrayWithContentsOfFile:path];
    
    // 匹配
    for (NSDictionary *dic in images) {
        for (NSString *modelString in dic[@"model"]) {
            if ([[modelStr uppercaseString] isEqualToString:modelString]) {
                return dic[@"type"];
            }
        }
    }
    return nil;
}
#pragma mark - 获取当前控制器

+ (UIViewController *)getCurrentController {
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

#pragma mark - 获取当前版本号

+ (NSString *)currentAppVersion {
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *bin_version = infoDic[@"CFBundleShortVersionString"];
    return bin_version;
}

#pragma mark - 解析tag

+ (NSDictionary *)analyseDicWithTag:(NSString *)tag {
    
    // "notif-device-ipc-motion-detect-video-title:shop_name=%3D%E5%A4%8D%E6%97%A6%E7%BB%8F%E4%B8%96%E4%B9%A6%E5%B1%80&company_name=%3D%E5%9B%9E%E5%A4%B4%E5%9B%9B%E5%8F%B7"
    // shop_id=9474&company_id=145&url=http%3A%2F%2Ftest.cdn.sunmi.com%2FVIDEO%2FIPC%2Ff4c28c287dff0e0656e00192450194e76f4863f80ca0517a135925ebc7828104&device_model=FM020
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    NSArray *tmpArr1;
    NSString *tmpStr;
    
    // 根据:分割 或者 根据&分割
    if ([tag containsString:@":"]) {
        tmpArr1 = [tag componentsSeparatedByString:@":"];
        // title
        [paraDic setObject:tmpArr1[0] forKey:@"title"];
        tmpStr = (NSString *)tmpArr1[1];
    } else if ([tag containsString:@"&"]) {
        tmpStr = tag;
    }
    
    // 取参数
    if (!tmpStr) {
        return nil;
    }
    NSArray *tmpArr2 = [tmpStr componentsSeparatedByString:@"&"];
    for (NSString *para1 in tmpArr2) {
        NSArray *tmpArr3 = [para1 componentsSeparatedByString:@"="];
        NSString *encodeStr = [(NSString *)tmpArr3[1] stringByRemovingPercentEncoding];
        [paraDic setObject:encodeStr forKey:tmpArr3[0]];
    }
    
    return paraDic.copy;
}

+ (BOOL)compareVersion:(NSString *)currentVersion withTheGivenVersion:(NSString *)givenVersion
{
    BOOL result = NO;
    if (!currentVersion) {
        return result;
    }
    NSArray *subStrArrCurrent = [currentVersion componentsSeparatedByString:@"."];
    NSArray *subStrArr = [givenVersion componentsSeparatedByString:@"."];
    NSInteger currentVersionNum = 0;
    NSInteger givenVersionNum = 0;
    
    for (int i=0; i<subStrArrCurrent.count; i++) {
        int multi = 1;
        if (i == 0) {
            multi = 10000;
        }else if (i == 1)
        {
            multi = 100;
        }
        currentVersionNum += [subStrArrCurrent[i] integerValue] * multi;
    }
    for (int i=0; i<subStrArr.count; i++) {
        int multi = 1;
        if (i == 0) {
            multi = 10000;
        }else if (i == 1)
        {
            multi = 100;
        }
        givenVersionNum += [subStrArr[i] integerValue] * multi;
    }
    
    if (currentVersionNum >= givenVersionNum) {
        
        result = YES;
    }
    return result;
}
@end
