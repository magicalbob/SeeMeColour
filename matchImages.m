//
//  matchImages.m
//  See Me Colour
//
//  Created by Ian on 28/02/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

#import "matchImages.h"

@implementation matchImages

@synthesize imageRect1;
@synthesize imageRect2;
@synthesize imageRect3;
@synthesize imageRect4;
@synthesize colorRect1;
@synthesize colorRect2;
@synthesize colorRect3;
@synthesize colorRect4;
@synthesize colorNum1;
@synthesize colorNum2;
@synthesize colorNum3;
@synthesize colorNum4;
@synthesize colorNum5;
@synthesize colorNum6;
@synthesize colorNum7;
@synthesize colorNum8;
@synthesize mainImage1;
@synthesize mainImage2;
@synthesize mainImage3;
@synthesize mainImage4;
@synthesize mainColor1;
@synthesize mainColor2;
@synthesize mainColor3;
@synthesize mainColor4;

- (id)init:(UIView *)containerView imageSet:(NSMutableArray *)imageSet
{
    self = [super init];
    if (self) {
        // Initialization code
		
		if ([imageSet count] < 4) {
			NSLog(@"Too few images provided in image set: %lu",(unsigned long)[imageSet count]);
			return NULL;
		}
		
		// Set each of the four images (blocks 1 to 4) and the four corresponding colours (blocks 5 to 8) to be "open"
		blockOpen1=TRUE;
		blockOpen2=TRUE;
		blockOpen3=TRUE;
		blockOpen4=TRUE;
		blockOpen5=TRUE;
		blockOpen6=TRUE;
		blockOpen7=TRUE;
		blockOpen8=TRUE;
		
		// Choose the four random images to display at top of the screen. For the second and subsequent images, need to
		// make sure that the same colour of image isn't repeated. removeSameColour achieves this. Red and orange are classed
		// as being the same colour for removal, due to their similarity.
		srand((unsigned int)time(NULL));
		int randImage1 = rand() % [imageSet count];
		
		imageColourPair *pairFor1 = [imageSet objectAtIndex:randImage1];
		
		NSMutableArray *remainingImages2;
		
		remainingImages2=[self removeSameColour:imageSet removeColour:[pairFor1 colour]];
		
		int randImage2 = rand() % [remainingImages2 count];
		
		imageColourPair *pairFor2 = [remainingImages2 objectAtIndex:randImage2];
		
		NSMutableArray *remainingImages3;

		remainingImages3=[self removeSameColour:remainingImages2 removeColour:[pairFor2 colour]];

		int randImage3 = rand() % [remainingImages3 count];
		
		imageColourPair *pairFor3 = [remainingImages3 objectAtIndex:randImage3];

		NSMutableArray *remainingImages4;
		
		remainingImages4=[self removeSameColour:remainingImages3 removeColour:[pairFor3 colour]];
		
		int randImage4 = rand() % [remainingImages4 count];
		
		imageColourPair *pairFor4 = [remainingImages4 objectAtIndex:randImage4];
		
		//NSLog(@"containerView width = %f",containerView.frame.size.width);
		//NSLog(@"containerView height = %f",containerView.frame.size.height);
		
		// Work out the size of the objects on the screen as a proportion of the view size.
		float halfWidth;
		float centreHeight1;
		float centreHeight2;
		
		if (containerView.frame.size.width>containerView.frame.size.height) {
			halfWidth=(containerView.frame.size.width/13);
			centreHeight1=(containerView.frame.size.height/4)-halfWidth;
			centreHeight2=2*(containerView.frame.size.height/4)+halfWidth;
		} else {
			halfWidth=(containerView.frame.size.height/13);
			centreHeight1=(containerView.frame.size.width/4)-halfWidth;
			centreHeight2=2*(containerView.frame.size.width/4)+halfWidth;
		}
		
		//NSLog(@"Rect1: (%f,%f,%f,%f)",halfWidth,
		//	  centreHeight1,
		//	  2*halfWidth,
		//	  2*halfWidth);
		
		//NSLog(@"Rect2: (%f,%f,%f,%f)",halfWidth*4,
		//	  centreHeight1,
		//	  2*halfWidth,
		//	  2*halfWidth);
		
		//NSLog(@"Rect3: (%f,%f,%f,%f)", halfWidth*7,
		//	  centreHeight1,
		//	  2*halfWidth,
		//	  2*halfWidth);
		
		//NSLog(@"Rect4: (%f,%f,%f,%f)", halfWidth*10,
		//	  centreHeight1,
		//	  2*halfWidth,
		//	  2*halfWidth);
		
		// Create the coloured blocks at the bottom of screen which correspond to the colours of the 4 random images.
		// randColNum1 is the picture that first colour tile refers to: 0 is pairFor1, 3 is pairFor4 etc
		NSInteger randColNum1 = rand() % 4;
		NSInteger randColNum2 = randColNum1;
		while (randColNum2 == randColNum1) {
			randColNum2 = rand() % 4;
		}
		NSInteger randColNum3 = randColNum1;
		while ((randColNum3 == randColNum1)||(randColNum3==randColNum2)) {
			randColNum3 = rand() % 4;
		}
		NSInteger randColNum4 = randColNum1;
		while ((randColNum4 == randColNum1)||(randColNum4==randColNum2)||(randColNum4==randColNum3)) {
			randColNum4 = rand() % 4;
		}
		
		// Store the colours of the 8 blocks, to enable easy testing during the drawing phase.
		self->colorNum1=[pairFor1 colour];
		self->colorNum2=[pairFor2 colour];
		self->colorNum3=[pairFor3 colour];
		self->colorNum4=[pairFor4 colour];
		switch (randColNum1) {
			case 0:
				self->colorNum5=[pairFor1 colour];
				break;
			case 1:
				self->colorNum5=[pairFor2 colour];
				break;
			case 2:
				self->colorNum5=[pairFor3 colour];
				break;
			case 3:
				self->colorNum5=[pairFor4 colour];
				break;
		}
		switch (randColNum2) {
			case 0:
				self->colorNum6=[pairFor1 colour];
				break;
			case 1:
				self->colorNum6=[pairFor2 colour];
				break;
			case 2:
				self->colorNum6=[pairFor3 colour];
				break;
			case 3:
				self->colorNum6=[pairFor4 colour];
				break;
		}
		switch (randColNum3) {
			case 0:
				self->colorNum7=[pairFor1 colour];
				break;
			case 1:
				self->colorNum7=[pairFor2 colour];
				break;
			case 2:
				self->colorNum7=[pairFor3 colour];
				break;
			case 3:
				self->colorNum7=[pairFor4 colour];
				break;
		}
		switch (randColNum4) {
			case 0:
				self->colorNum8=[pairFor1 colour];
				break;
			case 1:
				self->colorNum8=[pairFor2 colour];
				break;
			case 2:
				self->colorNum8=[pairFor3 colour];
				break;
			case 3:
				self->colorNum8=[pairFor4 colour];
				break;
		}
		
		//NSLog(@"Colour source for block 1 = %d",randColNum1);
		//NSLog(@"Colour source for block 2 = %d",randColNum2);
		//NSLog(@"Colour source for block 3 = %d",randColNum3);
		//NSLog(@"Colour source for block 4 = %d",randColNum4);
		
		// Set up rectangles for the four random pictures, and the corresponding colours below them
			  
		imageRect1 = CGRectMake(halfWidth,
								centreHeight1,
								2*halfWidth,
								2*halfWidth);
		
		imageRect2 = CGRectMake(halfWidth*4,
								centreHeight1,
								2*halfWidth,
								2*halfWidth);
		
		imageRect3 = CGRectMake(halfWidth*7,
								centreHeight1,
								2*halfWidth,
								2*halfWidth);
		
		imageRect4 = CGRectMake(halfWidth*10,
								centreHeight1,
								2*halfWidth,
								2*halfWidth);
		
		colorRect1 = CGRectMake(imageRect1.origin.x,
								centreHeight2,
								imageRect1.size.width,
								imageRect1.size.height);
		
		colorRect2 = CGRectMake(imageRect2.origin.x,
								centreHeight2,
								imageRect2.size.width,
								imageRect2.size.height);
		
		colorRect3 = CGRectMake(imageRect3.origin.x,
								centreHeight2,
								imageRect3.size.width,
								imageRect3.size.height);
		
		colorRect4 = CGRectMake(imageRect4.origin.x,
								centreHeight2,
								imageRect4.size.width,
								imageRect4.size.height);
		
		//NSLog(@"Image1: %@,%ld",[pairFor1 imageName],(long)[pairFor1 colour]);
		//NSLog(@"Image2: %@,%ld",[pairFor2 imageName],(long)[pairFor2 colour]);
		//NSLog(@"Image3: %@,%ld",[pairFor3 imageName],(long)[pairFor3 colour]);
		//NSLog(@"Image4: %@,%ld",[pairFor4 imageName],(long)[pairFor4 colour]);
		
		// Place the images on to the screen
		mainImage1=[[UIImageView alloc] initWithFrame:imageRect1];
		mainImage1.image=[UIImage imageWithContentsOfFile:[pairFor1 imageName]];
		[containerView addSubview:mainImage1];
		
		[containerView bringSubviewToFront:mainImage1];

		mainImage2=[[UIImageView alloc] initWithFrame:imageRect2];
		mainImage2.image=[UIImage imageWithContentsOfFile:[pairFor2 imageName]];
		[containerView addSubview:mainImage2];
		
		[containerView bringSubviewToFront:mainImage2];
		
		mainImage3=[[UIImageView alloc] initWithFrame:imageRect3];
		mainImage3.image=[UIImage imageWithContentsOfFile:[pairFor3 imageName]];
		[containerView addSubview:mainImage3];
		
		[containerView bringSubviewToFront:mainImage3];
		
		mainImage4=[[UIImageView alloc] initWithFrame:imageRect4];
		mainImage4.image=[UIImage imageWithContentsOfFile:[pairFor4 imageName]];
		[containerView addSubview:mainImage4];
		
		[containerView bringSubviewToFront:mainImage4];
		
		// Place the colour blocks on to the screen
		mainColor1=[[UIImageView alloc] initWithFrame:colorRect1];
		switch (randColNum1) {
			case 0:
				mainColor1.backgroundColor = [self whichColorToUse:[pairFor1 colour]];
				break;
			case 1:
				mainColor1.backgroundColor = [self whichColorToUse:[pairFor2 colour]];
				break;
			case 2:
				mainColor1.backgroundColor = [self whichColorToUse:[pairFor3 colour]];
				break;
			case 3:
				mainColor1.backgroundColor = [self whichColorToUse:[pairFor4 colour]];
				break;
			default:
				break;
		}
		[containerView addSubview:mainColor1];
		
		[containerView bringSubviewToFront:mainColor1];
		
		mainColor2=[[UIImageView alloc] initWithFrame:colorRect2];
		switch (randColNum2) {
			case 0:
				mainColor2.backgroundColor = [self whichColorToUse:[pairFor1 colour]];
				break;
			case 1:
				mainColor2.backgroundColor = [self whichColorToUse:[pairFor2 colour]];
				break;
			case 2:
				mainColor2.backgroundColor = [self whichColorToUse:[pairFor3 colour]];
				break;
			case 3:
				mainColor2.backgroundColor = [self whichColorToUse:[pairFor4 colour]];
				break;
			default:
				break;
		}
		[containerView addSubview:mainColor2];
		
		[containerView bringSubviewToFront:mainColor2];
		
		mainColor3=[[UIImageView alloc] initWithFrame:colorRect3];
		switch (randColNum3) {
			case 0:
				mainColor3.backgroundColor = [self whichColorToUse:[pairFor1 colour]];
				break;
			case 1:
				mainColor3.backgroundColor = [self whichColorToUse:[pairFor2 colour]];
				break;
			case 2:
				mainColor3.backgroundColor = [self whichColorToUse:[pairFor3 colour]];
				break;
			case 3:
				mainColor3.backgroundColor = [self whichColorToUse:[pairFor4 colour]];
				break;
			default:
				break;
		}
		[containerView addSubview:mainColor3];
		
		[containerView bringSubviewToFront:mainColor3];
		
		mainColor4=[[UIImageView alloc] initWithFrame:colorRect4];
		switch (randColNum4) {
			case 0:
				mainColor4.backgroundColor = [self whichColorToUse:[pairFor1 colour]];
				break;
			case 1:
				mainColor4.backgroundColor = [self whichColorToUse:[pairFor2 colour]];
				break;
			case 2:
				mainColor4.backgroundColor = [self whichColorToUse:[pairFor3 colour]];
				break;
			case 3:
				mainColor4.backgroundColor = [self whichColorToUse:[pairFor4 colour]];
				break;
			default:
				break;
		}
		[containerView addSubview:mainColor4];
		
		[containerView bringSubviewToFront:mainColor4];
		
	}
    return self;
}

