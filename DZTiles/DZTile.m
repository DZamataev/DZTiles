//
//  DZTile.m
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import "DZTile.h"
#import "DZTileCollectionViewCell.h"

@implementation DZTile
- (instancetype)init {
    self = [super init];
    if (self) {
        self.insets = UIEdgeInsetsZero;
        self.blockSizeMultiplier = CGSizeMake(1, 1);
        
        [self setOnViewUpdate:^(DZTile *tile, UICollectionViewCell *cell) {
            if ([cell isKindOfClass:[DZTileCollectionViewCell class]]) {
                DZTileCollectionViewCell *tileCell = (DZTileCollectionViewCell*)cell;
                tileCell.frontTitleLabel.text = tileCell.backTitleLabel.text = tile.title;
                tileCell.frontContainerView.backgroundColor = tileCell.backContainerView.backgroundColor = tile.color;
                tileCell.frontImageView.image = tileCell.backImageView.image = tile.image;
            }
        }];
    }
    return self;
}
@end
