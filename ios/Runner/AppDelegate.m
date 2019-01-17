#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      [GMSServices provideAPIKey:@"AIzaSyDi4-kG2_8AjKXtLqNHuYo0MA--OnQSI1o"];
      [GeneratedPluginRegistrant registerWithRegistry:self];
      // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
