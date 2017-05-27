//
//  FHGoogleDriveViewController.m
//  FHGoogleiOSClient
//
//  Created by Moxtra on 2017/5/16.
//  Copyright © 2017年 MADAO. All rights reserved.
//

#import "FHGoogleDriveViewController.h"
#import <GTLRService.h>
#import <GTLRDrive.h>

#import "FHGoogleLoginManager.h"

@interface FHGoogleDriveViewController ()

@property (nonatomic, strong) GTLRDriveService *service;
@end

@implementation FHGoogleDriveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.service = [[GTLRDriveService alloc] init];
    self.service.authorizer = [[[[FHGoogleLoginManager sharedInstance] currentUser] authentication] fetcherAuthorizer];
    GTLRDriveQuery_FilesList *query = [GTLRDriveQuery_FilesList query];
    
    query.fields = @"kind,nextPageToken,files(mimeType,id,kind,name,webViewLink,thumbnailLink,trashed,modifiedTime,size,originalFilename)";
    [self.service executeQuery:query
             completionHandler:^(GTLRServiceTicket *callbackTicket,
                                 GTLRDrive_FileList *fileList,
                                 NSError *callbackError) {
                 if (callbackError)
                 {
//                     callback(nil,callbackError);
                 }
                 else
                 {
//                     callback(fileList.files,callbackError);
                 }
             }];
    
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
