//
//  KYSegmentView.h
//  KYLinkageFrame
//
//  Created by Sherry Lai on 16/11/12.
//  Copyright © 2016年 KY_zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYSegmentView : UIView <UIScrollViewDelegate>
@property (nonatomic,strong)NSArray * nameArray;
@property (nonatomic,strong)NSArray * headScrollViews;
@property (nonatomic,strong)UIScrollView * headScrollView;
@property (nonatomic,strong)NSArray *controllers;
@property (nonatomic,strong)UIView * segmentView;
@property (nonatomic,strong)UIScrollView * segmentScrollV;
@property (nonatomic,strong)UILabel * line;
@property (nonatomic ,strong)UIButton * seleBtn;
@property (nonatomic,strong)UILabel * down;

- (instancetype)initWithFrame:(CGRect)frame  controllers:(NSArray*)controllers titleArray:(NSArray*)titleArray headScrollVoews:(NSArray *)headScrollVoews ParentController:(UIViewController*)parentC;

@end
