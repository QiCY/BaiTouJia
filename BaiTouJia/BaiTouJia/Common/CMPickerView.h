//
//  CMPickerView.h
//  BaiTouJia
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PICKER_DATE       =1,
    PICKER_TIME       =2,
    PICKER_DATE_TIME  = 3,
    PICKER_SEX        =4,
    PICKER_HEIGHT     =5,
    PICKER_EDU        =6,
    PICKER_TOUXI      =7,
} PICKER_TYPE;
@interface CMPickerView : UIView
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *title;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSString *selectItem;
-(id)initWithFrame:(CGRect)frame withType:(PICKER_TYPE)type;
@end
