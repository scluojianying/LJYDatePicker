//
//  LJYDatePicker.m
//  community
//
//  Created by xx on 2019/1/15.
//  Copyright © 2019 zmartec. All rights reserved.
//

#import "LJYDatePicker.h"
#import "NSDate+Calendar.h"

@interface LJYDatePicker ()
@property (nonatomic, strong) NSMutableArray *years;
@property (nonatomic, strong) NSMutableArray *months;
@property (nonatomic, strong) NSMutableArray *days;
@property (nonatomic, strong) NSMutableArray *hours;
@property (nonatomic, strong) NSMutableArray *minits;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;

@property (nonatomic, assign) NSInteger yearindex;
@property (nonatomic, assign) NSInteger monthindex;
@property (nonatomic, assign) NSInteger dayindex;
@property (nonatomic, assign) NSInteger hourindex;
@property (nonatomic, assign) NSInteger minitindex;

@property (nonatomic, strong) NSString *yearstring;
@property (nonatomic, strong) NSString *monthstring;
@property (nonatomic, strong) NSString *daystring;
@property (nonatomic, strong) NSString *hourstring;
@property (nonatomic, strong) NSString *minitstring;
@end
@implementation LJYDatePicker

-(instancetype)initWithDatePicker:(CGRect)frame MinDate:(NSDate *)minDate MaxDate:(NSDate *)maxDate{
    if (self = [super initWithFrame:frame])
    {
        
        self.pickerview = [[UIPickerView alloc] initWithFrame:self.bounds];
        self.pickerview.showsSelectionIndicator = YES;
        self.pickerview.delegate = self;
        self.pickerview.dataSource = self;
        [self addSubview:self.pickerview];
        
        self.minDate = minDate;
        self.maxDate = maxDate;
        
        self.yearindex = 0;
        self.monthindex = 0;
        self.dayindex = 0;
        self.hourindex = 0;
        self.minitindex = 0;
        
        _years = [[NSMutableArray alloc] init];
        _months = [[NSMutableArray alloc] init];
        _days = [[NSMutableArray alloc] init];
        _hours = [[NSMutableArray alloc] init];
        _minits = [[NSMutableArray alloc] init];
        
        _yearstring = [NSString stringWithFormat:@"%d",[self.minDate getYear]];
        _monthstring = [NSString stringWithFormat:@"%d",[self.minDate getMonth]];
        _daystring = [NSString stringWithFormat:@"%d",[self.minDate getDay]];
        _hourstring = [NSString stringWithFormat:@"%d",[self.minDate getHour]];
        _minitstring = [NSString stringWithFormat:@"%d",[self.minDate getMinute]];
        
        [self getYearsArray];
        [self getMonthsArray];
        [self getDaysArray];
        [self getHoursArray];
        [self getMinitsArray];
        
        self.date = [self currentdate];
        self.datestring = [self currentdatestring];
        if ([self.delegate respondsToSelector:@selector(selectsomedate:andstring:)]) {
            [self.delegate selectsomedate:self.date andstring:self.datestring];
        }
        
        [self.pickerview reloadAllComponents];
    }
    return self;
}

#pragma mark - UIPickerViewDelegate

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.bounds.size.width / 5;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.years.count;
    }
    else if(component == 1)
    {
        return self.months.count;
    }else if (component == 2)
    {
        return self.days.count;
    }else if (component == 3)
    {
        return self.hours.count;
    }else
    {
        return self.minits.count;
    }
}

