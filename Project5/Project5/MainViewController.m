//
//  MainViewController.m
//  Project5
//
//  Created by Joey Dennehy on 3/24/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import "MainViewController.h"
#import "WJViewController.h"
#import "dayOfWeekController.h"
#import "detailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

WJViewController *childViewController;
UINavigationController *nav;
dayOfWeekController *childDOW;

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
    
    childDOW = (dayOfWeekController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"daysOfWeek"];
    
    [self addChildViewController:childDOW];
    
    childDOW.view.frame = CGRectMake(0, 44, childDOW.view.frame.size.width, childDOW.view.frame.size.height);
    
    [self.view addSubview:childDOW.view];
    
    childViewController = (WJViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"childviewcontroller"];
    
    
    [self addChildViewController:childViewController];
    
    childViewController.view.frame = CGRectMake(0, 65, childViewController.view.frame.size.width, childViewController.view.frame.size.height);
    
    [self.view addSubview:childViewController.view];
    
    
    
        
    [monthLabel setText:[childViewController GetCurrentMonth]];
    
    
    [next setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [prev setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    
    [next setBackgroundColor:[UIColor lightGrayColor]];
    [prev setBackgroundColor:[UIColor lightGrayColor]];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)NextMonth
{
    [childViewController SetCurrentMonth:[childViewController GetCurrentMonthInteger] + 1];
    [monthLabel setText:[childViewController GetCurrentMonth]];
    [childViewController removeFromParentViewController];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    childViewController = (WJViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"childviewcontroller"];
    
    
    [self addChildViewController:childViewController];
    
    childViewController.view.frame = CGRectMake(0, 65, childViewController.view.frame.size.width, childViewController.view.frame.size.height);
    
    [self.view addSubview:childViewController.view];    //[next setBackgroundColor:[UIColor whiteColor]];

    
}
-(IBAction)PreviousMonth
{
    [childViewController SetCurrentMonth:[childViewController GetCurrentMonthInteger] - 1];
    [monthLabel setText:[childViewController GetCurrentMonth]];
    [childViewController removeFromParentViewController];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    childViewController = (WJViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"childviewcontroller"];
    
    [self addChildViewController:childViewController];
    
    childViewController.view.frame = CGRectMake(0, 65, childViewController.view.frame.size.width, childViewController.view.frame.size.height);
    
    [self.view addSubview:childViewController.view];
}



@end
