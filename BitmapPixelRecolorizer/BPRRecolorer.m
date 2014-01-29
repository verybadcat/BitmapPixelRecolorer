//
//  BPRRecolorer.m
//  BitmapPixelRecolorizer
//
//  Created by William Jockusch on 1/27/14.


#import "RGBA.h"

#import "BPRRecolorer.h"

@implementation BPRRecolorer

+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count
{
    NSMutableArray *r = [NSMutableArray arrayWithCapacity:count];
	
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
												 bitsPerComponent, bytesPerRow, colorSpace,
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
	
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
	
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
    for (int ii = 0 ; ii < count ; ++ii)
		{
		unsigned char red = rawData[byteIndex];
		unsigned char green = rawData[byteIndex+1];
		unsigned char blue = rawData[byteIndex+2];
		unsigned char alpha = rawData[byteIndex+3];
		byteIndex+=4;
		RGBA* rgba = [[RGBA alloc]initWithR: red G:green B:blue A:alpha];
		[r addObject: rgba];
		}
	
	free(rawData);
	
	return r;
}

+(UIImage*) roundTripOfImage: (UIImage*) image {
	CGImageRef imageCG = image.CGImage;
	int width = CGImageGetWidth(imageCG);
	int height = CGImageGetHeight(imageCG);
	int count = width*height;
	NSArray* RGBAs = [self getRGBAsFromImage:image atX:0 andY:0 count:count];
	NSMutableArray* newRGBAs = [NSMutableArray array];
	int row = 0;
	int column = 0;
	int i=0;
	for (RGBA* rgba in RGBAs) {
		RGBA* left = (column==0)?nil:RGBAs[i-1];
		RGBA* right = (column==width-1)?nil:RGBAs[i+1];
		RGBA* up = (row==0)?nil:RGBAs[i-width];
		RGBA* down = (row==height-1)?nil:RGBAs[i+width];
		RGBA* transformedRGBA = [rgba transformedRGBAWithNeighborsLeft:left right:right up:up down:down];
		[newRGBAs addObject: transformedRGBA];
		column++;
		i++;
		if (column==width) {
			column=0;
			row++;
		}
	}
	unsigned char* data = [RGBA mallocDataWithRGBAArray: newRGBAs];
	UIImage* r = [RGBA createImageWithData:data width:width height:height];
	return r;
}



@end