-(UILabel *)labelForComponent:(NSInteger)component
{
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width/5, 44);
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.userInteractionEnabled = NO;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    
    return label;
}
-(UIView *)pickerView: (UIPickerView *)pickerView viewForRow: (NSInteger)row forComponent: (NSInteger)component reusingView: (UIView *)view
{
    
    UILabel *returnView = [self labelForComponent:component];
    returnView.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return returnView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        return [self.years objectAtIndex:row];
    }
    else if (component == 1) {
        return [self.months objectAtIndex:row];
    }
    else if (component == 2) {
        return [self.days objectAtIndex:row];
    }
    else if (component == 3) {
        return [self.hours objectAtIndex:row];
    }
    else if (component == 4) {
        return [self.minits objectAtIndex:row];
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.yearindex = row;
        _yearstring = [self.years objectAtIndex:_yearindex];
        [self getMonthsArray];
    }
    else if (component == 1){
        self.monthindex = row;
        _monthstring = [self.months objectAtIndex:_monthindex];
        [self getDaysArray];
    }
    else if (component == 2){
        self.dayindex = row;
        _daystring = [self.days objectAtIndex:_dayindex];
        [self getHoursArray];
    }
    else if (component == 3){
        self.hourindex = row;
        _hourstring = [self.hours objectAtIndex:_hourindex];
        [self getMinitsArray];
    }
    else if (component == 4){
        self.minitindex = row;
        _minitstring = [self.minits objectAtIndex:_minitindex];
    }
    [self.pickerview reloadAllComponents];
    
    self.date = [self currentdate];
    self.datestring = [self currentdatestring];
    if ([self.delegate respondsToSelector:@selector(selectsomedate:andstring:)]) {
        [self.delegate selectsomedate:self.date andstring:self.datestring];
    }
}
-(void)getYearsArray{
    
    int yearIntmin = [self.minDate getYear];
    int yearIntmax = [self.maxDate getYear];
    [self.years removeAllObjects];
    for (int i=yearIntmin; i<=yearIntmax; i++) {
        [self.years addObject:[NSString stringWithFormat:@"%d",i]];
    }
}
-(void)getMonthsArray{
    
    int monthmin = [self.minDate getMonth];
    int monthmax = [self.maxDate getMonth];
    int yl = 1;
    int yr = 12;
    
    if (self.yearindex == 0) {
        yl = monthmin;
    }
    if (self.yearindex == self.years.count-1) {
        yr = monthmax;
    }
    [self.months removeAllObjects];
    for (int i=yl; i<=yr; i++) {
        [self.months addObject:[NSString stringWithFormat:@"%d",i]];
    }
    int c = [_monthstring intValue];
    int x = [[self.months objectAtIndex:0] intValue];
    int d = [[self.months objectAtIndex:self.months.count-1] intValue];
    if (c<=x) {
        self.monthindex = 0;
    }
    else if (c>=d){
        self.monthindex = self.months.count-1;
    }
    else if (c>x && c<d){
        self.monthindex = c-x;
    }
    _monthstring = [self.months objectAtIndex:_monthindex];
    [self.pickerview reloadComponent:1];
    [self.pickerview selectRow:self.monthindex inComponent:1 animated:NO];
    [self getDaysArray];
}
-(void)getDaysArray{
    int monthmin = [self.minDate getDay];
    int monthmax = [self.maxDate getDay];
    int daycout = [self getCurrentAllDay:[[self.years objectAtIndex:self.yearindex] intValue] andmonth:[[self.months objectAtIndex:self.monthindex] intValue]];
    int yl = 1;
    int yr = daycout;
    
    if (self.yearindex == 0 && self.monthindex == 0) {
        yl = monthmin;
    }
    if (self.yearindex == self.years.count-1 && self.monthindex == self.months.count-1) {
        yr = monthmax;
    }
    [self.days removeAllObjects];
    for (int i=yl; i<=yr; i++) {
        [self.days addObject:[NSString stringWithFormat:@"%d",i]];
    }
    //28 31  cout4    30  27 32  30
    
    int c = [_daystring intValue];
    int x = [[self.days objectAtIndex:0] intValue];
    int d = [[self.days objectAtIndex:self.days.count-1] intValue];
    if (c<=x) {
        self.dayindex = 0;
    }
    else if (c>=d){
        self.dayindex = self.days.count-1;
    }
    else if (c>x && c<d){
        self.dayindex = c-x;
    }
    _daystring = [self.days objectAtIndex:_dayindex];
    [self.pickerview reloadComponent:2];
    [self.pickerview selectRow:self.dayindex inComponent:2 animated:NO];
    [self getHoursArray];
    
}
-(void)getHoursArray{
    int monthmin = [self.minDate getHour];
    int monthmax = [self.maxDate getHour];
    int yl = 0;
    int yr = 23;
    
    if (self.yearindex == 0 && self.monthindex == 0 && self.dayindex == 0) {
        yl = monthmin;
    }
    if (self.yearindex == self.years.count-1 && self.monthindex == self.months.count-1 && self.dayindex == self.days.count-1) {
        yr = monthmax;
    }
    [self.hours removeAllObjects];
    for (int i=yl; i<=yr; i++) {
        [self.hours addObject:[NSString stringWithFormat:@"%d",i]];
    }
    int c = [_hourstring intValue];
    int x = [[self.hours objectAtIndex:0] intValue];
    int d = [[self.hours objectAtIndex:self.hours.count-1] intValue];
    if (c<=x) {
        self.hourindex = 0;
    }
    else if (c>=d){
        self.hourindex = self.hours.count-1;
    }
    else if (c>x && c<d){
        self.hourindex = c-x;
    }
    _hourstring = [self.hours objectAtIndex:_hourindex];
    [self.pickerview reloadComponent:3];
    [self.pickerview selectRow:self.hourindex inComponent:3 animated:NO];
    [self getMinitsArray];
}
-(void)getMinitsArray{
    int monthmin = [self.minDate getMinute];
    int monthmax = [self.maxDate getMinute];
    int yl = 0;
    int yr = 59;
    
    if (self.yearindex == 0 && self.monthindex == 0 && self.dayindex == 0 && self.hourindex == 0) {
        yl = monthmin;
    }
    if (self.yearindex == self.years.count-1 && self.monthindex == self.months.count-1 && self.dayindex == self.days.count-1 && self.hourindex == self.hours.count-1) {
        yr = monthmax;
    }
    [self.minits removeAllObjects];
    for (int i=yl; i<=yr; i++) {
        [self.minits addObject:[NSString stringWithFormat:@"%d",i]];
    }
    int c = [_minitstring intValue];
    int x = [[self.minits objectAtIndex:0] intValue];
    int d = [[self.minits objectAtIndex:self.minits.count-1] intValue];
    if (c<=x) {
        self.minitindex = 0;
    }
    else if (c>=d){
        self.minitindex = self.minits.count-1;
    }
    else if (c>x && c<d){
        self.minitindex = c-x;
    }
    _minitstring = [self.minits objectAtIndex:_minitindex];
    [self.pickerview reloadComponent:4];
    [self.pickerview selectRow:self.minitindex inComponent:4 animated:NO];
}
-(int)getCurrentAllDay:(int)year andmonth:(int)month{
    
    int endDate = 0;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            endDate = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            endDate = 30;
            break;
        case 2:
            // 是否为闰年
            if (year % 400 == 0) {
                endDate = 29;
            } else {
                if (year % 100 != 0 && year %4 ==4) {
                    endDate = 29;
                } else {
                    endDate = 28;
                }
            }
            break;
        default:
            break;
    }
    
    return endDate;
}

