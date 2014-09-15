//
//  DZTileCollectionViewCell.m
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import "DZTileCollectionViewCell.h"

@implementation DZTileCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse {
    [self.frontContainerView.layer removeAllAnimations];
    [self.backContainerView.layer removeAllAnimations];
    self.frontContainerView.layer.transform = CATransform3DIdentity;
    self.backContainerView.layer.transform = CATransform3DIdentity;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
