
//
//  Created by Mark on 15/8/3.
//  Copyright (c) 2015年 Mark. All rights reserved.
//


#ifndef UIControlDemo_MyHelper_h
#define UIControlDemo_MyHelper_h

#define Default 44

#define LeftDistance 10

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define RightDistance 10

#define ControlDistance 20
//安全释放宏
#define Release_Safe(_control) [_control release], _control = nil;

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.f)

#define RandomColor RGB(arc4random()%256,arc4random()%256,arc4random()%256)

#define LDColorHex(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]

#define BASECOLOR [UIColor colorWithRed:1 green:.78 blue:.27 alpha:1]


// 状态栏高度
#define kStatusBarHeight ((IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)? 44.f : 20.f)
// 不计入状态栏的导航栏高度
#define kNavigationBarHeight 44
// 导航栏高度
#define kAppNavHeight ((IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)? 88.f : 64.f)
// tabBar高度
#define kTabbarHeight ((IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)? (49.f+34.f) : 49.f)
// 屏幕宽高
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kSafeAreaTop ((IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)? 24.f : 0)
#define kSafeAreaBottom ((IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)? 34.f : 0)

// 多语言
#define SMLocalizeString(key) [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:@"Language"]

// 适配比例
#define SCREEN_POINT_375 (kScreenWidth < kScreenHeight ? (float)kScreenWidth/375.f : (float)kScreenHeight/375.f)
#define SCREEN_POINT_667 (kScreenWidth < kScreenHeight ? (float)kScreenHeight/667.f : (float)kScreenWidth/667.f)

//判断是否全面屏手机
#define isiPhone_X_type (([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0)? YES:NO)

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define isIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) && !isPad : NO)
//判断iphone6+系列
#define isIPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size)) && !isPad : NO)
//判断IS_IPHONE_X
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size)) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)) && !isPad : NO)
// 多语言
#define SMLocalizeString(key) [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:@"Language"]

/*颜色定义方式
 */
#define SM_COLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0*a]
#define SM_RGB(r, g, b) SM_COLOR(r, g, b, 1.0f)
#define SM_COLORHEX(hex, a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1.0*a]

/*具体颜色
 */
#define WHITE_COLOR             [UIColor whiteColor] // 白色
#define kTextfieldBorderColor   SM_COLORHEX(0xFFFFFF,.1)//输入框边框颜色
#define kSunmiColor_normal      SM_COLORHEX(0xF26821,1)//商米色
#define kSunmiColor_alpha       SM_COLORHEX(0xF26821,.6)//浅色商米色
#define kSunmiLabelAlpha(a)     SM_COLORHEX(0x333C4F,a) // label色
#define kSunmiOrange            SM_COLORHEX(0xFF6000,1) // 按钮橘色 光标
#define kSunmiOrange_A10        SM_COLORHEX(0xFF6000,.1) // 按钮橘色 10%透明
#define kBadgeColor             SM_COLORHEX(0xFF3838,1) // 消息角标颜色
#define COLOR_33                SM_COLORHEX(0x333338,1)
#define COLOR_66                SM_COLORHEX(0x666666,1)
#define COLOR_99                SM_COLORHEX(0x999999,1)
#define COLOR_85                SM_COLORHEX(0x85858A,1)
#define COLOR_85_light          SM_COLORHEX(0x85858A,.6)
#define COLOR_BackGround        SM_COLORHEX(0xFAFAFA,1) // 背景色
#define COLOR_Line              SM_COLORHEX(0xE6E8EB,1) // 分割线颜色
#define COLOR_85_light_gray     SM_COLORHEX(0x85858A,.2)
#define COLOR_Unable            SM_COLORHEX(0xBBBBC7,1) //灰色

// 新UIKIT
#define COLOR_30                SM_COLORHEX(0x303540,1)
#define COLOR_52                SM_COLORHEX(0x525866,1)
#define COLOR_77                SM_COLORHEX(0x777E8C,1)
#define COLOR_A1                SM_COLORHEX(0xA1A7B3,1)
#define COLOR_4B                SM_COLORHEX(0x4B7AFA,1)
#define COLOR_F5                SM_COLORHEX(0xF5F7FA,1)
#define COLOR_E6                SM_COLORHEX(0xE6E8EB,1)
#define COLOR_shadow            SM_COLORHEX(0x333338,.2)
#endif /* sunmi_prefix_pch */

#define COLOR_TrackTint   SM_RGB(240, 242, 245)

#define kSubViewPadding 16
#define SubViewPadding_24 24

// 32加粗
#define FONT_32_BOLD [UIFont boldSystemFontOfSize:32]
// 32
#define FONT_32 [UIFont systemFontOfSize:32]
// 28加粗
#define FONT_28_BOLD [UIFont boldSystemFontOfSize:28]
// 28
#define FONT_28 [UIFont systemFontOfSize:28]
// 24加粗
#define FONT_24_BOLD [UIFont boldSystemFontOfSize:24]
// 24
#define FONT_24 [UIFont systemFontOfSize:24]
// 20加粗
#define FONT_20_BOLD [UIFont boldSystemFontOfSize:20]
// 20
#define FONT_20 [UIFont systemFontOfSize:20]
// 20细
#define FONT_20_LIGHT [UIFont systemFontOfSize:20 weight:UIFontWeightLight]
// 18加粗
#define FONT_18_BOLD [UIFont boldSystemFontOfSize:18]
// 18
#define FONT_18 [UIFont systemFontOfSize:18]
// 17加粗
#define FONT_17_BOLD [UIFont boldSystemFontOfSize:17]
// 17
#define FONT_17 [UIFont systemFontOfSize:17]
// 16加粗
#define FONT_16_BOLD [UIFont boldSystemFontOfSize:16]
// 16
#define FONT_16 [UIFont systemFontOfSize:16]
// 16细
#define FONT_16_LIGHT [UIFont systemFontOfSize:16 weight:UIFontWeightLight]
// 14加粗
#define FONT_14_BOLD [UIFont boldSystemFontOfSize:14]
// 14
#define FONT_14 [UIFont systemFontOfSize:14]
// 14细
#define FONT_14_LIGHT [UIFont systemFontOfSize:14 weight:UIFontWeightLight]
// 12加粗
#define FONT_12_BOLD [UIFont boldSystemFontOfSize:12]
// 12
#define FONT_12 [UIFont systemFontOfSize:12]
// 12细
#define FONT_12_LIGHT [UIFont systemFontOfSize:12 weight:UIFontWeightLight]
// 10加粗
#define FONT_10_BOLD [UIFont boldSystemFontOfSize:10]
// 10
#define FONT_10 [UIFont systemFontOfSize:10]
// 10细
#define FONT_10_LIGHT [UIFont systemFontOfSize:10 weight:UIFontWeightLight]
// 8
#define FONT_8 [UIFont systemFontOfSize:8]



#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]



