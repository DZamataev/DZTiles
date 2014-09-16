//
//  DZTile.h
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZTiles_Constants.h"

@class DZTileCollectionViewCell;
@class DZTileTransformationHelper;

@interface DZTile : NSObject
// this property is set to cell by view controller on cellForRow: before onViewUpdate block is called and
// is set to nil by view controller on didEndDisplayingCell:, so you can use this property to update cell while it is displayed
@property (nonatomic, strong) UICollectionViewCell *displayedCell;

@property (nonatomic, strong) NSString *cellReusableIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGSize blockSizeMultiplier;

@property (nonatomic, strong) id userData;

@property (nonatomic, strong) NSTimer *rotationTimer;
@property (nonatomic, assign) BOOL isFacingBackwards;

@property (nonatomic, copy) void (^onViewUpdate)(DZTile *tile, UICollectionViewCell *cell);

@property (nonatomic, copy) void (^onTransformation)(DZTile *tile, bool isDisplayed, UICollectionViewCell *cell, DZTileTransformationType transformationType, NSNumber **shouldPerformTransformation);

@property (nonatomic, copy) void (^onDidSelect)(DZTile *tile, UICollectionViewCell *cell);

- (void)scheduleAnimatedTransformation:(DZTileTransformationType)type afterSeconds:(CGFloat)time;
- (void)animateTransformation:(DZTileTransformationType)transformtaionType;
@end
