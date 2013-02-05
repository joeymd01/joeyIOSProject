//
//  TabNavigationController.m
//  Project3
//
//  Created by Joey Dennehy on 2/3/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import "TabNavigationController.h"
#import "AdditionalView.h"

@interface TabNavigationController ()

@end

@implementation TabNavigationController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addNewView
{
    AdditionalView *newView = [AdditionalView new];
    
    [self.navigationController pushViewController:newView animated:YES];
}

@end
