//
//  CMPickerView.m
//  BaiTouJia
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CMPickerView.h"

@implementation CMPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame withType:(PICKER_TYPE)type
{
    if (self = [super initWithFrame:frame]) {
        switch (type) {
            case PICKER_DATE:
            {
                self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 240, WIDTH, 240)];
                [self addSubview:self.contentView];
                
                UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 200)];
                
                [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
                // 设置时区
                [datePicker setTimeZone:[NSTimeZone localTimeZone]];
                
                // 设置当前显示时间
                [datePicker setDate:[NSDate date] animated:YES];
                // 设置显示最大时间（此处为当前时间）
                [datePicker setMaximumDate:[NSDate date]];
                // 设置UIDatePicker的显示模式
                [datePicker setDatePickerMode:UIDatePickerModeDate];
                // 当值发生改变的时候调用的方法
                [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
                [self.contentView addSubview:datePicker];
                
               
            }
                break;
            case PICKER_TIME:{
                
            }
                break;
            case PICKER_DATE_TIME:{
                
            }
                break;
            case PICKER_SEX:{
                
            }
                break;
            case PICKER_EDU:{
                
            }
                break;
            case PICKER_TOUXI:{
                    
                }
                break;
                
            default:
                break;
        }
    }
    return self;
}

-(void)datePickerValueChanged:(UIDatePicker *)datePicker{
    
}
@end
