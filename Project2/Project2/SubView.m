//
//  SubView.m
//  Project2
//
//  Created by Joey Dennehy on 1/27/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import "SubView.h"

@implementation SubView

UIColor *background;
int Pattern;

-(void) doLayout
{
    self.backgroundColor = background;
    
    drawColor = [UIColor redColor];
    
    if(Pattern == 1)
    {
        _path = [UIBezierPath bezierPathWithRect:CGRectMake(20,20,100,100)];
    }
    else if(Pattern == 2)
    {
        _path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20,20,100,100)];
    }
    else
    {
        _path = [UIBezierPath bezierPath];
        [_path moveToPoint:CGPointMake(79, 20)];
        [_path addLineToPoint:CGPointMake(99, 150)];
        [_path addLineToPoint:CGPointMake(59, 150)];
        [_path closePath];
    }

    
}

+(id) viewWithFrame:(CGRect)frame: (UIColor*) color: (int) pattern
{
    background = color;
    SubView *newSubView = [[SubView alloc] initWithFrame:frame];
    Pattern = pattern;
    
    
    
    return newSubView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doLayout];
    }
        return self;
}

-(void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [drawColor set];
    [_path stroke];
    
    
}


@end
