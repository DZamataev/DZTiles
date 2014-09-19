//
//  DZTilesViewController.h
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFQuiltLayout.h"
#import "LSCollectionViewHelper.h"
#import "UICollectionView+Draggable.h"
#import "DZTiles_Constants.h"

@class DZTilesSection;
@class DZTile;
@class DZTileCollectionViewCell;
@class DZTileTransformationHelper;
@class DZTilesViewController;

@protocol DZTilesViewControllerMoveDelegate <NSObject>

@optional

- (BOOL)tilesViewController:(DZTilesViewController*)tilesVC
             collectionView:(LSCollectionViewHelper *)collectionView
     canMoveItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)tilesViewController:(DZTilesViewController*)tilesVC
             collectionView:(LSCollectionViewHelper*)collectionView
     didMoveItemAtIndexPath:(NSIndexPath *)fromIndexPath
                toIndexPath:(NSIndexPath *)toIndexPath;

@end

@interface DZTilesViewController : UICollectionViewController <RFQuiltLayoutDelegate, UICollectionViewDataSource_Draggable>
@property (nonatomic, strong) NSMutableArray *sections; // array of DZTilesSection objects
@property (nonatomic, assign) IBOutlet RFQuiltLayout *layout;
@property (nonatomic, assign) id <DZTilesViewControllerMoveDelegate> moveDelegate;
@property (nonatomic, assign) BOOL isMoveTilesEnabled;
- (DZTilesSection*)sectionAtIndex:(NSInteger)sectionIndex;
- (DZTile*)tileAtIndexPath:(NSIndexPath*)indexPath;
- (void)insertTilesSections:(NSMutableArray*)newSections animated:(BOOL)animated;
@end
