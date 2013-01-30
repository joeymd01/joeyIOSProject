//
//  SubView.h
//  Project2
//
//  Created by Joey Dennehy on 1/27/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubView : UIView
{
        
        UIColor *drawColor;
}

@property (nonatomic, strong) UIBezierPath *path;

+(id) viewWithFrame:(CGRect)frame: (UIColor*) colora: (int) pattern;

@end
