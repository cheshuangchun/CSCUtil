//
//  ScaleLabel.m
//  CSCUtil
//
//  Created by csc on 16/8/22.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "ScaleLabel.h"
@implementation ScaleLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _backedLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _backedLabel.textColor = [UIColor yellowColor];
        _colorLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _colorLabel.textColor = [UIColor cyanColor];
        
        _backedLabel.alpha = 0;
        _colorLabel.alpha = 0;
        
        _backedLabel.textAlignment = NSTextAlignmentCenter;
        _colorLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_backedLabel];
        [self addSubview:_colorLabel];
        
    }
    return self;
}

-(void)setStartScale:(CGFloat )startScale
{
    _startScale = startScale;
    _backedLabel.transform = CGAffineTransformMake(_startScale, 0, 0, _startScale, 0, 0);
    _colorLabel.transform  = CGAffineTransformMake(_startScale, 0, 0, _startScale, 0, 0);
}

-(void)setText:(NSString *)text
{
    _backedLabel.text = text;
    _colorLabel.text = text;
}

-(void)startAnimation
{
    if(_endScale == 0)
    {
        _endScale = 2.0f;
    }
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backedLabel.alpha = 1.;
        _backedLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        
        _colorLabel.alpha = 1.f;
        _colorLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 delay:0.5 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _colorLabel.alpha = 0;
            _colorLabel.transform = CGAffineTransformMake(_endScale, 0, 0, _endScale, 0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }];
}


@end
