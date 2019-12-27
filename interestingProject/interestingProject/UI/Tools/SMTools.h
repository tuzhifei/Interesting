//
//  SMTools.h
//  router
//
//  Created by Rking on 2018/8/14.
//  Copyright © 2018年 Wireless Department. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <zlib.h>

@interface SMTools : NSObject

//UICOlor-->UIimage
+ (UIImage*)  createImageWithColor:(UIColor*)color;
+ (UIColor *) randomColor;
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(float)alpha;


+ (NSString *)currentWifiSSID;
+ (NSString *)getWiFiMac;
+ (NSString *)getIPAddress;

// json--->nsdictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
// NSDictionary转JSON字符串
+ (NSString *)convertToJsonString:(NSDictionary *)dict;
// NSDictionary转nsdata
+ (NSData *)convertDictToData:(NSDictionary *)dict;


//16进制字节转16进制字符串
+ (NSString *)convertDataToHexStr:(NSData *)data;
//16进制字节转10进制字符串
+ (NSString *)convertDataToString:(NSData *)data;
//16进制字符串转16进制字节
+ (NSData *)convertHexStrToData:(NSString *)str;
//10进制字符串转16进制数值
+ (NSInteger)convertHexString:(NSString *)string;
//10进制数值转16进制字符串
+ (NSString *)getHexByDecimal:(NSUInteger)decimal;

//CRC验证
+ (uLong)crc32:(NSData *)data;
//Base64编码
+ (NSString *)encode:(NSString *)string;
//Base64解码
+ (NSString *)decode:(NSString *)base64String;

#pragma mark - 格式化时间

+(NSString *)timeWithTimeInterval:(NSInteger )time;

#pragma mark - 速率

+(NSString *)timeConvertor:(NSInteger )second;
+(NSDictionary *)trafficSpeedConvertor:(NSInteger )bytes;
+(NSString *)trafficValueUnitConvertor:(NSInteger )bytes;
+(NSString *)trafficConvertor:(NSInteger )bytes;


#pragma mark - 权限
// 检测系统相册权限
+ (BOOL)isPhotoAvailabel;

// 隐藏邮箱或者手机号中的几位
+(NSString *)accountStringHide:(NSString *)string;


#pragma mark - 获取设备图片名称
// 根据设备mac地址信息获取图片名称
+ (NSString *)deviceListWithMac:(NSString *)macStr;
// 根据设备型号名称获取图片名称
+ (NSString *)sunmiDeviceImageNameWithModel:(NSString *)modelStr;
// 根据设备型号名称获取设备类型名称
+ (NSString *)sunmiDeviceTypeWithModelString:(NSString *)modelStr;
#pragma mark - 获取当前控制器
// 获取当前控制器
+ (UIViewController *)getCurrentController;
#pragma mark - 获取当前版本号
+ (NSString *)currentAppVersion;
//摄像机当前的版本号高于V1.4.4
+ (BOOL)compareVersion:(NSString *)currentVersion withTheGivenVersion:(NSString *)givenVersion;
// 解析tag
+ (NSDictionary *)analyseDicWithTag:(NSString *)tag;
// MQTT的消息ID（10-20的两位随机数+8位的时间戳）
+ (NSString *)mqttMsgid;
@end
