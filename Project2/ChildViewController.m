//
//  ChildViewController.m
//  Project2
//
//  Created by Joey Dennehy on 1/26/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import "ChildViewController.h"
#import "SubView.h"

@implementation ChildViewController

SubView *subView1,*subView2,*subView3;
int Pattern1 = 1, Pattern2 = 2, Pattern3 = 3;

- (void)viewDidLoad
{
    //[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect frame = CGRectMake( 0., 0., 158.5, 158.5 );
    subView1 = [SubView viewWithFrame:frame:[UIColor colorWithRed:0.3 green:0.5 blue:1. alpha:1.]:1];
    [self.view addSubview:subView1];
    
    frame.size.width = 158.5;
    frame.size.height = 158.5;
    frame.origin.x = frame.size.width + 5;
    frame.origin.y = 0;
    
    subView2 = [SubView viewWithFrame:frame:[UIColor colorWithRed:1. green:.7 blue:0. alpha:1.]:2];
    [self.view addSubview:subView2];
    
    frame.size.width = 158.5;
    frame.size.height = 158.5;
    frame.origin.x = frame.size.width/2 + 2.5;
    frame.origin.y = frame.size.height + 5;
    
    subView3 = [SubView viewWithFrame:frame:[UIColor cyanColor]:3];
    [self.view addSubview:subView3];
   
}

-(void)AlterPatterns
{
    UIBezierPath *temp = subView1.path;
    
    subView1.path = subView3.path;
    //subView1.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20,20,100,100)];
    subView3.path = subView2.path;
    subView2.path = temp;
    
    
    [subView1 setNeedsDisplay];
    [subView2 setNeedsDisplay];
    [subView3 setNeedsDisplay];
    
}


@end
