//
//  CellView.m
//  Project4
//
//  Created by Joey Dennehy on 2/12/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import "CellView.h"

@implementation CellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
       
        // Initialization code
    }
    return self;
}


-(IBAction) changeColor
{
    self.backgroundColor = [UIColor redColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
