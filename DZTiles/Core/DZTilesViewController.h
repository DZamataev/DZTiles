//
//  DZTilesViewController.h
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFQuiltLayout.h"

@class DZTilesSection;
@class DZTile;

@interface DZTilesViewController : UICollectionViewController <RFQuiltLayoutDelegate>
@property (nonatomic, strong) NSMutableArray *sections; // array of DZTilesSection objects
@property (nonatomic, assign) IBOutlet RFQuiltLayout *layout;
- (void)insertTilesSections:(NSMutableArray*)newSections animated:(BOOL)animated;
@end
