//
//  BPRAppDelegate.m
//  BitmapPixelRecolorizer
//
//  Created by William Jockusch on 1/27/14.


#import "BPRAppDelegate.h"
#import "BPRViewController.h"

@implementation BPRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow* window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	UIViewController* vc = [[BPRViewController alloc]init];
	self.window = window;
	window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
