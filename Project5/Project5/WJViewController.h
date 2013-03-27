//
//  WJViewController.h
//  weather-json
//
//  Created by John Bender on 2/22/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface WJViewController : UIViewController <UICollectionViewDataSource>

-(NSString *) GetCurrentMonth;
-(int) GetCurrentMonthInteger;
-(void)SetCurrentMonth: (int)month;
-(int)monthsTable;
-(int)dayInMonths;

@property (nonatomic, weak) IBOutlet UICollectionView *cView;
@property (strong, nonatomic) NSMutableDictionary *currentForecast;


@end
