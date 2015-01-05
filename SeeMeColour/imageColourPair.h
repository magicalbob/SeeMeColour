//
//  imageColourPair.h
//  SeeMeColour
//
//  Created by Ian on 28/02/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define COL_RED 1
#define COL_YELLOW 2
#define COL_GREEN 3
#define COL_BLUE 4
#define COL_ORANGE 5
#define COL_BROWN 6

@interface imageColourPair : NSObject
- (id) init:(NSString *)imageName colour:(NSInteger)colour;
@property NSString *imageName;
@property NSInteger colour;
@end
