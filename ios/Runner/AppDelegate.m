#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	FlutterViewController *controller = (FlutterViewController *)self.window.rootViewController;
	FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"com.Story5.todo.channel" binaryMessenger:controller.binaryMessenger];
    [channel setMethodCallHandler:^(FlutterMethodCall *call,FlutterResult result){
        if([call.method isEqualToString:@"getCurrentLocation"]){
            result(@{
            @"latitude":@"39.92",
            @"longitude":@"116.46",
            @"description":@"北京",
            });
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
	[GeneratedPluginRegistrant registerWithRegistry:self];
	// 可以在这里添加更多代码,定制应用启动后的行为
	// Override point for customization after application launch.
	return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
