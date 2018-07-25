//
//  AnimationNumberView.h
//  NumberAnimation
//
//  Created by 吴涛 on 2016/11/24.
//  Copyright © 2016年 吴涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationNumberView : UIView
// 显示label的字体
@property (nonatomic, strong)UIFont *numberFont;
// 显示label的颜色
@property (nonatomic, strong)UIColor *numberColor;

@property (nonatomic, copy) NSString *currentNumber;

- (void)setCurrentNumber:(NSString *)currentNumber;


@end
