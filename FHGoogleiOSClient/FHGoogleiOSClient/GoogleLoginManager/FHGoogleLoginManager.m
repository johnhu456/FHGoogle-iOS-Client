//
//  FHGoogleLoginManager.m
//  FHGoogleiOSClient
//
//  Created by Moxtra on 2017/5/27.
//  Copyright © 2017年 MADAO. All rights reserved.
//

#import "FHGoogleLoginManager.h"

@interface FHGoogleLoginManager()<GIDSignInDelegate>

@property (nonatomic, assign) BOOL loginFromKeyChain;

@property (nonatomic, copy) void(^authHandler)(GIDGoogleUser *user,NSError *error);

@property (nonatomic, copy) void(^autoAuthHandler)(GIDGoogleUser *user,NSError *error);

@end

@implementation FHGoogleLoginManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static FHGoogleLoginManager *_manager;
    dispatch_once(&onceToken, ^{
        _manager = [[FHGoogleLoginManager alloc] init];
    });
    return _manager;
}

- (instancetype)init {
    if (self = [super init])
    {
        [GIDSignIn sharedInstance].delegate = self;
        [self config];
    }
    return self;
}

- (void)config
{
    NSString *driveScope = @"https://www.googleapis.com/auth/drive.readonly";
    NSArray *currentScopes = [GIDSignIn sharedInstance].scopes;
    [GIDSignIn sharedInstance].scopes = [currentScopes arrayByAddingObject:driveScope];
}

#pragma mark - Public method

- (GIDGoogleUser *)currentUser {
    return [GIDSignIn sharedInstance].currentUser;
}

- (void)checkGoogleAccountStateWithCompletion:(void (^)(FHGoogleAccountState))handler
{
    if ([self currentUser]) {
        if (handler)
        {
            handler(FHGoogleAccountStateOnline);
        }
    }
    else if ([GIDSignIn sharedInstance].hasAuthInKeychain)
    {
        handler(FHGoogleAccountStateHasKeyChain);
    }
    else
    {
        handler(FHGoogleAccountStateOffline);
    }
}

- (void)autoLoginWithCompletion:(void (^)(GIDGoogleUser *, NSError *))handler {
    _autoAuthHandler = handler;
    self.loginFromKeyChain = YES;
    [[GIDSignIn sharedInstance] signInSilently];
}

- (void)startGoogleLoginWithCompletion:(void (^)(GIDGoogleUser *, NSError *))handler {
    _authHandler = handler;
    self.loginFromKeyChain = NO;
    [[GIDSignIn sharedInstance] signIn];
}

#pragma mark - GIDSignInDelegate

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (self.loginFromKeyChain) {
        if (_autoAuthHandler) {
            _autoAuthHandler(user,error);
        }
    }
    else {
        if (_authHandler) {
            _authHandler(user,error);
        }
    }
}
@end
