//
//  ViewController.m
//  FHGoogleiOSClient
//
//  Created by Moxtra on 2017/5/15.
//  Copyright © 2017年 MADAO. All rights reserved.
//

#import "ViewController.h"
#import "FHGoogleLoginViewController.h"

#import <Google/SignIn.h>

@interface ViewController ()<GIDSignInUIDelegate>

@property (nonatomic, strong) UINavigationController *loginVCNavi;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self checkGoogleLoginState];
}

- (void)checkGoogleLoginState {
    if ([GIDSignIn sharedInstance].currentUser) {
        [self displayAccountVC];
    }
    else if ([GIDSignIn sharedInstance].hasAuthInKeychain) {
        [[GIDSignIn sharedInstance] signInSilently];
    }
    else {
        //
        [self configLoginVC];
    }
}

#pragma mark - UserInterface

- (void)displayAccountVC {
    NSLog(@"===========================");
    if (self.presentedViewController == self.loginVCNavi) {
        [self.loginVCNavi dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)configLoginVC {
    FHGoogleLoginViewController *googleLoginVC = [[FHGoogleLoginViewController alloc] init];
    self.loginVCNavi = [[UINavigationController alloc] initWithRootViewController:googleLoginVC];
    [self presentViewController:self.loginVCNavi animated:YES completion:nil];
}


- (void)handleLogoutButtonClicked:(UIButton *)sender {
    [[GIDSignIn sharedInstance] signOut];
    [[GIDSignIn sharedInstance] disconnect];
}

@end
