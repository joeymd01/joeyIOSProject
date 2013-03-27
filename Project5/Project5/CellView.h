//
//  CellView.h
//  Project4
//
//  Created by Joey Dennehy on 2/12/13.
//  Copyright (c) 2013 Joey Dennehy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellView : UICollectionViewCell
{
    UIColor *drawColor;
}

@property (nonatomic, strong) UIBezierPath *path;

-(IBAction) changeColor;

@end
