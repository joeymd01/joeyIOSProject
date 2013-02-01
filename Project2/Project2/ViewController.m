//
//  ViewController.m
//  Project2
//
//  Created by Joey Dennehy on 1/26/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

// 100%

#import "ViewController.h"
#import "ChildViewController.h"


@interface ViewController ()

@end

@implementation ViewController

ChildViewController *childViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
     
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    childViewController = (ChildViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"childviewcontroller"];
    
    [self addChildViewController:childViewController];
    
    childViewController.view.frame = CGRectMake(0, 130, childViewController.view.frame.size.width, childViewController.view.frame.size.height);
    
    [self.view addSubview:childViewController.view];


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) DoAlterPattern
{
    [childViewController AlterPatterns];
}


@end
