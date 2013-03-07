//
//  ViewController.m
//  Project4
//
//  Created by Joey Dennehy on 2/12/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

// Mostly there, 90%. You were supposed to select a single row per column, but this
// code selects a single column per row. The implementation is fairly different.

#import "ViewController.h"
#import "CellView.h"

@interface ViewController ()

@end



@implementation ViewController

NSMutableArray *rows;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    rows = [NSMutableArray new];
    for(int j = 0; j < 7; ++j)
    {
        NSMutableArray *sections = [NSMutableArray new];
        for(int i = 0; i < 10; ++i)
        {
            [sections addObject:[NSNumber numberWithInteger:0]];
        }
        [rows addObject:sections];
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"com.invasivecode.cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    //NSString *str = [NSString stringWithFormat:@"%d", indexPath.row+1];

    return cell;
}
-(void) collectionView: (UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for(int i = 0; i < 10; ++i)
    {
        if([[[rows objectAtIndex:indexPath.row] objectAtIndex:i] integerValue] == 1)
        {
            [[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:i]] setBackgroundColor:[UIColor blueColor]];
            [[rows objectAtIndex:indexPath.row] replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:0]];
            
        }
    }
    [[rows objectAtIndex:indexPath.row] replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithInteger:1]];
    
    [[collectionView cellForItemAtIndexPath:indexPath] setBackgroundColor:[UIColor redColor]];
}

-(void) collectionView: (UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    for(int j = 0; j < 7; ++j)
    {
       
        for(int i = 0; i < 10; ++i)
        {
            if([[[rows objectAtIndex:j] objectAtIndex:i] integerValue] == 1)
            {
                [[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]] setBackgroundColor:[UIColor redColor]];
               
            }
        }
    }

}
@end
