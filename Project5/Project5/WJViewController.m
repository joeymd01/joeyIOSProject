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
#import "detailViewController.h"
#import "CellView.h"

@interface WJViewController ()
{
    __weak IBOutlet UIActivityIndicatorView *spinner;
}

@end



@implementation WJViewController

static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";
//http://nomads.ncep.noaa.gov:9090/dods/gens/gens20130103/gep_all_00z.info
//https://weatherparser.herokuapp.com
NSMutableArray *WheatherDates;
NSMutableDictionary *MaxTemp, *MinTemp, *SurSnow, *SurRain, *PreAmt, *SunAmt;

UIImageView *selectedPicture;
detailViewController *details;
double maxPre = 0;

int currentMonth = -1, firstDayOfWeek, currentDay = 1;


- (void)viewDidLoad{
    [super viewDidLoad];
    if(currentMonth == -1)
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        currentMonth = [components month];
    }
    
    details = [detailViewController new];
    
    self.navigationController.title = @"Calendar";
    
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    
    NSError* error = nil;
    _currentForecast = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    if (error)
    {
        NSLog(@"Error parsing JSON %@: %@", [[NSString alloc] initWithData:json encoding:NSASCIIStringEncoding], [error localizedDescription]);
        return;
    }
    double currentTemp = 0, currentMinTemp = 0, currentSnow = 0, currentRain = 0, currentPercept = 0, currentSun = 0;
    int numberOfTemp = 0, numberOfMinTemp = 0, numberOfSnow = 0, numberOfRain = 0, numberOFPer = 0,numberOfSun = 0;
    MaxTemp = [NSMutableDictionary dictionary];
    MinTemp = [NSMutableDictionary dictionary];
    SurSnow = [NSMutableDictionary dictionary];
    SurRain = [NSMutableDictionary dictionary];
    PreAmt = [NSMutableDictionary dictionary];
    SunAmt = [NSMutableDictionary dictionary];
    for( NSDictionary *variable in _currentForecast) {
        
            if([variable[@"variable"] isEqual:@"tmax2m"])
            {
                for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
                {
                    currentTemp = 0;
                    numberOfTemp = 0;
                    
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
                    averageTemp = averageTemp != -1 ? (averageTemp - 273.15) * 1.8 + 32 : -1;
                   
                    [MaxTemp setObject:[NSNumber numberWithInt:averageTemp] forKey:[NSString stringWithFormat:@"%d",days]];
                   
                }
         
            }
        if([variable[@"variable"] isEqual:@"tmin2m"])
        {
            for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
            {
                currentMinTemp = 0;
                numberOfMinTemp = 0;
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
                
                double average = numberOfMinTemp != 0 ? currentMinTemp / numberOfMinTemp : -1;
                average = average != -1 ? (average - 273.15) * 1.8 + 32 : -1;
           
                [MinTemp setObject:[NSNumber numberWithInt:average] forKey:[NSString stringWithFormat:@"%d",days]];
               
            }
        }
        if([variable[@"variable"] isEqual:@"csnowsfc"])
        {
            for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
            {
                currentSnow = 0;
                numberOfSnow = 0;
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
                double average = numberOfSnow != 0 ? currentSnow / numberOfSnow : -1;
   
                [SurSnow setObject:[NSNumber numberWithDouble:average] forKey:[NSString stringWithFormat:@"%d",days]];
            }
        }
        if([variable[@"variable"] isEqual:@"crainsfc"])
        {

            for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
            {
                numberOfRain = 0;
                currentRain = 0;
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
                double average = numberOfRain != 0 ? currentRain / numberOfRain : -1;
               
                [SurRain setObject:[NSNumber numberWithDouble:average] forKey:[NSString stringWithFormat:@"%d",days]];
            }
        }
        if([variable[@"variable"] isEqual:@"apcpsfc"])
        {
            for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
            {
                currentPercept = 0;
                numberOFPer = 0;
                maxPre = 0;
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
                            if([temp doubleValue] > maxPre)
                            {
                                maxPre = [temp doubleValue];
                            }
                        }
                        
                    }
                }
                double average = numberOFPer != 0 ? currentPercept / numberOFPer / maxPre : -1;
   
                [PreAmt setObject:[NSNumber numberWithDouble:average] forKey:[NSString stringWithFormat:@"%d",days]];
            }
        }
        if([variable[@"variable"] isEqual:@"sunsdsfc"])
        {
            for(int days = 1; days <= [self daysInMonths:currentMonth:false]; ++days)
            {
                currentSun = 0;
                numberOfSun = 0;
                for(int i = 0; i < [variable[@"values"] count]; ++i)
                {
                    NSArray *date = [[variable[@"values"][i][@"date"] componentsSeparatedByString:@"T"][0] componentsSeparatedByString:@"-"];
                    
                    
                    
                    if([date[1] integerValue] == currentMonth && [date[2] integerValue] == days)
                    {
                        
                        NSArray *predictions = variable[@"values"][i][@"predictions"];
                        for(NSString *temp in predictions)
                        {
                            currentSun = currentSun + [temp doubleValue];
                            ++numberOfSun;
                        }
                        
                    }
                }
                double average = numberOfSun != 0 ? currentSun / numberOfSun : -1;
                [SunAmt setObject:[NSNumber numberWithDouble:average] forKey:[NSString stringWithFormat:@"%d",days]];
            }
        }
    }
    
    int century = 6 - (20 % 4 * 2);

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
    [spinner stopAnimating];
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
    
    
    
    int day = indexPath.row * 7 + indexPath.section - firstDayOfWeek + 1;
    
        double averageSnow = [[SurSnow valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue] * 100;
        double averageRain = [[SurRain valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue] * 100;
        //double averageTemp = [[MaxTemp valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
        UIImageView *image =  (UIImageView *)[cell viewWithTag:101];
    
        double averageSnowOrRain = averageRain > averageSnow ? averageRain : averageSnow;

        [(UILabel *)[cell viewWithTag:100] setText:[NSString stringWithFormat:@"%d",day]];
    
        if(averageSnowOrRain > 70)
        {
         
            image.image = averageSnowOrRain == averageRain ? [UIImage imageNamed:@"rainy"] : [UIImage imageNamed:@"snow"] ;
           
        }
        else if(averageSnowOrRain > 50 && averageSnowOrRain < 70)
        {
            
                image.image = [UIImage imageNamed:@"cloudy"];
            
        }
        else if(averageSnowOrRain > 25 && averageSnowOrRain < 50)
        {
            
            image.image = [UIImage imageNamed:@"partly-cloudy"];
            
        }
        else
        {
            image.image = [UIImage imageNamed:@"sunny"];
        }
        if(averageSnowOrRain < 0)
        {
            cell.backgroundColor = [UIColor whiteColor];
            cell.userInteractionEnabled = NO;
            image.image = [UIImage imageNamed:@"x-mark-16"];
        
        }
        if(day < 1 || day > [self daysInMonths:currentMonth:false])
        {
            [(UILabel *)[cell viewWithTag:100] setText:[NSString stringWithFormat:@""]];
            cell.backgroundColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
            image.image = nil;
        
        }
    

    return cell;
}
-(void) collectionView: (UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


    [[collectionView cellForItemAtIndexPath:indexPath] setBackgroundColor:[UIColor blueColor]];
}

-(void) collectionView: (UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     [[collectionView cellForItemAtIndexPath:indexPath] setBackgroundColor:[UIColor whiteColor]];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    details = [segue destinationViewController];
    selectedPicture = (UIImageView *)[sender viewWithTag:101];
    [details setMainImage:selectedPicture ];
    int day = [((UILabel *)[sender viewWithTag:100]).text intValue];
    
    double averageMax = [[MaxTemp valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
    double averageMin = [[MinTemp valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
    double averageRain = [[SurRain valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
    double averageSnow = [[SurSnow valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
    double averagePer = [[PreAmt valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
    double averageSun = [[SunAmt valueForKey:[NSString stringWithFormat:@"%d",day]] doubleValue];
    NSLog(@"percept %f",averagePer);
    [details setValues:averageMax:averageMin:averageRain:averageSnow:averagePer:averageSun];
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
    return @"";
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
    return -1;
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
    return -1;
}


@end
