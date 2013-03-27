//
//  WJViewController.m
//  weather-json
//
//  Created by John Bender on 2/22/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

// Good job, except dataWithContentsOfURL is a blocking call and should be performed
// in the background (inside refreshWeather). Call [picker reloadAllComponents] when it's done.
// And then display the weather prediction in a text view... 85%.

#import "WJViewController.h"
#import "CellView.h"

@interface WJViewController ()

@end



@implementation WJViewController

static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";

NSMutableArray *WheatherDates;
NSMutableDictionary *MaxTemp, *MinTemp, *SurSnow, *SurRain, *PreAmt;



int currentMonth = -1, firstDayOfWeek, currentDay = 1;


- (void)viewDidLoad{
    [super viewDidLoad];
    if(currentMonth == -1)
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        currentMonth = [components month];
    }

    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    
    NSError* error = nil;
    _currentForecast = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    if (error)
    {
        NSLog(@"Error parsing JSON %@: %@", [[NSString alloc] initWithData:json encoding:NSASCIIStringEncoding], [error localizedDescription]);
        return;
    }
    double currentTemp = 0, currentMinTemp = 0, currentSnow = 0, currentRain = 0, currentPercept = 0;
    int numberOfTemp = 0, numberOfMinTemp = 0, numberOfSnow = 0, numberOfRain = 0, numberOFPer = 0;
    MaxTemp = [NSMutableDictionary dictionary];
    SurSnow = [NSMutableDictionary dictionary];
    SurRain = [NSMutableDictionary dictionary];
    for( NSDictionary *variable in _currentForecast) {
        
            if([variable[@"variable"] isEqual:@"tmax2m"])
            {
                currentTemp = 0;
                numberOfTemp = 0;
                for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
                {
                    
                    for(int i = 0; i < [variable[@"values"] count]; ++i)
                    {
                        NSArray *date = [[variable[@"values"][i][@"date"] componentsSeparatedByString:@"T"][0] componentsSeparatedByString:@"-"];
                            
                        
                        if([date[1] integerValue] == currentMonth && [date[2] integerValue] == days)
                        {
                            
                            NSArray *predictions = variable[@"values"][i][@"predictions"];
                            for(NSString *temp in predictions)
                            {
                                currentTemp = currentTemp + [temp doubleValue];
                                ++numberOfTemp;
                            }
                            
                        }
                    }
                    double averageTemp = numberOfTemp != 0 ? currentTemp / numberOfTemp : -1;
                   
                    [MaxTemp setObject:[NSNumber numberWithInt:averageTemp] forKey:[NSString stringWithFormat:@"%d",days]];
                   
                }
         
            }
        if([variable[@"variable"] isEqual:@"tmin2m"])
        {
            for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
            {
                for(int i = 0; i < [variable[@"values"] count]; ++i)
                {
                    NSArray *date = [[variable[@"values"][i][@"date"] componentsSeparatedByString:@"T"][0] componentsSeparatedByString:@"-"];
                    
                    
                    
                    if([date[1] integerValue] == currentMonth && [date[2] integerValue] == days)
                    {
                        
                        NSArray *predictions = variable[@"values"][i][@"predictions"];
                        for(NSString *temp in predictions)
                        {
                            currentMinTemp = currentMinTemp + [temp doubleValue];
                            ++numberOfMinTemp;
                        }
                        
                    }
                }
                double average = currentMinTemp != 0 ? currentMinTemp / numberOfMinTemp : 0;
                [MinTemp setObject:[NSNumber numberWithInt:average] forKey:[NSString stringWithFormat:@"%d",days]];
            }
        }
        if([variable[@"variable"] isEqual:@"csnowsfc"])
        {
            for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
            {
                for(int i = 0; i < [variable[@"values"] count]; ++i)
                {
                    NSArray *date = [[variable[@"values"][i][@"date"] componentsSeparatedByString:@"T"][0] componentsSeparatedByString:@"-"];
                    
                    
                    
                    if([date[1] integerValue] == currentMonth && [date[2] integerValue] == days)
                    {
                        
                        NSArray *predictions = variable[@"values"][i][@"predictions"];
                        for(NSString *temp in predictions)
                        {
                            currentSnow = currentSnow + [temp doubleValue];
                            ++numberOfSnow;
                        }
                        
                    }
                }
                double average = currentSnow != 0 ? currentSnow / numberOfSnow : 0;
                [SurSnow setObject:[NSNumber numberWithInt:average] forKey:[NSString stringWithFormat:@"%d",days]];
            }
        }
        if([variable[@"variable"] isEqual:@"crainsfc"])
        {
            for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
            {
                for(int i = 0; i < [variable[@"values"] count]; ++i)
                {
                    NSArray *date = [[variable[@"values"][i][@"date"] componentsSeparatedByString:@"T"][0] componentsSeparatedByString:@"-"];
                    
                    
                    
                    if([date[1] integerValue] == currentMonth && [date[2] integerValue] == days)
                    {
                        
                        NSArray *predictions = variable[@"values"][i][@"predictions"];
                        for(NSString *temp in predictions)
                        {
                            currentRain = currentRain + [temp doubleValue];
                            ++numberOfRain;
                        }
                        
                    }
                }
                double average = currentRain != 0 ? currentRain / numberOfRain : 0;
                [SurRain setObject:[NSNumber numberWithInt:average] forKey:[NSString stringWithFormat:@"%d",days]];
            }
        }
        if([variable[@"variable"] isEqual:@"apcpsfc"])
        {
            for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
            {
                for(int i = 0; i < [variable[@"values"] count]; ++i)
                {
                    NSArray *date = [[variable[@"values"][i][@"date"] componentsSeparatedByString:@"T"][0] componentsSeparatedByString:@"-"];
                    
                    
                    
                    if([date[1] integerValue] == currentMonth && [date[2] integerValue] == days)
                    {
                        
                        NSArray *predictions = variable[@"values"][i][@"predictions"];
                        for(NSString *temp in predictions)
                        {
                            currentPercept = currentPercept + [temp doubleValue];
                            ++numberOFPer;
                        }
                        
                    }
                }
                double average = currentPercept != 0 ? currentPercept / numberOFPer : 0;
                [PreAmt setObject:[NSNumber numberWithInt:average] forKey:[NSString stringWithFormat:@"%d",days]];
            }
        }
    }
    
    int century = 6 - (20 % 4 * 2);
    //

    firstDayOfWeek = ((1 + [self monthsTable:currentMonth:false] + 13 +  13 / 4 + century) % 7);
    if(firstDayOfWeek > 6)
    {
        firstDayOfWeek = firstDayOfWeek % 7;
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
    //[spinner stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 7;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"com.invasivecode.cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    
    
    int day;
    if(indexPath.row == 1 && indexPath.section >= firstDayOfWeek)
    {
        day = indexPath.section - firstDayOfWeek + 1;
    }
    else
    {
        day = indexPath.row * 7 + indexPath.section - firstDayOfWeek + 1;
    }
    
        //double averageSnow = [[SurSnow valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
        //double averageRain = [[SurRain valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
        double averageTemp = [[MaxTemp valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
        UIImageView *image =  (UIImageView *)[cell viewWithTag:101];
    
        [(UILabel *)[cell viewWithTag:100] setText:[NSString stringWithFormat:@"%d",day]];
    
        if(averageTemp > 270)
        {
         
                image.image = [UIImage imageNamed:@"sunny"];
           
        }
        else if(averageTemp >= 265 && averageTemp < 270)
        {
            
                image.image = [UIImage imageNamed:@"partly-cloudy"];
            
        }
        else
        {
            image.image = [UIImage imageNamed:@"cloudy"];
        }
    if(averageTemp <= 0)
    {
        cell.backgroundColor = [UIColor grayColor];
        cell.userInteractionEnabled = NO;
        image.image = nil;
        
    }
    if(averageTemp == 0)
    {
         [(UILabel *)[cell viewWithTag:100] setText:[NSString stringWithFormat:@""]];
         image.image = nil;
    }
    

    return cell;
}
-(void) collectionView: (UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    [[collectionView cellForItemAtIndexPath:indexPath] setBackgroundColor:[UIColor blueColor]];
}

-(NSString *) GetCurrentMonth
{
    switch(currentMonth)
    {
        case 1: return @"January";
            break;
        case 2: return @"Feburary";
            break;
        case 3: return @"March";
            break;
        case 4: return @"April";
            break;
        case 5: return @"May";
            break;
        case 6: return @"June";
            break;
        case 7: return @"July";
            break;
        case 8: return @"August";
            break;
        case 9: return @"September";
            break;
        case 10: return @"October";
            break;
        case 11: return @"November";
            break;
        case 12: return @"December";
            break;
    }
}

-(int) GetCurrentMonthInteger
{
    return currentMonth;
}

-(void)SetCurrentMonth: (int)month
{
    currentMonth = month;
    if(currentMonth > 12)
    {
        currentMonth = 1;
    }
    if(currentMonth < 1)
    {
        currentMonth = 12;
    }
    
    [self.view setNeedsDisplay];
 
}

-(int)monthsTable:(int)month:(bool) leapYear
{
    switch(month)
    {
        case 1:
            if(leapYear)
            {
                return 6;
            }
            else
            {
                return 0;
            }
            break;
        case 2:
            if(leapYear)
            {
                return 2;
            }
            else
            {
                return 3;
            }
            break;
        case 3: return 3;
            break;
        case 4: return 6;
            break;
        case 5: return 1;
            break;
        case 6: return 4;
            break;
        case 7: return 6;
            break;
        case 8: return 2;
            break;
        case 9: return 5;
            break;
        case 10: return 0;
            break;
        case 11: return 3;
            break;
        case 12: return 5;
            break;
            
    }
}

-(int)daysInMonths:(int)month:(bool) leapYear
{
    switch(month)
    {
        case 1:
            return 31;
            break;
        case 2:
            if(leapYear)
            {
                return 29;
            }
            else
            {
                return 28;
            }
            break;
        case 3: return 31;
            break;
        case 4: return 30;
            break;
        case 5: return 31;
            break;
        case 6: return 30;
            break;
        case 7: return 31;
            break;
        case 8: return 31;
            break;
        case 9: return 30;
            break;
        case 10: return 31;
            break;
        case 11: return 30;
            break;
        case 12: return 31;
            break;
            
    }
}



@end
