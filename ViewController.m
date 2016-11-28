//
//  ViewController.m
//  CSCUtil
//
//  Created by csc on 16/8/19.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CSCView.h"

#import "CoreTextView.h"
//#import "UIImage+CSCategory.h"
#import "ScaleLabel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self createView];
    
    //[self createCoretext];
    
    //[self createCircleImg];
    
    //[self createScaleLabel];
    //[self createCircleView];
}

-(void)createView
{
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 200, 100)];
    view1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view1];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(50, view1.bottom+5, 200, 100)];
    view2.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view2];
}

-(void)createCoretext
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CoreTextView * coreText = [[CoreTextView alloc]initWithFrame:CGRectMake(10, 70, width, 1000)];
    [self.view addSubview:coreText];
    
}

-(void)createCircleImg
{
    UIImageView * imgv = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    
    UIImage * circleImg = [UIImage imageNamed:@"anjiabao"];
    circleImg = [circleImg cutCircleImage];
    [imgv setImage:circleImg];
    [self.view addSubview:imgv];
    
}

-(void)createScaleLabel
{
    ScaleLabel * lable = [[ScaleLabel alloc]initWithFrame:CGRectMake(50, 100, 220, 30)];
    lable.text = @"为人民服务";
    lable.startScale = 0.3;
    lable.endScale = 2.5;
    [lable startAnimation];
    [self.view addSubview:lable];
    
}

-(void)createCircleView
{
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 200) radius:25 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    CAShapeLayer * lgryLayer = [CAShapeLayer layer];
    lgryLayer.path = path.CGPath;
    lgryLayer.fillColor = [UIColor yellowColor].CGColor;
    lgryLayer.strokeColor = [UIColor blackColor].CGColor;
    
    
    CABasicAnimation * animat = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animat.fromValue = @(0);
    animat.toValue = @(.7);
    animat.duration = 1.6;
    animat.fillMode = kCAFillModeForwards;
    animat.removedOnCompletion = NO;
    
    [self.view.layer addSublayer:lgryLayer];
    [lgryLayer addAnimation:animat forKey:@"stir"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
