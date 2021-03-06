//
//  KYSegmentView.m
//  KYLinkageFrame
//
//  Created by Sherry Lai on 16/11/12.
//  Copyright © 2016年 KY_zero. All rights reserved.
//

#import "KYSegmentView.h"

@implementation KYSegmentView
- (instancetype)initWithFrame:(CGRect)frame  controllers:(NSArray*)controllers titleArray:(NSArray*)titleArray headScrollVoews:(NSArray *)headScrollVoews ParentController:(UIViewController*)parentC{
    if ( self=[super initWithFrame:frame])
    {
        self.controllers=controllers;
        self.nameArray=titleArray;
        self.headScrollViews = headScrollVoews;
        self.segmentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 64)];
        self.segmentView.tag=500;
        [self addSubview:self.segmentView];
        
        
        self.headScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width * self.controllers.count,64)];
        self.headScrollView.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.headScrollView.delegate=self;
        self.headScrollView.showsHorizontalScrollIndicator=NO;
        self.headScrollView.pagingEnabled=YES;
        self.headScrollView.bounces=NO;
        [self.segmentView addSubview:self.headScrollView];
        
        
        self.segmentScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, frame.size.width, frame.size.height -40)];
        self.segmentScrollV.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.segmentScrollV.tag = 600;
        self.segmentScrollV.delegate=self;
        self.segmentScrollV.showsHorizontalScrollIndicator=NO;
        self.segmentScrollV.pagingEnabled=YES;
        self.segmentScrollV.bounces=NO;
        [self addSubview:self.segmentScrollV];
        
        for (int i=0;i<self.controllers.count;i++)
        {
            UIViewController * contr=self.controllers[i];
            [self.segmentScrollV addSubview:contr.view];
            contr.view.frame=CGRectMake(i*frame.size.width, 0, frame.size.width,frame.size.height);
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        for (int i=0;i<self.controllers.count;i++)
        {
            UIView * contr=self.headScrollViews[i];
            contr.frame=CGRectMake(i*frame.size.width, 0, frame.size.width,64);
            [self.headScrollView addSubview:contr];
        }
        
        for (int i=0;i<self.controllers.count;i++)
        {
            UIButton * btn=[ UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*(frame.size.width/self.controllers.count), 22, frame.size.width/self.controllers.count, 40);
            btn.tag=i + 1;
            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font=[UIFont systemFontOfSize:17];
            if (i==0)
            {
                btn.selected=YES ;
                self.seleBtn=btn;
                btn.titleLabel.font=[UIFont systemFontOfSize:19];
            } else {
                btn.selected=NO;
            }
            
            [self addSubview:btn];
        }
    }
    self.line=[[UILabel alloc]initWithFrame:CGRectMake(0,61.5, frame.size.width/self.controllers.count, 3)];
    self.line.backgroundColor=[UIColor redColor];
    self.line.tag=100;
    [self.segmentView addSubview:self.line];
    
    self.down=[[UILabel alloc]initWithFrame:CGRectMake(0, 63.5, frame.size.width, 0.5)];
    self.down.backgroundColor=[UIColor grayColor];
    [self.segmentView addSubview:self.down];
    
    return self;
}
- (void)Click:(UIButton*)sender
{
    self.seleBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font=[UIFont systemFontOfSize:19];
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag - 1);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag - 1)*self.frame.size.width, 0) animated:YES ];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectView" object:sender userInfo:nil];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIButton * btn=(UIButton*)[self viewWithTag:((self.segmentScrollV.contentOffset.x/self.frame.size.width) +1)];
    self.seleBtn.selected=NO;
    self.seleBtn=btn;
    self.seleBtn.selected=YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
        
    }];
    
    if(scrollView == self.segmentScrollV)
    {
        self.headScrollView.delegate = nil;
        [self.headScrollView setContentOffset:self.segmentScrollV.contentOffset];
        self.headScrollView.delegate = self;
    }else {
        self.segmentScrollV.delegate = nil;
        [self.segmentScrollV setContentOffset:self.headScrollView.contentOffset];
        self.segmentScrollV.delegate = self;
    }
    
}

@end
