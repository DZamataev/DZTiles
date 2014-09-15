//
//  DZTilesViewController.m
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import "DZTilesViewController.h"
#import "DZTilesSection.h"
#import "DZTile.h"
#import "DZTileTransformationHelper.h"
#import "DZTileCollectionViewCell.h"

@interface DZTilesViewController ()
@property NSMutableArray *displayedTiles;
@property NSMutableArray *displayedCells;
@end

@implementation DZTilesViewController

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
    self.collectionView.draggable = YES;
    self.displayedCells = [NSMutableArray new];
    self.displayedTiles = [NSMutableArray new];
//    [self performSelector:@selector(log) withObject:nil afterDelay:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)log {
    NSLog(@"displayed cells: %ui", self.displayedCells.count);
    [self performSelector:@selector(log) withObject:nil afterDelay:1.0f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (void)scheduleRotationForTile:(DZTile*)tileToRotate afterSeconds:(CGFloat)time {
    assert(tileToRotate);
    tileToRotate.rotationTimer = [NSTimer scheduledTimerWithTimeInterval:time
                                                                  target:self
                                                                selector:@selector(fireRotationInTile:)
                                                                userInfo:tileToRotate
                                                                 repeats:NO];
}

- (void)fireRotationInTile:(NSTimer*)timer {
    if ([timer.userInfo isKindOfClass:[DZTile class]]) {
        DZTile *tile = timer.userInfo;
        
        [tile.rotationTimer invalidate];
        tile.rotationTimer = nil;
        
        BOOL isDisplayed = NO;
        UICollectionViewCell *cell = nil;
        NSInteger tileIndex = [self.displayedTiles indexOfObject:tile];
        if (tileIndex != NSNotFound) {
            isDisplayed = YES;
            cell = [self.displayedCells objectAtIndex:tileIndex];
        }
        
        NSNumber *shouldPerformRotationAnimation = @(YES);
        if (tile.onRotation) {
            tile.onRotation(tile, isDisplayed, cell, &shouldPerformRotationAnimation);
        }
        
        if (shouldPerformRotationAnimation.boolValue == YES) {
            if ([cell isKindOfClass:[DZTileCollectionViewCell class]]) {
                DZTileCollectionViewCell *tileCell = (DZTileCollectionViewCell*)cell;
                
                BOOL oppositeFacing = !tile.isFacingBackwards;
                
                UIView *frontView = tile.isFacingBackwards ? tileCell.backContainerView : tileCell.frontContainerView;
                UIView *backView = tile.isFacingBackwards ? tileCell.frontContainerView : tileCell.backContainerView;
                
                [DZTileTransformationHelper animateRotationWithFront:frontView back:backView completion:^(BOOL finished) {
                    if (finished) {
                        tile.isFacingBackwards = oppositeFacing;
                    }
                }];
            }
        }
    }
}
#pragma mark - Helpers

- (DZTilesSection*)sectionAtIndex:(NSInteger)sectionIndex {
    return (DZTilesSection*)self.sections[sectionIndex];
}

- (DZTile*)tileAtIndexPath:(NSIndexPath*)indexPath {
    DZTilesSection *section = [self sectionAtIndex:indexPath.section];
    DZTile *tile = section.tiles[indexPath.row];
    return tile;
}

- (void)insertTilesSections:(NSMutableArray *)newSections animated:(BOOL)animated {
    self.sections = newSections;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self sectionAtIndex:section].tiles.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DZTile *tile = [self tileAtIndexPath:indexPath];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tile.cellReusableIdentifier forIndexPath:indexPath];
    
    [self.displayedCells addObject:cell];
    [self.displayedTiles addObject:tile];
    
    tile.onViewUpdate(tile, cell);
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

//// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//}

#pragma mark - UICollectionViewDelegate
// Methods for notification of selection/deselection and highlight/unhighlight events.
// The sequence of calls leading to selection from a user touch is:
//
// (when the touch begins)
// 1. -collectionView:shouldHighlightItemAtIndexPath:
// 2. -collectionView:didHighlightItemAtIndexPath:
//
// (when the touch lifts)
// 3. -collectionView:shouldSelectItemAtIndexPath: or -collectionView:shouldDeselectItemAtIndexPath:
// 4. -collectionView:didSelectItemAtIndexPath: or -collectionView:didDeselectItemAtIndexPath:
// 5. -collectionView:didUnhighlightItemAtIndexPath:
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // called when the user taps on an already-selected item in multi-select mode
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.displayedCells removeObject:cell];
    [self.displayedTiles removeObject:[self tileAtIndexPath:indexPath]];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
}

// These methods provide support for copy/paste actions on cells.
// All three should be implemented if any are.
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//    
//}
//
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//    
//}

// support for custom transition layout
//- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout {
//    
//}

#pragma mark - UICollectionView_Draggable
//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//    
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath {
//    
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath {
//    
//}

#pragma mark -
- (BOOL)collectionView:(LSCollectionViewHelper *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(LSCollectionViewHelper *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    DZTile *tile = [self tileAtIndexPath:fromIndexPath];
    DZTilesSection *fromSection = self.sections[fromIndexPath.section];
    [fromSection.tiles removeObjectAtIndex:fromIndexPath.row];
    DZTilesSection *toSection = self.sections[toIndexPath.section];
    [toSection.tiles insertObject:tile atIndex:toIndexPath.row];
}


#pragma mark - RFQuiltLayoutDelegate

- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // defaults to 1x1
    DZTile *tile = [self tileAtIndexPath:indexPath];
    return tile.blockSizeMultiplier;
}

- (UIEdgeInsets) insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    // defaults to uiedgeinsetszero
    DZTile *tile = [self tileAtIndexPath:indexPath];
    return tile.insets;
}
@end
