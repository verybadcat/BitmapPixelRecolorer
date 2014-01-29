//
//  BPRView.m
//  BitmapPixelRecolorizer
//
//  Created by William Jockusch on 1/27/14.


#import "BPRView.h"
#import "BPRRecolorer.h"

@implementation BPRView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor whiteColor];
		NSBundle* bundle = [NSBundle mainBundle];
        UIImage* image = [UIImage imageNamed:@"ConverterButtonM"];
		UIImageView* imageView = [[UIImageView alloc]initWithImage:image];
		imageView.center = CGPointMake(80, 100);
		[self addSubview: imageView];
		UIImage* outputImage = [BPRRecolorer roundTripOfImage: image];
		UIImageView* outputImageView = [[UIImageView alloc]initWithImage:outputImage];
		[self addSubview:outputImageView];
		outputImageView.center = CGPointMake(240, 100);
		NSString* outputPath = @"users/william/desktop/ConverterButtonM.png";
		[UIImagePNGRepresentation(outputImage) writeToFile:outputPath atomically:YES];
    }
    return self;
}

@end
