//
//  RGBA.m
//  BitmapPixelRecolorizer
//
//  Created by William Jockusch on 1/27/14.
//  Copyright (c) 2014 jockusch. All rights reserved.
//

#import "RGBA.h"

#define kColorChannels 4
#define kBitsPerChannel 8
#define kBitsPerPixel (kColorChannels*kBitsPerChannel)
#define kBitsPerByte 8
#define kBytesPerPixel (kBitsPerPixel/kBitsPerByte)




@implementation RGBA

-(id) initWithR: (unsigned char) r G: (unsigned char) g B: (unsigned char) b A: (unsigned char) a {
	if ((self = [super init])) {
		self.r = r;
		self.g = g;
		self.b = b;
		self.a = a;
	}
	return self;
}

-(CGFloat) floatR {
	return self.r/(CGFloat)255;
}

-(CGFloat) floatG {
	return self.g/(CGFloat)255;
}

-(CGFloat) floatB {
	return self.b/(CGFloat)255;
}

-(CGFloat) floatA {
	return self.a/(CGFloat)255;
}

-(UIColor*) uiColor {
	return [UIColor colorWithRed:self.floatR green:self.floatG blue:self.floatB alpha:self.floatA];
}


-(CGContextRef) WJCGBitmapContextCreateWithWidth: (CFIndex) width height: (CFIndex) height {
	CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    CGContextRef c = CGBitmapContextCreate(NULL, width, height, kBitsPerChannel, width*kBytesPerPixel, cs, (CGBitmapInfo) kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(cs);
	return c;
}

+(CGContextRef) createContextWithData: (unsigned char*) data width: (CFIndex) width height: (CFIndex) height {
	CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    CGContextRef c = CGBitmapContextCreate(data, width, height, kBitsPerChannel, width*kBytesPerPixel, cs, (CGBitmapInfo) kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(cs);
	return c;
}

+(UIImage*) createImageWithData: (unsigned char*) data width: (CFIndex) width height: (CFIndex) height {
	CGContextRef c = [RGBA createContextWithData: data width: width height: height];
	CGImageRef img = CGBitmapContextCreateImage(c);
	UIImage* uiImage = [UIImage imageWithCGImage: img];
	return uiImage;
}

+(unsigned char*) mallocDataWithRGBAArray: (NSArray*) rgbaArray {
	unsigned char* r = calloc(rgbaArray.count, kBytesPerPixel);
	int i=0;
	for (RGBA* rgba in rgbaArray) {
		unsigned char red = rgba.r;
		unsigned char g = rgba.g;
		unsigned char b = rgba.b;
		unsigned char a = rgba.a;
		r[i]=red;
		i++;
		r[i]=g;
		i++;
		r[i]=b;
		i++;
		r[i]=a;
		i++;
	}
	return r;
}

-(RGBA*) transformedRGBAWithNeighborsLeft: (RGBA*) left right: (RGBA*) right up: (RGBA*) up down: (RGBA*) down {
	// entire purpose of this app is to get the color components of each pixel and its neighbors into this method.  You can change the components however you want, and the output image will reflect that.  For example, if you set red=255, your output image will have a maximum red component everywhere.
	unsigned char red = self.r;
	unsigned char green = self.g;
	unsigned char blue = self.b;
	unsigned char a = self.a;
	if (red < 45) {
		red = red>32?red:red<26?MIN(red, 5):32-4*(32-red);
		green = green<32?6:green>55?65:2*(green-29)+(green-29)/2-green/10;
		blue = blue<250-22?blue+17+MIN(3,(blue>50?(blue-50/10):0)):255;
	}
	RGBA* r = [[RGBA alloc]initWithR: red G: green B: blue A: a];
	return r;
}

@end
