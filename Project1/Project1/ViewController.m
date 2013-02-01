//
//  ViewController.m
//  Project1
//
//  Created by Joey Dennehy on 1/25/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

// good job, 100%

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int pressCount = 1;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pressButton
{
    ++pressCount;
    
    if(pressCount % 2 == 0)
    {
        ProjLabel.text = @"I was Pressed";
    }
    if(pressCount % 3 == 0)
    {
        ProjLabel.text = @"Stop Pressing Me";
    }
    if(pressCount % 4 == 0)
    {
        ProjLabel.text = @"I'm telling my mom";
    }
}

@end
