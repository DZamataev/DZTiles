//
//  DZTile.h
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DZTileCollectionViewCell;

@interface DZTile : NSObject
@property (nonatomic, strong) NSString *cellReusableIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGSize blockSizeMultiplier;

@property (nonatomic, strong) id userData;

@property (nonatomic, copy) void (^onViewUpdate)(DZTile *tile, UICollectionViewCell *cell);

@property (nonatomic, strong) NSTimer *rotationTimer;

@property (nonatomic, copy) void (^onRotation)(DZTile *tile, bool isDisplayed, UICollectionViewCell *cell);
@end
