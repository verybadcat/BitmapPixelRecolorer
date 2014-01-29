//
//  BPRViewController.m
//  BitmapPixelRecolorizer
//
//  Created by William Jockusch on 1/27/14.


#import "BPRViewController.h"
#import "BPRView.h"

@interface BPRViewController ()

@end

@implementation BPRViewController

-(void) loadView {
	BPRView* view = [[BPRView alloc]init];
	self.view = view;
}

@end
