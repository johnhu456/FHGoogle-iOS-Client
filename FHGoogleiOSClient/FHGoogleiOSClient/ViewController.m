//
//  ViewController.m
//  FHGoogleiOSClient
//
//  Created by Moxtra on 2017/5/15.
//  Copyright © 2017年 MADAO. All rights reserved.
//

#import "ViewController.h"

#import "FHGoogleLoginManager.h"

#import "FHGoogleLoginViewController.h"
#import "FHGoogleAccountViewController.h"

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
    [self checkGoogleLoginState];
}

- (void)checkGoogleLoginState {
    self.activityIndicator.hidden = NO;
    __weak typeof(self) weakSelf = self;
    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    [[FHGoogleLoginManager sharedInstance] checkGoogleAccountStateWithCompletion:^(FHGoogleAccountState state) {
        switch (state) {
            case FHGoogleAccountStateOnline:
                [self displayAccountVC];
                break;
            case FHGoogleAccountStateHasKeyChain:
                {
                    [[FHGoogleLoginManager sharedInstance] autoLoginWithCompletion:^(GIDGoogleUser *user, NSError *error) {
                        [weakSelf displayAccountVC];
                    }];
                }
                break;
            case FHGoogleAccountStateOffline:
                [self displayLoginVC];
                break;
            default:
                break;
        }
    }];
}

#pragma mark - UserInterface

- (void)displayAccountVC {
    self.activityIndicator.hidden = YES;
    if (self.presentedViewController == self.loginVCNavi) {
        [self.loginVCNavi dismissViewControllerAnimated:YES completion:nil];
    }
    FHGoogleAccountViewController *googleAccountVC = [[FHGoogleAccountViewController alloc] init];
    googleAccountVC.rootViewController = self;
    self.accountVCNavi = [[UINavigationController alloc] initWithRootViewController:googleAccountVC];
    [self presentViewController:self.accountVCNavi animated:YES completion:nil];
}

- (void)displayLoginVC {
    self.activityIndicator.hidden = YES;
    FHGoogleLoginViewController *googleLoginVC = [[FHGoogleLoginViewController alloc] init];
    googleLoginVC.rootViewController = self;
    self.loginVCNavi = [[UINavigationController alloc] initWithRootViewController:googleLoginVC];
    [self presentViewController:self.loginVCNavi animated:YES completion:nil];
}

@end
