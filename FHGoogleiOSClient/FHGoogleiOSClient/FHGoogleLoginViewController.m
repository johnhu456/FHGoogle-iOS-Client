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
}

- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(handleCancelButtonOnClicked:)];
}

- (void)setupUserInterface {
    [GIDSignIn sharedInstance].uiDelegate = self;
    //Config sign in button
    UIButton *signButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [signButton setTitle:@"Sign" forState:UIControlStateNormal];
    [signButton setBackgroundColor:[UIColor colorWithRed:1.f green:51/255.f blue:0.f alpha:1]];
    [self.view addSubview:signButton];
    signButton.center = self.view.center;
    [signButton addTarget:self action:@selector(handleSignButtonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - WidgetsActions

- (void)handleSignButtonOnClicked:(UIButton *)sender {
    if ([[GIDSignIn sharedInstance] hasAuthInKeychain]) {
        
    }
    else {
        [[GIDSignIn sharedInstance] signIn];
    }

}

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
