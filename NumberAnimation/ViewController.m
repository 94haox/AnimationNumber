//
//  ViewController.m
//  NumberAnimation
//
//  Created by 吴涛 on 2016/11/24.
//  Copyright © 2016年 吴涛. All rights reserved.
//

#import "ViewController.h"
#import "AnimationNumberView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic)  AnimationNumberView *animationView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.animationView = [[AnimationNumberView alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
  [self.view addSubview:self.animationView];
  // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)confirmAction:(id)sender {
  if (![self isPureInt:self.inputField.text]) {
    self.inputField.text  = @"请输入一个整数";
    return;
  }
  self.animationView.currentNumber = self.inputField.text;
}
- (IBAction)inset1:(id)sender {
  self.animationView.currentNumber = [NSString stringWithFormat:@"%ld",(self.animationView.currentNumber.integerValue +1 )];
  
}
- (IBAction)inset2:(id)sender {
  self.animationView.currentNumber = [NSString stringWithFormat:@"%ld",(self.animationView.currentNumber.integerValue -1 )];
}


- (BOOL)isPureInt:(NSString*)string{
  NSScanner* scan = [NSScanner scannerWithString:string];
  int val;
  return[scan scanInt:&val] && [scan isAtEnd];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
