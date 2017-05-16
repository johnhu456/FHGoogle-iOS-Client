//
//  ViewController.m
//  FHGoogleiOSClient
//
//  Created by Moxtra on 2017/5/15.
//  Copyright © 2017年 MADAO. All rights reserved.
//

#import "ViewController.h"
#import "FHGoogleLoginViewController.h"
#import "FHGoogleAccountViewController.h"

#import <Google/SignIn.h>

@interface ViewController ()<GIDSignInUIDelegate>

@property (nonatomic, strong) UINavigationController *loginVCNavi;

@property (nonatomic, strong) UINavigationController *accountVCNavi;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (UIActivityIndicatorView *)activityIndicator {
    if (_activityIndicator == nil)
    {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.center = self.view.center;
        _activityIndicator.hidden = YES;
        [_activityIndicator startAnimating];
        [self.view addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [GIDSignIn sharedInstance].uiDelegate = self;
    NSString *driveScope = @"https://www.googleapis.com/auth/drive.readonly";
    NSArray *currentScopes = [GIDSignIn sharedInstance].scopes;
    [GIDSignIn sharedInstance].scopes = [currentScopes arrayByAddingObject:driveScope];
    
    [self checkGoogleLoginState];
}

- (void)checkGoogleLoginState {
    self.activityIndicator.hidden = NO;
    if ([GIDSignIn sharedInstance].currentUser) {
        [self displayAccountVC];
    }
    else if ([[GIDSignIn sharedInstance] hasAuthInKeychain]) {
        [[GIDSignIn sharedInstance] signInSilently];
    }
    else {
        //
        [self configLoginVC];
    }
}

#pragma mark - UserInterface

- (void)displayAccountVC {
    self.activityIndicator.hidden = YES;
    if (self.presentedViewController == self.loginVCNavi) {
        [self.loginVCNavi dismissViewControllerAnimated:YES completion:nil];
    }
    FHGoogleAccountViewController *googleAccountVC = [[FHGoogleAccountViewController alloc] init];
    self.accountVCNavi = [[UINavigationController alloc] initWithRootViewController:googleAccountVC];
    [self presentViewController:self.accountVCNavi animated:YES completion:nil];
}

- (void)configLoginVC {
    self.activityIndicator.hidden = YES;
    FHGoogleLoginViewController *googleLoginVC = [[FHGoogleLoginViewController alloc] init];
    self.loginVCNavi = [[UINavigationController alloc] initWithRootViewController:googleLoginVC];
    [self presentViewController:self.loginVCNavi animated:YES completion:nil];
}


- (void)handleLogoutButtonClicked:(UIButton *)sender {
    [[GIDSignIn sharedInstance] signOut];
    [[GIDSignIn sharedInstance] disconnect];
}

@end