- (BOOL) sameColour:(NSInteger)colour1 colour2:(NSInteger)colour2 {
	// Check to see if two blocks are the same colour. Class orange and red as the same, due to similarity of colours
	NSInteger tempCol1, tempCol2;
	tempCol1=colour1;
	if (tempCol1==COL_ORANGE) {
		tempCol1=COL_RED;
	}
	tempCol2=colour2;
	if (tempCol2==COL_ORANGE) {
		tempCol2=COL_RED;
	}
	
	return (tempCol1==tempCol2);
}

- (NSMutableArray *) removeSameColour:(NSMutableArray *)originalImages removeColour:(NSInteger)removeColour {
	NSMutableArray *remainingImages = [NSMutableArray arrayWithObjects:nil count:0];
	
	// Remove entries from list of images when they are the same colour as image chosen in previous round of setting
	
	//NSLog(@"Removing colour %d from set to pick 2nd image",[pairFor1 colour]);
	for (int wIdx=0; wIdx<[originalImages count]; wIdx++) {
		//NSLog(@"Dump imageSet[%d]: %@,%ld",wIdx,[[imageSet objectAtIndex:wIdx] imageName],(long)[[imageSet objectAtIndex:wIdx] colour]);
		if (![self sameColour:[[originalImages objectAtIndex:wIdx] colour] colour2:removeColour]) {
			//NSLog(@"Keeping");
			[remainingImages addObject:[originalImages objectAtIndex:wIdx]];
		}
	}
			  
	return remainingImages;
}

