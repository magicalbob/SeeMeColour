//
//  ViewController.h
//  SeeMeColour
//
//  Created by Ian on 28/02/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "matchImages.h"
#import "imageColourPair.h"

@interface ViewController : UIViewController <AVAudioPlayerDelegate> {
	BOOL isDrawing;
	NSInteger currentTouch;
	NSInteger currentBlock;
	NSInteger currentLoop;
	CGPoint lastPoint;
	matchImages *theBlocks;
	NSMutableArray *imageDetails;
	BOOL isComplete;
}
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;

@end
