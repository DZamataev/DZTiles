//
//  DZTileCollectionViewCell.h
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZTileCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIView *frontContainerView;
@property (nonatomic, strong) IBOutlet UILabel *frontTitleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *frontImageView;

@property (nonatomic, strong) IBOutlet UIView *backContainerView;
@property (nonatomic, strong) IBOutlet UILabel *backTitleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *backImageView;
@end
