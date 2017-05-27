//
//  AppDelegate.m
//  FHGoogleiOSClient
//
//  Created by Moxtra on 2017/5/15.
//  Copyright © 2017年 MADAO. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <Google/SignIn.h>

@interface AppDelegate ()<GIDSignInDelegate>

@property (nonatomic, strong) ViewController *checkLoginVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    [GIDSignIn sharedInstance].delegate = self;
    
    self.checkLoginVC = [[ViewController alloc] init];
    UINavigationController *googleClientNavi = [[UINavigationController alloc] initWithRootViewController:self.checkLoginVC];
    self.window =  [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = googleClientNavi;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}

#pragma mark - GIDSignDelegate

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
//    NSString *userId = user.userID;                  // For client-side use only!
//    NSString *idToken = user.authentication.idToken; // Safe to send to the server
//    NSString *fullName = user.profile.name;
//    NSString *givenName = user.profile.givenName;
//    NSString *familyName = user.profile.familyName;
//    NSString *email = user.profile.email;
    if (self.checkLoginVC)
    {
        [self.checkLoginVC checkGoogleLoginState];
    }
    // ...
}

- (void)signIn:(GIDSignIn *)signIn
        didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    NSLog(@"logged out");
}

@end