- (UIColor *) whichColorToUse:(NSInteger)colNum {
	// Translate local colour values into UIColor objects

	switch (colNum) {
		case COL_RED:
			return [UIColor redColor];
			break;
		case COL_YELLOW:
			return [UIColor yellowColor];
			break;
		case COL_GREEN:
			return [UIColor greenColor];
			break;
		case COL_BLUE:
			return [UIColor blueColor];
			break;
		case COL_ORANGE:
			return [UIColor orangeColor];
			break;
		case COL_BROWN:
			return [UIColor brownColor];
			break;
	}
	
	return 0;
}

- (CGPoint) latchPoint:(NSInteger)blockNo {
	// Method to return the latch point of a block, from where the line being drawn will start or end.
	
	CGPoint retPoint;
	
	switch (blockNo) {
		case 1:
			retPoint.x=imageRect1.origin.x+(imageRect1.size.width/2);
			retPoint.y=imageRect1.origin.y+imageRect1.size.height-20;
			break;
		case 2:
			retPoint.x=imageRect2.origin.x+(imageRect2.size.width/2);
			retPoint.y=imageRect2.origin.y+imageRect2.size.height-20;
			break;
		case 3:
			retPoint.x=imageRect3.origin.x+(imageRect3.size.width/2);
			retPoint.y=imageRect3.origin.y+imageRect3.size.height-20;
			break;
		case 4:
			retPoint.x=imageRect4.origin.x+(imageRect4.size.width/2);
			retPoint.y=imageRect4.origin.y+imageRect4.size.height-20;
			break;
		case 5:
			retPoint.x=colorRect1.origin.x+(colorRect1.size.width/2);
			retPoint.y=colorRect1.origin.y+20;
			break;
		case 6:
			retPoint.x=colorRect2.origin.x+(colorRect2.size.width/2);
			retPoint.y=colorRect2.origin.y+20;
			break;
		case 7:
			retPoint.x=colorRect3.origin.x+(colorRect3.size.width/2);
			retPoint.y=colorRect3.origin.y+20;
			break;
		case 8:
			retPoint.x=colorRect4.origin.x+(colorRect4.size.width/2);
			retPoint.y=colorRect4.origin.y+20;
			break;
		default:
			retPoint.x=-1;
			retPoint.y=-1;
	}
	return retPoint;
}

