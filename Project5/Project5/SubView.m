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

-(void) doLayout
{
    self.backgroundColor = background;

    
}

+(id) viewWithFrame:(CGRect)frame: (UIColor*) color
{
    background = color;
    SubView *newSubView = [[SubView alloc] initWithFrame:frame];
    
    
    
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



@end
