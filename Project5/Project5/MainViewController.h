//
//  MainViewController.h
//  Project5
//
//  Created by Joey Dennehy on 3/24/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
{
    IBOutlet UILabel *monthLabel;
    IBOutlet UIButton *next;
    IBOutlet UIButton *prev;
}

-(IBAction)NextMonth;
-(IBAction)PreviousMonth;

@end
