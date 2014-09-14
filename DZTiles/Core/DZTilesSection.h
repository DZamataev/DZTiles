//
//  DZTilesSection.h
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DZTile;

@interface DZTilesSection : NSObject
@property (nonatomic, strong) NSMutableArray *tiles; // array of DZTile objects
@property (nonatomic, strong) NSString *title; // array of DZTile objects
@property (nonatomic, strong) id userData;
@end