-(NSDate *)currentdate
{
    NSString *year = [self.years objectAtIndex:_yearindex];
    NSString *month = [self.months objectAtIndex:_monthindex];
    NSString *day = [self.days objectAtIndex:_dayindex];
    NSString *hour = [self.hours objectAtIndex:_hourindex];
    NSString *minit = [self.minits objectAtIndex:_minitindex];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *string = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", year, month, day, hour,minit];
    NSDate *date =  [formatter dateFromString:string];
    
    NSLog(@"date:%@",date);
    return date;
}
-(NSString *)currentdatestring
{
    NSString *year = [self.years objectAtIndex:_yearindex];
    NSString *month = [self.months objectAtIndex:_monthindex];
    NSString *day = [self.days objectAtIndex:_dayindex];
    NSString *hour = [self.hours objectAtIndex:_hourindex];
    NSString *minit = [self.minits objectAtIndex:_minitindex];

    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *string = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", year, month, day, hour,minit];

    NSLog(@"string:%@",string);
    return string;
}

-(void)selectsomeDate:(NSDate * _Nonnull)date{
    
    BOOL isyear = NO;
    BOOL ismonth = NO;
    BOOL isday = NO;
    BOOL ishour = NO;
    BOOL isminit = NO;
    
    int year = [date getYear];
    for (int y = 0; y<self.years.count; y++) {
        if (year == [[self.years objectAtIndex:y] intValue]) {
            self.yearindex = y;
            isyear= YES;
            break;
        }
    }
    _yearstring = [self.years objectAtIndex:_yearindex];
    [self.pickerview selectRow:self.yearindex inComponent:0 animated:NO];
    [self getMonthsArray];
    [self.pickerview reloadComponent:1];
    
    if (isyear) {
        
        int month = [date getMonth];
        for (int m = 0; m<self.months.count; m++) {
            if (month == [[self.months objectAtIndex:m] intValue]) {
                self.monthindex = m;
                ismonth = YES;
                break;
            }
        }
        _monthstring = [self.months objectAtIndex:_monthindex];
        [self.pickerview selectRow:self.monthindex inComponent:1 animated:NO];
        [self getDaysArray];
        [self.pickerview reloadComponent:2];
    }
    
    if (ismonth) {
        int day = [date getDay];
        for (int d = 0; d<self.days.count; d++) {
            if (day == [[self.days objectAtIndex:d] intValue]) {
                self.dayindex = d;
                isday = YES;
                break;
            }
        }
        _daystring = [self.days objectAtIndex:_dayindex];
        [self.pickerview selectRow:self.dayindex inComponent:2 animated:NO];
        [self getHoursArray];
        [self.pickerview reloadComponent:3];
    }
    
    if (isday) {
        int hour = [date getHour];
        for (int h = 0; h<self.hours.count; h++) {
            if (hour == [[self.hours objectAtIndex:h] intValue]) {
                self.hourindex = h;
                ishour = YES;
                break;
            }
        }
        _hourstring = [self.hours objectAtIndex:_hourindex];
        [self.pickerview selectRow:self.hourindex inComponent:3 animated:NO];
        [self getMinitsArray];
        [self.pickerview reloadComponent:4];
    }
    
    if (ishour) {
        int minit = [date getMinute];
        for (int s = 0; s<self.minits.count; s++) {
            if (minit == [[self.minits objectAtIndex:s] intValue]) {
                self.minitindex = s;
                isminit = YES;
                break;
            }
        }
        _minitstring = [self.minits objectAtIndex:_minitindex];
        [self.pickerview selectRow:self.minitindex inComponent:4 animated:NO];
    }
    
    self.date = [self currentdate];
    self.datestring = [self currentdatestring];
    if ([self.delegate respondsToSelector:@selector(selectsomedate:andstring:)]) {
        [self.delegate selectsomedate:self.date andstring:self.datestring];
    }
}
@end
