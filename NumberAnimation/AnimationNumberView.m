//
//  AnimationNumberView.m
//  NumberAnimation
//
//  Created by 吴涛 on 2016/11/24.
//  Copyright © 2016年 吴涛. All rights reserved.
//

#import "AnimationNumberView.h"

static NSTimeInterval animationDuration = 0.2;


@interface AnimationNumberView ()
// 之前显示的数字
@property (nonatomic, strong) NSMutableArray<NSString *> *oldNumbers;
// 之前显示的Label
@property (nonatomic, strong) NSMutableArray<UILabel *> *oldLabelList;
// 当前显示的数字
@property (nonatomic, strong) NSMutableArray<NSString *> *currentNumbers;
// 当前显示的Label
@property (nonatomic, strong) NSMutableArray<UILabel *> *currentLabelList;
// 0-9 所有数字
@property (nonatomic, strong) NSArray *allNumbers;

@property (nonatomic, strong) UIView *contentView;


@end



@implementation AnimationNumberView


#pragma mark - life

- (instancetype)initWithFrame:(CGRect)frame{
  if (self = [super initWithFrame:frame]) {
    self.oldNumbers = [NSMutableArray arrayWithCapacity:1];
    self.currentNumbers = [NSMutableArray arrayWithCapacity:1];
    self.oldLabelList = [NSMutableArray arrayWithCapacity:1];
    self.currentLabelList = [NSMutableArray arrayWithCapacity:1];
    [self addSubview:self.contentView];
  }
  return self;
}



- (void)updateLabelsWithNumber:(NSString *)number{
  
  if (self.oldLabelList.count > 0) {
    // 如果不是第一次显示， 则判断两次数字的差别， 从最后一位开始比较
    NSInteger length = number.length;
    NSInteger oldLength = self.oldLabelList.count;
    for (int i = 0; i < self.currentNumbers.count; i ++) {
      NSString *item = [number substringWithRange:NSMakeRange(length - i-1, 1)];
      UILabel *label = self.currentLabelList[length-i-1];
      
      if (i < self.oldLabelList.count) {
        NSString *oldItem = self.oldNumbers[oldLength - i-1];
        UILabel *oldLabel = self.oldLabelList[oldLength-i-1];
        if (![oldItem isEqualToString:item]) {
          
        //  相同位置， 单个数字， 现在比之前大， 则从上往下， 现在比之前小则从下往上
          CGRect frame = label.frame;
          if (oldItem.integerValue < item.integerValue) {
           frame.origin.y = - label.frame.size.height;
          }else{
           frame.origin.y = label.frame.size.height;
          }
          
          label.frame = frame;
          [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGRect frame = label.frame;
            frame.origin.y = 0;
            label.frame = frame;
            
            CGRect oldFrame = oldLabel.frame;
            if (oldItem.integerValue < item.integerValue) {
              oldFrame.origin.y = oldLabel.frame.size.height;
            }else{
              oldFrame.origin.y = -oldLabel.frame.size.height;
            }
            
            oldLabel.frame = oldFrame;
            
          } completion:^(BOOL finished) {
            [oldLabel removeFromSuperview];
          }];
          
        }else{
          [oldLabel removeFromSuperview];
        }
        
      }else{
        CGRect frame = label.frame;
        frame.origin.y = - label.frame.size.height;
        label.frame = frame;
        
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
          CGRect frame = label.frame;
          frame.origin.y = 0;
          label.frame = frame;
        } completion:^(BOOL finished) {
          
        }];
        
      }
    }
  }
  
  // 当之前的数值比较大时， 移除多出的位数
  if (self.oldLabelList.count > self.currentLabelList.count) {
    for (int i = 0; i < self.oldLabelList.count - self.currentLabelList.count; i ++) {
      UILabel *label = self.oldLabelList[i];
      [label removeFromSuperview];
    }
  }
  
  self.oldLabelList = self.currentLabelList;
  self.oldNumbers = self.currentNumbers;
  
}


- (void)configLabelsWithNumber:(NSString *)number{
  if (number != nil && number.length > 0) {
    [self carveUpNumberWith:number];
    CGRect frame = self.contentView.frame;
    frame.size.height = self.currentLabelList.firstObject.frame.size.height;
    self.contentView.frame = frame;
  }
  
}



#pragma mark - tool method

// 分割数字
- (void)carveUpNumberWith:(NSString *)number{
  NSMutableArray<UILabel *> *labelsList = [NSMutableArray array];
  NSMutableArray<NSString *> *numbersList = [NSMutableArray array];
  for (int i = 0; i < number.length; i++) {
    NSString *stringItem = [number substringWithRange:NSMakeRange(i, 1)];
    UILabel *label = [self createLabels:stringItem];
    CGRect frame = label.frame;
    frame.origin.x = labelsList.count > 0 ? CGRectGetMaxX(labelsList.lastObject.frame) : 0;
    frame.origin.y = 0;
    label.frame = frame;
    [labelsList addObject:label];
    [numbersList addObject:stringItem];
  }
  
  self.currentLabelList = labelsList;
  self.currentNumbers = numbersList;
  
}

// 创建单个Label
- (UILabel *)createLabels:(NSString *)text{
  UILabel *label = [[UILabel alloc] init];
  label.backgroundColor = [UIColor clearColor];
  label.numberOfLines = 0;
  label.text = text;
  label.font = self.numberFont == nil ? [UIFont systemFontOfSize:32.f]:self.numberFont;
  label.textColor = self.numberColor == nil ? [UIColor blackColor]:self.numberColor;
  label.textAlignment = NSTextAlignmentLeft;
  [label sizeToFit];
  [self.contentView addSubview:label];
  return label;
}





#pragma mark - setter

- (void)setCurrentNumber:(NSString *)currentNumber{
  _currentNumber = currentNumber;
  [self configLabelsWithNumber:currentNumber];
  [self updateLabelsWithNumber:currentNumber];
}


#pragma mark - getter

- (UIView *)contentView{
  if (!_contentView) {
    _contentView = [[UIView alloc] initWithFrame:self.bounds];
    _contentView.clipsToBounds = YES;
  }
  return _contentView;
}


- (NSArray *)allNumbers{
  if (!_allNumbers) {
    _allNumbers = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
  }
  return _allNumbers;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
