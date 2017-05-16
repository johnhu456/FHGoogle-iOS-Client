//
//  ViewController.m
//  FHGoogleiOSClient
//
//  Created by Moxtra on 2017/5/15.
//  Copyright © 2017年 MADAO. All rights reserved.
//

#import "ViewController.h"

#import <Google/SignIn.h>

@interface ViewController ()<GIDSignInUIDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    //Config sign in button
    GIDSignInButton *signButton = [[GIDSignInButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:signButton];
    signButton.center = self.view.center;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
