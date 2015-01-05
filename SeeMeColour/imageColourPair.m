//
//  imageColourPair.m
//  SeeMeColour
//
//  Created by Ian on 28/02/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//
// Object to store the name of an image and the colour of that image.
#import "imageColourPair.h"

@implementation imageColourPair

- (id) init:(NSString *)imageName colour:(NSInteger)colour {
	self=[super init];
	if (self) {
		self.imageName=imageName;
		self.colour=colour;
	}
	return self;
}

@end
