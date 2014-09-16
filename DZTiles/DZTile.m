//
//  DZTile.m
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import "DZTile.h"
#import "DZTileCollectionViewCell.h"
#import "DZTileTransformationHelper.h"

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
                if (!tile.isFacingBackwards) {
                    tileCell.frontContainerView.hidden = NO;
                    tileCell.backContainerView.hidden = YES;
                }
                else {
                    tileCell.frontContainerView.hidden = YES;
                    tileCell.backContainerView.hidden = NO;
                }
            }
        }];
    }
    return self;
}

- (void)scheduleAnimatedTransformation:(DZTileTransformationType)type afterSeconds:(CGFloat)time {
    self.rotationTimer = [NSTimer scheduledTimerWithTimeInterval:time
                                                          target:self
                                                        selector:@selector(fireAnimatedTransformation:)
                                                        userInfo:[NSNumber numberWithInteger:type]
                                                         repeats:NO];
}

- (void)fireAnimatedTransformation:(NSTimer*)timer {
    NSNumber *typeNumber = timer.userInfo;
    DZTileTransformationType type = typeNumber.integerValue;
    [self.rotationTimer invalidate];
    self.rotationTimer = nil;
    [self animateTransformation:type];
}

- (void)animateTransformation:(DZTileTransformationType)transformtaionType {
    UICollectionViewCell *cell = self.displayedCell;
    BOOL isDisplayed = (cell != nil) ? YES : NO;
    
    // we don't need to perform transformation for non displayed tile by default
    // but callback may change this decision
    NSNumber *shouldPerformTransformation = @(isDisplayed);
    
    if (self.onTransformation) {
        self.onTransformation(self, isDisplayed, self.displayedCell, transformtaionType, &shouldPerformTransformation);
    }
    
    if (shouldPerformTransformation.boolValue == YES) {
            // we should perform transformation after all, let's do this
        
            BOOL oppositeFacing = !self.isFacingBackwards;
            
            if (isDisplayed) {
                // if tile is displayed we fire the transformation
                if ([cell isKindOfClass:[DZTileCollectionViewCell class]]) {
                    DZTileCollectionViewCell *tileCell = (DZTileCollectionViewCell*)cell;
                    
                    UIView *frontView = self.isFacingBackwards ? tileCell.backContainerView : tileCell.frontContainerView;
                    UIView *backView = self.isFacingBackwards ? tileCell.frontContainerView : tileCell.backContainerView;
                    
                    DZTile __weak *weakSelf = self;
                    [DZTileTransformationHelper animateTransformationWithFront:frontView back:backView transformationType:transformtaionType completion:^(BOOL finished) {
                        if (finished) {
                            if (weakSelf) {
                                weakSelf.isFacingBackwards = oppositeFacing;
                            }
                        }
                    }];
                }
            }
            else {
                // if tile is not displayed we just mark tile as already facing opposite side
                self.isFacingBackwards = oppositeFacing;
            }
            
        }
    
}
@end
