//
//  ConstantInfo.h
//  HMP
//
//  Created by zhanbing han on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#ifndef ConstantInfo_h
#define ConstantInfo_h

#define CB_SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define CB_SCREENHIGH  [UIScreen mainScreen].bounds.size.height
#define kNavBarH (iPhoneX?88:64)
#define kStatusBarH (iPhoneX?44:20)
#define kTabBarH (iPhoneX?83:49)
#define kTabBarSafeH (iPhoneX?34:0)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#endif /* ConstantInfo_h */
