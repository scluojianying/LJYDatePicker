//
//  NSDate+Calendar.h
//  community
//
//  Created by xx on 2019/1/3.
//  Copyright © 2019 zmartec. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//头文件部分
@interface NSDate (Calendar)

/**
 *获取当前月的天数
 */
- (NSUInteger)YHBaseNumberOfDaysInCurrentMonth;
/**
 *获取本月第一天
 */
- (NSDate *)YHBaseFirstDayOfCurrentMonth;
//下面这些方法用于获取各种整形的数据
/**
 *确定某天是周几
 */
-(int)YHBaseWeekly;
/**
 *年月日 时分秒
 */
-(int)getYear;
-(int)getMonth;
-(int)getDay;
-(int)getHour;
-(int)getMinute;
-(int)getSecond;

@end

NS_ASSUME_NONNULL_END
