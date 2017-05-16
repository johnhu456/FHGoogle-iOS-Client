//
//  FHGoogleLoginViewController.m
//  FHGoogleiOSClient
//
//  Created by Moxtra on 2017/5/16.
//  Copyright © 2017年 MADAO. All rights reserved.
//

#import "FHGoogleLoginViewController.h"
#import <Google/SignIn.h>

@interface FHGoogleLoginViewController ()<GIDSignInUIDelegate>

@end

@implementation FHGoogleLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationItem];
    [self setupUserInterface];

    
//    //Config logout button
//    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    logOutButton.frame = CGRectMake(0, 0, 100, 50);
//    logOutButton.layer.cornerRadius = 3.f;
//    logOutButton.layer.masksToBounds = YES;
//    logOutButton.center = CGPointMake(signButton.center.x, signButton.center.y + 65.f);
//    [logOutButton setBackgroundColor:[UIColor colorWithRed:1.f green:51/255.f blue:0.f alpha:1]];
//    [logOutButton setTitle:@"Log out" forState:UIControlStateNormal];
//    [logOutButton addTarget:self action:@selector(handleLogoutButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:logOutButton];
}

- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(handleCancelButtonOnClicked:)];
}

- (void)setupUserInterface {
    [GIDSignIn sharedInstance].uiDelegate = self;
    NSString *driveScope = @"https://www.googleapis.com/auth/drive.readonly";
    NSArray *currentScopes = [GIDSignIn sharedInstance].scopes;
    [GIDSignIn sharedInstance].scopes = [currentScopes arrayByAddingObject:driveScope];
    
    //Config sign in button
    GIDSignInButton *signButton = [[GIDSignInButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:signButton];
    signButton.center = self.view.center;
}

#pragma mark - WidgetsActions

- (void)handleCancelButtonOnClicked:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