- (BOOL) matchedBlocks:(NSInteger)block1 block2:(NSInteger)block2 {
	// Check whether two blocks at the end of a line are the same colour or not
	
	NSInteger tempBlock1, tempBlock2;
	if ((block1>=1)&&(block1<=4)&&(block2>=5)&&(block2<=8)) {
		tempBlock1=block1;
		tempBlock2=block2;
	} else {
		if ((block2>=1)&&(block2<=4)&&(block1>=5)&&(block1<=8)) {
			tempBlock1=block2;
			tempBlock2=block1;
		} else {
			return FALSE;
		}
	}
	
	NSInteger colorBlock1, colorBlock2;
	
	switch (tempBlock1) {
		case 1:
			colorBlock1=self->colorNum1;
			break;
		case 2:
			colorBlock1=self->colorNum2;
			break;
		case 3:
			colorBlock1=self->colorNum3;
			break;
		case 4:
			colorBlock1=self->colorNum4;
			break;
	}
	
	switch (tempBlock2) {
		case 5:
			colorBlock2=self->colorNum5;
			break;
		case 6:
			colorBlock2=self->colorNum6;
			break;
		case 7:
			colorBlock2=self->colorNum7;
			break;
		case 8:
			colorBlock2=self->colorNum8;
			break;
	}
	
	return (colorBlock1==colorBlock2);
}

