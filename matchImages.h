//
//  matchImages.h
//  See Me Colour
//
//  Created by Ian on 28/02/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageColourPair.h"

@interface matchImages : UIView {
	CGRect imageRect1;
	CGRect imageRect2;
	CGRect imageRect3;
	CGRect imageRect4;
	CGRect colorRect1;
	CGRect colorRect2;
	CGRect colorRect3;
	CGRect colorRect4;
	NSInteger colorNum1;
	NSInteger colorNum2;
	NSInteger colorNum3;
	NSInteger colorNum4;
	NSInteger colorNum5;
	NSInteger colorNum6;
	NSInteger colorNum7;
	NSInteger colorNum8;
	BOOL blockOpen1;
	BOOL blockOpen2;
	BOOL blockOpen3;
	BOOL blockOpen4;
	BOOL blockOpen5;
	BOOL blockOpen6;
	BOOL blockOpen7;
	BOOL blockOpen8;
	UIImageView *mainImage1;
	UIImageView *mainImage2;
	UIImageView *mainImage3;
	UIImageView *mainImage4;
	UIImageView *mainColor1;
	UIImageView *mainColor2;
	UIImageView *mainColor3;
	UIImageView *mainColor4;
}
- (id)init:(UIView *)containerView imageSet:(NSMutableArray *)imageSet;
- (CGPoint) latchPoint:(NSInteger)blockNo;
- (BOOL) matchedBlocks:(NSInteger)block1 block2:(NSInteger)block2;
- (BOOL) isBlockOpen:(NSInteger)blockNum;
- (void) setBlockClosed:(NSInteger)blockNum;
- (UIColor *) whichColorToUse:(NSInteger)colNum;
-(NSInteger)inBlockN:(CGPoint)whereTouch ;
@property CGRect imageRect1;
@property CGRect imageRect2;
@property CGRect imageRect3;
@property CGRect imageRect4;
@property CGRect colorRect1;
@property CGRect colorRect2;
@property CGRect colorRect3;
@property CGRect colorRect4;
@property NSInteger colorNum1;
@property NSInteger colorNum2;
@property NSInteger colorNum3;
@property NSInteger colorNum4;
@property NSInteger colorNum5;
@property NSInteger colorNum6;
@property NSInteger colorNum7;
@property NSInteger colorNum8;
@property UIImageView *mainImage1;
@property UIImageView *mainImage2;
@property UIImageView *mainImage3;
@property UIImageView *mainImage4;
@property UIImageView *mainColor1;
@property UIImageView *mainColor2;
@property UIImageView *mainColor3;
@property UIImageView *mainColor4;
@end
