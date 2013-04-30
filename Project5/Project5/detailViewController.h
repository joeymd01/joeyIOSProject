//
//  detailViewController.h
//  Project5
//
//  Created by Joey Dennehy on 4/5/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController
{
    IBOutlet UILabel *HighTemp;
    IBOutlet UILabel *LowTemp;
    IBOutlet UILabel *rainLabel;
    IBOutlet UILabel *snowLabel;
    IBOutlet UILabel *PreLabel;
    IBOutlet UILabel *sunLabel;
}

@property (nonatomic, strong) UIBezierPath *path;

+(id) viewWithFrame:(CGRect)frame: (UIColor*) colora: (int) pattern;

-(IBAction)GoBackToCalander;

-(void) setMainImage: (UIImageView *) picture;
-(void) setButtonLabel: (NSString *)picture;
-(void) setValues: (double)maxTemp: (double)minTemp: (double) Rain: (double) Snow: (double) Pre: (double) Sun;


@end
