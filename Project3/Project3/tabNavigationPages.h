//
//  tabNavigationPages.h
//  Project3
//
//  Created by Joey Dennehy on 2/3/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tabNavigationPages : UIPageViewController
{
    IBOutlet UIPageControl *pagecontroller;
}

-(IBAction)changePageLength;

@end
