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

@class DZTilesSection;
@class DZTile;
@class DZTileCollectionViewCell;
@class DZTileTransformationHelper;

@interface DZTilesViewController : UICollectionViewController <RFQuiltLayoutDelegate, UICollectionViewDataSource_Draggable>
@property (nonatomic, strong) NSMutableArray *sections; // array of DZTilesSection objects
@property (nonatomic, assign) IBOutlet RFQuiltLayout *layout;
- (void)insertTilesSections:(NSMutableArray*)newSections animated:(BOOL)animated;
- (void)scheduleRotationForTile:(DZTile*)tileToRotate afterSeconds:(CGFloat)time;
@end
