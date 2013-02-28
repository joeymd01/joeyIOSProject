//
//  WJViewController.h
//  weather-json
//
//  Created by John Bender on 2/22/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    IBOutlet UIPickerView *typePicker;
    IBOutlet UIPickerView *datePicker;
}

@property (strong, nonatomic) NSMutableDictionary *currentForecast;


@end
