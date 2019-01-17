//
//  ViewController.m
//  LJYDatePickerDemo
//
//  Created by xx on 2019/1/16.
//  Copyright © 2019 ljy. All rights reserved.
//

#import "ViewController.h"
#import "LJYDatePicker.h"

@interface ViewController ()<LJYDatePickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *birthdayStr1=@"2018-01-02 12:50";
    NSString *birthdayStr2=@"2019-04-30 08:55";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date1=[formatter dateFromString:birthdayStr1];
    NSDate *date2=[formatter dateFromString:birthdayStr2];
    LJYDatePicker *dp = [[LJYDatePicker alloc] initWithDatePicker:CGRectMake(0, 100, self.view.frame.size.width, 200) MinDate:date1 MaxDate:date2];
    [dp selectsomeDate:[NSDate date]];
    dp.delegate = self;
    [self.view addSubview:dp];
}

-(void)selectsomedate:(NSDate*)currentdate andstring:(NSString*)datestring{
    
    NSLog(@"datestring:%@",datestring);
}

@end
