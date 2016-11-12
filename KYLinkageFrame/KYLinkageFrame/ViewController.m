//
//  ViewController.m
//  KYLinkageFrame
//
//  Created by Sherry Lai on 16/11/12.
//  Copyright © 2016年 KY_zero. All rights reserved.
//

#import "ViewController.h"
#import "KYSegmentView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
@interface ViewController ()
@property (nonatomic, strong) KYSegmentView * segment;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FirstViewController * First=[[FirstViewController alloc]init];
    SecondViewController * Second=[[SecondViewController alloc]init];
    ThirdViewController * Third=[[ThirdViewController alloc]init];
    NSArray *controllers=@[First,Second,Third];
    
    NSArray *titleArray =@[@"AddMoney",@"Mining",@"Withdraw"];
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor greenColor];
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor blueColor];
    UIView *view3 = [[UIView alloc]init];
    view3.backgroundColor = [UIColor orangeColor];
    
    NSArray *headViews = @[view1,view2,view3];
    CGRect rect = [UIScreen mainScreen].bounds;
    self.segment=[[KYSegmentView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height) controllers:controllers titleArray:titleArray headScrollVoews:headViews ParentController:self];
    self.segment.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.segment];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectVCClick:) name:@"selectView" object:nil];
}

- (void)SelectVCClick:(NSNotification *)not
{
    UIButton * btn=not.object;
    NSLog(@"-=-=-=-=-=-%ld",(long)btn.tag);
    if (btn.tag == 1) {
        self.segment.backgroundColor = [UIColor greenColor];
    }else if (btn.tag == 2){
        self.segment.backgroundColor = [UIColor blueColor];
    }else if (btn.tag == 3){
        self.segment.backgroundColor = [UIColor orangeColor];
    }else{}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
