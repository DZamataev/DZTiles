//
//  DZTilesSection.m
//  DZTiles
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import "DZTilesSection.h"
#import "DZTile.h"

@implementation DZTilesSection {
    NSMutableArray *_tiles;
}


- (void)setTiles:(NSMutableArray *)tiles {
    _tiles = tiles;
}

- (NSMutableArray*)tiles {
    if (!_tiles) {
        _tiles = [NSMutableArray new];
    }
    return _tiles;
}
@end
