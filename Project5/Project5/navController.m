//
//  navController.m
//  Project5
//
//  Created by Joey Dennehy on 4/12/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import "navController.h"
#import "WJViewController.h"

@interface navController ()

@end

@implementation navController

WJViewController *childViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    childViewController = (WJViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"childviewcontroller"];
    
    
    [self addChildViewController:childViewController];
    
    childViewController.view.frame = CGRectMake(0, 65, childViewController.view.frame.size.width, childViewController.view.frame.size.height);
    
    [self.view addSubview:childViewController.view];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
