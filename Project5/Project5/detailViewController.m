//
//  detailViewController.m
//  Project5
//
//  Created by Joey Dennehy on 4/5/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import "detailViewController.h"
#import "SubView.h"

@interface detailViewController ()

@end

UIImageView *mainPicture;
NSString *label;
double maxtemp, mintemp, rain, snow, pre, sun;
UINavigationController *navBarController;
SubView *subView1,*subView2, *subview3, *subview4;

@implementation detailViewController

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
    UIImageView *image = (UIImageView *)[self.view viewWithTag:103];
    image.image = mainPicture.image;
    [HighTemp setText:[NSString stringWithFormat:@"%d%@F",(int)maxtemp,  @"\u00B0"]];
    [LowTemp setText: [NSString stringWithFormat:@"%d%@F",(int)mintemp,  @"\u00B0"]];
    
    CGRect frame = CGRectMake( 113., 218., 190 * rain, 10. );
    subView1 = [SubView viewWithFrame:frame:[UIColor colorWithRed:0.3 green:0.5 blue:1. alpha:1.]];
    [self.view addSubview:subView1];
    
    frame.size.width = 190 * snow;
    //frame.size.width = 190;
    frame.size.height = 10;
    frame.origin.x = 113;
    frame.origin.y = 261;
    
    subView2 = [SubView viewWithFrame:frame:[UIColor colorWithRed:0.5 green:0.5 blue:1. alpha:1.]];
    [self.view addSubview:subView2];
    
    frame.size.width = 190 * pre;
    //frame.size.width = 190;
    frame.size.height = 10;
    frame.origin.x = 113;
    frame.origin.y = 304;
    
    subview3 = [SubView viewWithFrame:frame:[UIColor colorWithRed:0.5 green:0.5 blue:1. alpha:1.]];
    [self.view addSubview:subview3];
    
    frame.size.width = 190 * (24 / (sun / 360));
    //frame.size.width = 190;
    frame.size.height = 10;
    frame.origin.x = 113;
    frame.origin.y = 347;
    
    subview4 = [SubView viewWithFrame:frame:[UIColor colorWithRed:0.5 green:0.5 blue:1. alpha:1.]];
    [self.view addSubview:subview4];

    rainLabel.text = [NSString stringWithFormat:@"Rain(%d%%)",(int)(rain * 100)];
    snowLabel.text = [NSString stringWithFormat:@"Snow(%d%%)",(int)(snow * 100)];
    PreLabel.text = [NSString stringWithFormat:@"Prec.(%d%%)",(int)(pre * 100)];
    sunLabel.text = [NSString stringWithFormat:@"Sun(%d%%)",(int)((24 / (sun / 360)) * 100)];

}

-(void) setMainImage: (UIImageView *)picture
{
    mainPicture = picture;

}

-(void) setButtonLabel: (NSString *)picture
{
    label = picture;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setValues: (double)maxTemp: (double)minTemp: (double)Rain: (double)Snow: (double) Pre: (double) Sun
{
    maxtemp = maxTemp;
    mintemp = minTemp;
    rain = Rain;
    snow = Snow;
    pre = Pre;
    sun = Sun;
    
}

-(IBAction)GoBackToCalander
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
