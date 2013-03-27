//
//  dayOfWeekController.m
//  Project5
//
//  Created by Joey Dennehy on 3/26/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import "dayOfWeekController.h"
#import "CellView.h"

@interface dayOfWeekController ()

@end

@implementation dayOfWeekController

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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}
-(void) collectionView: (UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [[collectionView cellForItemAtIndexPath:indexPath] setBackgroundColor:[UIColor blueColor]];
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    [cell setSelected:NO];
    
    NSString *day = @"";
    switch(indexPath.row)
    {
        case 0: day = @"Sun";
            break;
        case 1: day = @"Mon";
            break;
        case 2: day = @"Tues";
            break;
        case 3: day = @"Wed";
            break;
        case 4: day = @"Thur";
            break;
        case 5: day = @"Fri";
            break;
        case 6: day = @"Sat";
            break;
    }
    [(UILabel *)[cell viewWithTag:102] setText:[NSString stringWithFormat:@"%@", day]];
    
    return cell;
}


@end