- (BOOL) isBlockOpen:(NSInteger)blockNum {
	// Check whether a block has been completed or not
	
	switch (blockNum) {
		case 1:
			return blockOpen1;
		case 2:
			return blockOpen2;
		case 3:
			return blockOpen3;
		case 4:
			return blockOpen4;
		case 5:
			return blockOpen5;
		case 6:
			return blockOpen6;
		case 7:
			return blockOpen7;
		case 8:
			return blockOpen8;
	}
	
	NSLog(@"Unknown block number %ld tested for Open",(long)blockNum);
	return FALSE;
}

- (void) setBlockClosed:(NSInteger)blockNum {
	// Set a block as having been completed
	
	switch (blockNum) {
		case 1:
			blockOpen1=FALSE;
			break;
		case 2:
			blockOpen2=FALSE;
			break;
		case 3:
			blockOpen3=FALSE;
			break;
		case 4:
			blockOpen4=FALSE;
			break;
		case 5:
			blockOpen5=FALSE;
			break;
		case 6:
			blockOpen6=FALSE;
			break;
		case 7:
			blockOpen7=FALSE;
			break;
		case 8:
			blockOpen8=FALSE;
			break;
		default:
			NSLog(@"Unknown block number %ld asked to be Closed",(long)blockNum);
			break;
	}
}

-(NSInteger)inBlockN:(CGPoint)whereTouch {
	// Check whether a touch was within one of the 8 blocks
	if ((whereTouch.x>=self.imageRect1.origin.x)&&
		(whereTouch.x<=self.imageRect1.origin.x+self.imageRect1.size.width)&&
	    (whereTouch.y>=self.imageRect1.origin.y)&&
	    (whereTouch.y<=self.imageRect1.origin.y+self.imageRect1.size.height)) {
		return 1;
	}
	
	if ((whereTouch.x>=self.imageRect2.origin.x)&&
		(whereTouch.x<=self.imageRect2.origin.x+self.imageRect2.size.width)&&
	    (whereTouch.y>=self.imageRect2.origin.y)&&
	    (whereTouch.y<=self.imageRect2.origin.y+self.imageRect2.size.height)) {
		return 2;
	}
	
	if ((whereTouch.x>=self.imageRect3.origin.x)&&
		(whereTouch.x<=self.imageRect3.origin.x+self.imageRect3.size.width)&&
	    (whereTouch.y>=self.imageRect3.origin.y)&&
	    (whereTouch.y<=self.imageRect3.origin.y+self.imageRect3.size.height)) {
		return 3;
	}
	
	if ((whereTouch.x>=self.imageRect4.origin.x)&&
		(whereTouch.x<=self.imageRect4.origin.x+self.imageRect4.size.width)&&
	    (whereTouch.y>=self.imageRect4.origin.y)&&
	    (whereTouch.y<=self.imageRect4.origin.y+self.imageRect4.size.height)) {
		return 4;
	}
	
	if ((whereTouch.x>=self.colorRect1.origin.x)&&
		(whereTouch.x<=self.colorRect1.origin.x+self.colorRect1.size.width)&&
	    (whereTouch.y>=self.colorRect1.origin.y)&&
	    (whereTouch.y<=self.colorRect1.origin.y+self.colorRect1.size.height)) {
		return 5;
	}
	
	if ((whereTouch.x>=self.colorRect2.origin.x)&&
		(whereTouch.x<=self.colorRect2.origin.x+self.colorRect2.size.width)&&
	    (whereTouch.y>=self.colorRect2.origin.y)&&
	    (whereTouch.y<=self.colorRect2.origin.y+self.colorRect2.size.height)) {
		return 6;
	}
	
	if ((whereTouch.x>=self.colorRect3.origin.x)&&
		(whereTouch.x<=self.colorRect3.origin.x+self.colorRect3.size.width)&&
	    (whereTouch.y>=self.colorRect3.origin.y)&&
	    (whereTouch.y<=self.colorRect3.origin.y+self.colorRect3.size.height)) {
		return 7;
	}
	
	if ((whereTouch.x>=self.colorRect4.origin.x)&&
		(whereTouch.x<=self.colorRect4.origin.x+self.colorRect4.size.width)&&
	    (whereTouch.y>=self.colorRect4.origin.y)&&
	    (whereTouch.y<=self.colorRect4.origin.y+self.colorRect4.size.height)) {
		return 8;
	}
	
	return -1;
}

@end
