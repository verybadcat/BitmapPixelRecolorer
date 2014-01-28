//
//  RGBA.h
//  BitmapPixelRecolorizer
//
//  Created by William Jockusch on 1/27/14.
//  Copyright (c) 2014 jockusch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGBA : NSObject

@property (nonatomic) unsigned char r;
@property (nonatomic) unsigned char g;
@property (nonatomic) unsigned char b;
@property (nonatomic) unsigned char a;

@property (nonatomic, readonly) UIColor* uiColor;
@property (nonatomic, readonly) CGFloat floatR, floatG, floatB, floatA;

-(RGBA*) transformedRGBAWithNeighborsLeft: (RGBA*) left right: (RGBA*) right up: (RGBA*) up down: (RGBA*) down;

-(id) initWithR: (unsigned char) r G: (unsigned char) g B: (unsigned char) b A: (unsigned char) a;
+(unsigned char*) mallocDataWithRGBAArray: (NSArray*) rgbaArray;
+(UIImage*) createImageWithData: (unsigned char*) data width: (CFIndex) width height: (CFIndex) height;

@end
