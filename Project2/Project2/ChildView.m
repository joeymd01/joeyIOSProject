//
//  ChildView.m
//  Project2
//
//  Created by Joey Dennehy on 1/26/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import "ChildView.h"

@implementation ChildView

-(void) doLayout
{
    self.backgroundColor = [UIColor colorWithRed:1. green:.7 blue:0. alpha:1.];
}

+(id) viewWithFrame:(CGRect)frame
{
    ChildView *newView = [[ChildView alloc] initWithFrame:frame];
    return newView;
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog( @"initwithframe" );
    self = [super initWithFrame:frame];
    if (self) {
        [self doLayout];
    }
    NSLog( @"%@", [self description] );
    return self;
}

@end
