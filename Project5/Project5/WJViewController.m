//
//  WJViewController.m
//  weather-json
//
//  Created by John Bender on 2/22/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "WJViewController.h"

static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";

NSMutableArray *TypesOfWeather;
NSMutableArray *YearArray;
NSMutableArray *DayArray;
NSMutableArray *MonthArray;
NSMutableArray *hourArray;

UIPickerView *typePicker;
UIPickerView *datePicker;

@interface WJViewController ()
{
    __weak IBOutlet UIActivityIndicatorView *spinner;
}

@end



@implementation WJViewController  


- (void)viewDidLoad{
    [super viewDidLoad];
    TypesOfWeather = [NSMutableArray new];

    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    
    NSError* error = nil;
    _currentForecast = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    if (error)
    {
        NSLog(@"Error parsing JSON %@: %@", [[NSString alloc] initWithData:json encoding:NSASCIIStringEncoding], [error localizedDescription]);
        return;
    }
    
    //  NSMutableDictionary *currentForecast = [NSMutableDictionary new];
    for( NSDictionary *variable in _currentForecast) {
            if([variable[@"variable"] isEqual:@"tmax2m"])
            {
                [TypesOfWeather addObject:@"Max Temp"];
            }
            else if([variable[@"variable"] isEqual:@"tmin2m"])
            {
                [TypesOfWeather addObject:@"Min Temp"];
            }
            else if([variable[@"variable"] isEqual:@"csnowsfc"])
            {
                [TypesOfWeather addObject:@"Snow at Surface"];
            }
            else if([variable[@"variable"]  isEqual:@"crainsfc"])
            {
                [TypesOfWeather addObject:@"Rain at Surface"];
            }
            else
            {
                [TypesOfWeather addObject:@"Precipitation"];
            }
        YearArray = [NSMutableArray new];
        DayArray = [NSMutableArray new];
        MonthArray = [NSMutableArray new];
        hourArray = [NSMutableArray new];
        
        for(int i = 0; i < [variable[@"values"] count]; ++i)
        {
            
            NSArray *dateAndTime = [variable[@"values"][i][@"date"] componentsSeparatedByString:@"T"];
            NSArray *dateComp = [dateAndTime[0] componentsSeparatedByString:@"-"];
            NSArray *timeComp = [dateAndTime[1] componentsSeparatedByString:@":"];
            if(![YearArray containsObject:dateComp[0]])
            {
                [YearArray addObject:dateComp[0]];
            }
            if(![MonthArray containsObject:dateComp[1]])
            {
                [MonthArray addObject:dateComp[1]];
            }
            if(![DayArray containsObject:dateComp[2]])
            {
                [DayArray addObject:dateComp[2]];
            }
            if(![hourArray containsObject:timeComp[0]])
            {
                [hourArray addObject:timeComp[0]];
            }
        }

        
    }



    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherRefreshed:) name:@"weatherRefreshed" object:nil];

    [self performSelectorInBackground:@selector(refreshWeather) withObject:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
}


-(void) refreshWeather
{
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:_currentForecast];
}


-(void) weatherRefreshed:(NSNotification*)note
{
    [spinner stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if([pickerView.restorationIdentifier isEqual:@"types"])
    {
        typePicker = pickerView;
        return 1;
    }
    else
    {
        datePicker = pickerView;
        return 4;
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([pickerView.restorationIdentifier isEqual:@"types"])
    {
        return TypesOfWeather.count;
    }
    else
    {
        if(YearArray.count > MonthArray.count && YearArray.count > DayArray.count && YearArray.count > hourArray.count)
        {
            return YearArray.count;
        }
        else if(MonthArray.count > YearArray.count && MonthArray.count > DayArray.count && MonthArray.count > hourArray.count)
        {
            return MonthArray.count;
        }
        else if(DayArray.count > YearArray.count && DayArray.count > MonthArray.count && DayArray.count > hourArray.count)
        {
            return DayArray.count;
        }
        else
        {
            return hourArray.count;
        }


    }

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([pickerView.restorationIdentifier isEqual:@"types"])
    {
         return TypesOfWeather[row];
    }
    else
    {
        switch(component)
        {
            case 0:
                if(row < YearArray.count)
                {
                    return YearArray[row];
                }
                break;
            case 1:
                if(row < MonthArray.count)
                {
                    return MonthArray[row];
                }
                break;
            case 2:
                if(row < DayArray.count)
                {
                    return DayArray[row];
                }
                break;
            case 3:
                if(row < hourArray.count)
                {
                    return hourArray[row];
                }
                break;
        }
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if([pickerView.restorationIdentifier isEqual:@"types"])
    {
        NSString *wType = [TypesOfWeather objectAtIndex:[typePicker selectedRowInComponent:0]];
        if([wType isEqual:@"Max Temp"])
        {
            wType = @"tmax2m";
   
        }
        else if([wType isEqual:@"Min Temp"])
        {
            wType = @"tmin2m";
           
        }
        else if([wType isEqual:@"Snow at Surface"])
        {
            wType = @"csnowsfc";
          
        }
        else if([wType  isEqual:@"Rain at Surface"])
        {
            wType = @"crainsfc";
      
        }
        else
        {
            wType = @"apcpsfc";
            
        }
        NSString *date = [YearArray objectAtIndex:[datePicker selectedRowInComponent:0]];
        date = [date stringByAppendingString:@"-"];
        date = [date stringByAppendingString:[MonthArray objectAtIndex:[datePicker selectedRowInComponent:1]]];
        date = [date stringByAppendingString:@"-"];
        date = [date stringByAppendingString:[DayArray objectAtIndex:[datePicker selectedRowInComponent:2]]];
        date = [date stringByAppendingString:@"T"];
        date = [date stringByAppendingString:[hourArray objectAtIndex:[datePicker selectedRowInComponent:3]]];
        date = [date stringByAppendingString:@":00:00.000Z"];
  
        for( NSDictionary *variable in _currentForecast) {
            if([variable[@"variable"] isEqual:wType])
            {
                for(int i = 0; i < [variable[@"values"] count]; ++i)
                {
                    if([variable[@"values"][i][@"date"] isEqual:date])
                    {
                        NSLog(@"%@", variable[@"values"][i][@"predictions"]);
                    }
                }
            }
        }
        
    }
}




@end
