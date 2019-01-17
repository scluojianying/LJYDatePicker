//
//  LJYDatePicker.h
//  community
//
//  Created by xx on 2019/1/15.
//  Copyright © 2019 zmartec. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LJYDatePickerDelegate;
@interface LJYDatePicker : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerview;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *datestring;
@property(nonatomic,assign) id<LJYDatePickerDelegate> delegate;

-(void)selectsomeDate:(NSDate * _Nonnull)date;
/**
 快速构造
 @param minDate 最早的时间
 @param maxDate 最晚的时间
 @return 返回的实列
 */
-(instancetype)initWithDatePicker:(CGRect)frame MinDate:(NSDate *)minDate MaxDate:(NSDate *)maxDate;

@end

@protocol LJYDatePickerDelegate <NSObject>

-(void)selectsomedate:(NSDate*)currentdate andstring:(NSString*)datestring;

@end

NS_ASSUME_NONNULL_END
