//
//  ViewController.m
//  See Me Colour
//
//  Created by Ian on 28/02/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    AVAudioPlayer *playerSuccess01;
	AVAudioPlayer *playerSuccess02;
	AVAudioPlayer *playerSuccess03;
	AVAudioPlayer *playerSuccess04;
	AVAudioPlayer *playerLoop1;
	AVAudioPlayer *playerLoop2;
	AVAudioPlayer *playerLoop3;
	AVAudioPlayer *playerLoop4;
	AVAudioPlayer *playerFinal;
}
@end

@implementation ViewController

@synthesize mainView;
@synthesize tempDrawImage;
@synthesize mainImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Create the array of all the images to be used, and what colour they are.
	imageDetails = [NSMutableArray arrayWithObjects:nil count:0];
	
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image01" ofType:@"jpg"] colour:COL_YELLOW]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image14" ofType:@"jpg"] colour:COL_YELLOW]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image15" ofType:@"jpg"] colour:COL_YELLOW]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image02" ofType:@"jpg"] colour:COL_BROWN]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image12" ofType:@"jpg"] colour:COL_BROWN]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image13" ofType:@"jpg"] colour:COL_BROWN]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image03" ofType:@"jpg"] colour:COL_RED]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image05" ofType:@"jpg"] colour:COL_RED]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image16" ofType:@"jpg"] colour:COL_RED]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image04" ofType:@"jpg"] colour:COL_GREEN]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image11" ofType:@"jpg"] colour:COL_GREEN]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image17" ofType:@"jpg"] colour:COL_GREEN]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image06" ofType:@"jpg"] colour:COL_ORANGE]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image07" ofType:@"jpg"] colour:COL_ORANGE]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image08" ofType:@"jpg"] colour:COL_ORANGE]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image09" ofType:@"jpg"] colour:COL_BLUE]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image10" ofType:@"jpg"] colour:COL_BLUE]];
	[imageDetails addObject:[[imageColourPair alloc] init:[[NSBundle mainBundle] pathForResource:@"image18" ofType:@"jpg"] colour:COL_BLUE]];
	
	// Set the path up for the players that are  going to play the congratulations tunes
    NSString *pathSuccess;
    pathSuccess = [[NSBundle mainBundle] pathForResource:@"success01" ofType:@"mp3"];
    playerSuccess01 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathSuccess] error:nil];
    pathSuccess = [[NSBundle mainBundle] pathForResource:@"success02" ofType:@"mp3"];
    playerSuccess02 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathSuccess] error:nil];
    pathSuccess = [[NSBundle mainBundle] pathForResource:@"success03" ofType:@"mp3"];
    playerSuccess03 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathSuccess] error:nil];
    pathSuccess = [[NSBundle mainBundle] pathForResource:@"success04" ofType:@"mp3"];
    playerSuccess04 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathSuccess] error:nil];
	
	// Set the path for each of the players that play sounds when user is touching screen to join an image to its colour.
    NSString *pathLoop1;
    pathLoop1 = [[NSBundle mainBundle] pathForResource:@"Loop1" ofType:@"mp3"];
    playerLoop1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathLoop1] error:nil];
	
    NSString *pathLoop2;
	pathLoop2 = [[NSBundle mainBundle] pathForResource:@"Loop2" ofType:@"mp3"];
    playerLoop2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathLoop2] error:nil];
	
    NSString *pathLoop3;
	pathLoop3 = [[NSBundle mainBundle] pathForResource:@"Loop3" ofType:@"mp3"];
    playerLoop3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathLoop3] error:nil];
	
    NSString *pathLoop4;
	pathLoop4 = [[NSBundle mainBundle] pathForResource:@"Loop4" ofType:@"mp3"];
    playerLoop4 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathLoop4] error:nil];
	
	NSString *pathFinal;
	pathFinal = [[NSBundle mainBundle] pathForResource:@"finalApplause" ofType:@"mp3"];
	playerFinal = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathFinal] error:nil];
	
	// Create the first set of images & colour blocks
	
	theBlocks=[[matchImages alloc] init:mainView imageSet:imageDetails];

	// Initialise state variables
	// Property currentTouch set to -1, repesenting "no current touch".
	// Property lastPoint.x set to -1, representing "no last point (because there's no current touch).
	currentTouch=-1;
	currentBlock=-1;
	lastPoint.x=-1;
	isDrawing=NO;
	isComplete=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)joinBlocks:(CGSize)whichFrame fromDot:(CGPoint)fromDot toDot:(CGPoint)toDot lineWidth:(float)lineWidth{
	// Draw a line, of the same colour as image and/or colour block, between an image/colour block and a point or latch point
	
	NSInteger inWhichBlock;
	
	// At least one end of the line will be attached to a block (image or colour)
	inWhichBlock = [theBlocks inBlockN:fromDot];
	if (inWhichBlock == -1) {
		inWhichBlock = [theBlocks inBlockN:toDot];
	}
	
	if (inWhichBlock == -1) {
		NSLog(@"Joining two blocks, but neither end point is in a block!");
		return;
	}

	UIGraphicsBeginImageContext(whichFrame);
	
	// Set the colour of the line to be the colour of the block at one end.
	switch (inWhichBlock) {
		case 1:
			//NSLog(@"Colour for line is %d",theBlocks.colorNum1);
			[[theBlocks whichColorToUse:theBlocks.colorNum1] set];
			break;
		case 2:
			//NSLog(@"Colour for line is %d",theBlocks.colorNum2);
			[[theBlocks whichColorToUse:theBlocks.colorNum2] set];
			break;
		case 3:
			//NSLog(@"Colour for line is %d",theBlocks.colorNum3);
			[[theBlocks whichColorToUse:theBlocks.colorNum3] set];
			break;
		case 4:
			//NSLog(@"Colour for line is %d",theBlocks.colorNum4);
			[[theBlocks whichColorToUse:theBlocks.colorNum4] set];
			break;
		case 5:
			//NSLog(@"Colour for line is %d",theBlocks.colorNum5);
			[[theBlocks whichColorToUse:theBlocks.colorNum5] set];
			break;
		case 6:
			//NSLog(@"Colour for line is %d",theBlocks.colorNum6);
			[[theBlocks whichColorToUse:theBlocks.colorNum6] set];
			break;
		case 7:
			//NSLog(@"Colour for line is %d",theBlocks.colorNum7);
			[[theBlocks whichColorToUse:theBlocks.colorNum7] set];
			break;
		case 8:
			//NSLog(@"Colour for line is %d",theBlocks.colorNum8);
			[[theBlocks whichColorToUse:theBlocks.colorNum8] set];
			break;
		default:
			NSLog(@"Don't know which block the colour is being set for!");
			break;
	}
	
	// Draw the line in to the temporary drawing area
	CGContextRef currentContext =UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(currentContext,lineWidth);
	CGContextMoveToPoint(currentContext,fromDot.x, fromDot.y);
	CGContextAddLineToPoint(currentContext,toDot.x, toDot.y);
	CGContextStrokePath(currentContext);
	CGContextFlush(currentContext);
	self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	// Process the start of a touch
	// Ignore the touch if a success tune for connecting two blocks is currently playing
	if (!([playerSuccess01 isPlaying]||
		  [playerSuccess02 isPlaying]||
		  [playerSuccess03 isPlaying]||
		  [playerSuccess04 isPlaying])) {
		// If currentTouch is -1 then this is a new line, otherwise want to resume drawing of previous line
		if (currentTouch==-1) {
			// Ignore the touch if already drawing - means it's a second touch when the first one hasn't finished.
			if (isDrawing==NO) {
				// This is a multi touch app, so need to go through each of the touches that might have just happened.
				// Ignore any that aren't inside one of the 8 blocks
				for (UITouch *touch in touches) {
					CGPoint tempPoint = [touch locationInView:self.view];
					NSInteger blockHit=[theBlocks inBlockN:tempPoint];
					
					// Ignore the touch if the block has already been closed off
					if ([theBlocks isBlockOpen:blockHit]) {
						if (isDrawing==NO) {
							if (lastPoint.x>-1) {
								currentTouch=[touch hash];
								isDrawing=YES;
								CGPoint currentPoint = [touch locationInView:self.view];
								[self joinBlocks:self.tempDrawImage.frame.size
									     fromDot:lastPoint
										   toDot:currentPoint
									   lineWidth:20];
								[self startNewLoop];
								[self playLoop];
								//						NSLog(@"Playing new loop");
							} else {
								if (blockHit>-1) {
									currentTouch=[touch hash];
									isDrawing=YES;
									lastPoint = [theBlocks  latchPoint:blockHit];
									[theBlocks setBlockClosed:blockHit];
									currentBlock=blockHit;
									[self startNewLoop];
									[self playLoop];
									//							NSLog(@"Playing new loop");
								}
							}
						}
					}
				}
			}
		} else {
			for (UITouch *touch in touches) {
				CGPoint tempPoint = [touch locationInView:self.view];
				NSInteger blockHit=[theBlocks inBlockN:tempPoint];
			
				if ([theBlocks isBlockOpen:blockHit]) {
					if (lastPoint.x>-1) {
						currentTouch=[touch hash];
						isDrawing=YES;
						CGPoint currentPoint = [touch locationInView:self.view];
						[self joinBlocks:self.tempDrawImage.frame.size
								 fromDot:lastPoint
								   toDot:currentPoint
							   lineWidth:20];
						//						NSLog(@"Playing new loop");
					} else {
						if (blockHit>-1) {
							currentTouch=[touch hash];
							isDrawing=YES;
							lastPoint = [theBlocks  latchPoint:blockHit];
							[theBlocks setBlockClosed:blockHit];
							currentBlock=blockHit;
							//							NSLog(@"Playing new loop");
						}
					}
				} else {
					currentTouch=[touch hash];
					isDrawing=YES;
					CGPoint currentPoint = [touch locationInView:self.view];
					[self joinBlocks:self.tempDrawImage.frame.size
							 fromDot:lastPoint
							   toDot:currentPoint
						   lineWidth:20];
				}
				[self startNewLoop];
				[self playLoop];
			}
		}
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (isDrawing==YES) {
		for (UITouch *touch in touches) {
			if (currentTouch==[touch hash]) {
				CGPoint currentPoint = [touch locationInView:self.view];
				NSInteger blockHit=[theBlocks inBlockN:currentPoint];
				if (((currentBlock>=1)&&(currentBlock<=4)&&(blockHit>=5)&&(blockHit<=8))||
					((blockHit>=1)&&(blockHit<=4)&&(currentBlock>=5)&&(currentBlock<=8))) {
					CGPoint tempPoint=[theBlocks  latchPoint:blockHit];
					if (!((tempPoint.x==lastPoint.x)&&(tempPoint.y==lastPoint.y))) {
						if ([theBlocks matchedBlocks:blockHit block2:currentBlock]) {
							currentPoint=tempPoint;
							isDrawing=NO;
							[theBlocks setBlockClosed:currentBlock];
							[theBlocks setBlockClosed:blockHit];
							[self stopLoops];
							[self playSuccessTune];
						}
					};
				}
				
				[self joinBlocks:self.tempDrawImage.frame.size
						 fromDot:lastPoint
						   toDot:currentPoint
					   lineWidth:20];
				
				if (isDrawing==NO) {
					UIGraphicsBeginImageContext(self.mainImage.frame.size);
					[self.tempDrawImage.layer renderInContext:UIGraphicsGetCurrentContext()];
					[self.mainImage.layer renderInContext:UIGraphicsGetCurrentContext()];
					self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
					self.tempDrawImage.image = nil;
					UIGraphicsEndImageContext();
					
					currentTouch=-1;
					currentBlock=-1;
					lastPoint.x=-1;
				}
			}
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self stopLoops];
	
	if (isDrawing==YES) {
		for (UITouch *touch in touches) {
			if (currentTouch == [touch hash]) {
				CGPoint currentPoint = [touch locationInView:self.view];
				
				isDrawing=NO;
				NSInteger blockHit=[theBlocks inBlockN:currentPoint];
				if (((currentBlock>=1)&&(currentBlock<=4)&&(blockHit>=5)&&(blockHit<=8))||
					((blockHit>=1)&&(blockHit<=4)&&(currentBlock>=5)&&(currentBlock<=8))) {
					CGPoint tempPoint=[theBlocks  latchPoint:blockHit];
					if (!((tempPoint.x==lastPoint.x)&&(tempPoint.y==lastPoint.y))) {
						if ([theBlocks matchedBlocks:blockHit block2:currentBlock]) {
							currentPoint=tempPoint;
							isDrawing=YES;
							[theBlocks setBlockClosed:currentBlock];
							[theBlocks setBlockClosed:blockHit];
							[self stopLoops];
							[self playSuccessTune];
						}
					};
				}
				
				[self joinBlocks:self.tempDrawImage.frame.size
						 fromDot:lastPoint
						   toDot:currentPoint
					   lineWidth:20];
				
				if (isDrawing==YES) {
					UIGraphicsBeginImageContext(self.mainImage.frame.size);
					[self.tempDrawImage.layer renderInContext:UIGraphicsGetCurrentContext()];
					[self.mainImage.layer renderInContext:UIGraphicsGetCurrentContext()];
					self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
					self.tempDrawImage.image = nil;
					UIGraphicsEndImageContext();
					
					currentTouch=-1;
					currentBlock=-1;
					lastPoint.x=-1;
					isDrawing=NO;
				}

			}
		}
	}
}

-(void)startNewLoop {
	currentLoop=rand() % 4 + 1;
	//	NSLog(@"New Loop is: %ld",(long)currentLoop);
}

-(void)playLoop {
	NSError *error;
	switch (currentLoop) {
		case 1:
			[playerLoop1 setDelegate:self];
			[playerLoop1 play];
			if (error) {
				NSLog(@"playLoop, loop1: %@",[error localizedDescription]);
			}
			break;
		case 2:
			[playerLoop2 setDelegate:self];
			[playerLoop2 play];
			if (error) {
				NSLog(@"playLoop, loop2: %@",[error localizedDescription]);
			}
			break;
		case 3:
			[playerLoop3 setDelegate:self];
			[playerLoop3 play];
			if (error) {
				NSLog(@"playLoop, loop3: %@",[error localizedDescription]);
			}
			break;
		case 4:
			[playerLoop4 setDelegate:self];
			[playerLoop4 play];
			if (error) {
				NSLog(@"playLoop, loop4: %@",[error localizedDescription]);
			}
			break;
	}
}

- (void) playSuccessTune {
	[self stopLoops];
	int randTune;
	randTune=rand() % 4 + 1;
	switch (randTune) {
		case 1:
			[playerSuccess01 setDelegate:self];
			[playerSuccess01 play];
			break;
		case 2:
			[playerSuccess02 setDelegate:self];
			[playerSuccess02 play];
			break;
		case 3:
			[playerSuccess03 setDelegate:self];
			[playerSuccess03 play];
			break;
		case 4:
			[playerSuccess04 setDelegate:self];
			[playerSuccess04 play];
			break;
		default:
			NSLog(@"Unknown success tune chosen: %d",randTune);
	}
}

-(void)stopLoops {
	if ([playerLoop1 isPlaying]) {
		[playerLoop1 stop];
	}
	if ([playerLoop2 isPlaying]) {
		[playerLoop2 stop];
	}
	if ([playerLoop3 isPlaying]) {
		[playerLoop3 stop];
	}
	if ([playerLoop4 isPlaying]) {
		[playerLoop4 stop];
	}
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
	// Audio will finish playing because: (a) two dots have been connected; (b) user has taken theire finger off the
	// screen; or (c) the success tune has finished.
	if (isComplete) {
		theBlocks=[[matchImages alloc] init:mainView imageSet:imageDetails];
		// Property currentTouch set to -1, repesenting "no current touch".
		// Property lastPoint.x set to -1, representing "no last point (because there's no current touch).
		currentTouch=-1;
		currentBlock=-1;
		lastPoint.x=-1;
		isDrawing=NO;
		isComplete=NO;
		
		[self.tempDrawImage setAlpha:1.0];
		self.tempDrawImage.image=nil;
		[self.mainImage setAlpha:1.0];
		self.mainImage.image=nil;
	} else {
		if (isDrawing==YES) {
			[self playLoop];
		}

		[self checkForEndScene];
	}
}

- (void) checkForEndScene {
	if ((![theBlocks isBlockOpen:1])&&
		(![theBlocks isBlockOpen:2])&&
		(![theBlocks isBlockOpen:3])&&
		(![theBlocks isBlockOpen:4])&&
		(![theBlocks isBlockOpen:5])&&
		(![theBlocks isBlockOpen:6])&&
		(![theBlocks isBlockOpen:7])&&
		(![theBlocks isBlockOpen:8])) {
		
		isComplete=YES;
		
		[playerFinal setDelegate:self];
		[playerFinal play];
		
		[UIView animateWithDuration:0.1
							  delay:0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^(void)
		 {
			 [self.tempDrawImage setAlpha:0.0];
			 [self.mainImage setAlpha:0.0];
		 }
						 completion:^(BOOL finished)
		 {
		 }];


		[UIView animateWithDuration:4.5
							  delay:0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^(void)
		 {
			 theBlocks.mainImage1.frame=CGRectMake(theBlocks.mainImage1.frame.origin.x, 1030, theBlocks.mainImage1.frame.size.width, theBlocks.mainImage1.frame.size.height);
			 theBlocks.mainImage1.transform=CGAffineTransformRotate (
																					   theBlocks.mainImage1.transform,
																					   (rand() % 62)/10
																					   );
			 theBlocks.mainImage2.frame=CGRectMake(theBlocks.mainImage2.frame.origin.x, 1030, theBlocks.mainImage2.frame.size.width, theBlocks.mainImage2.frame.size.height);
			 theBlocks.mainImage2.transform=CGAffineTransformRotate (
																	 theBlocks.mainImage2.transform,
																	 (rand() % 62)/10
																	 );
			 theBlocks.mainImage3.frame=CGRectMake(theBlocks.mainImage3.frame.origin.x, 1030, theBlocks.mainImage3.frame.size.width, theBlocks.mainImage3.frame.size.height);
			 theBlocks.mainImage3.transform=CGAffineTransformRotate (
																	 theBlocks.mainImage3.transform,
																	 (rand() % 62)/10
																	 );
			 theBlocks.mainImage4.frame=CGRectMake(theBlocks.mainImage4.frame.origin.x, 1030, theBlocks.mainImage4.frame.size.width, theBlocks.mainImage4.frame.size.height);
			 theBlocks.mainImage4.transform=CGAffineTransformRotate (
																	 theBlocks.mainImage4.transform,
																	 (rand() % 62)/10
																	 );
		 }
						 completion:^(BOOL finished)
		 {
			 
		 }];
		
		[UIView animateWithDuration:5.5
							  delay:0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^(void)
		 {
			 theBlocks.mainColor1.frame=CGRectMake(theBlocks.mainColor1.frame.origin.x, 1030, theBlocks.mainColor1.frame.size.width, theBlocks.mainColor1.frame.size.height);
			 theBlocks.mainColor1.transform=CGAffineTransformRotate (
																	 theBlocks.mainColor1.transform,
																	 (rand() % 62)/10
																	 );
			 theBlocks.mainColor2.frame=CGRectMake(theBlocks.mainColor2.frame.origin.x, 1030, theBlocks.mainColor2.frame.size.width, theBlocks.mainColor2.frame.size.height);
			 theBlocks.mainColor2.transform=CGAffineTransformRotate (
																	 theBlocks.mainColor2.transform,
																	 (rand() % 62)/10
																	 );

			 theBlocks.mainColor3.frame=CGRectMake(theBlocks.mainColor3.frame.origin.x, 1030, theBlocks.mainColor3.frame.size.width, theBlocks.mainColor3.frame.size.height);
			 theBlocks.mainColor3.transform=CGAffineTransformRotate (
																	 theBlocks.mainColor3.transform,
																	 (rand() % 62)/10
																	 );

			 theBlocks.mainColor4.frame=CGRectMake(theBlocks.mainColor4.frame.origin.x, 1030, theBlocks.mainColor4.frame.size.width, theBlocks.mainColor4.frame.size.height);
			 theBlocks.mainColor4.transform=CGAffineTransformRotate (
																	 theBlocks.mainColor4.transform,
																	 (rand() % 62)/10
																	 );

		 }
						 completion:^(BOOL finished)
		 {

		 }];
	}
}

@end
