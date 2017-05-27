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
#import "FHGoogleDriveFileCell.h"

static NSString *const kFileCellReuseIdentifier = @"kFileCellReuseIdentifier";

@interface FHGoogleDriveViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GTLRDriveService *service;
@property (nonatomic, strong) NSArray<GTLRDrive_File *> *fileList;
@end

@implementation FHGoogleDriveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Files";
    
    [self setupTableView];
    [self fetchDriveFiles];
}

- (void)fetchDriveFiles {
    self.service = [[GTLRDriveService alloc] init];
    self.service.authorizer = [[[[FHGoogleLoginManager sharedInstance] currentUser] authentication] fetcherAuthorizer];
    GTLRDriveQuery_FilesList *query = [GTLRDriveQuery_FilesList query];
    
    query.fields = @"kind,nextPageToken,files(mimeType,id,kind,name,webViewLink,thumbnailLink,trashed,modifiedTime,size,originalFilename)";
    [self.service executeQuery:query
             completionHandler:^(GTLRServiceTicket *callbackTicket,
                                 GTLRDrive_FileList *fileList,
                                 NSError *callbackError) {
                 if (callbackError == nil)
                 {
                     self.fileList = fileList.files;
                     [self.tableView reloadData];
                 }
                 else
                 {
                    //Handle error
                 }
             }];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"FHGoogleDriveFileCell" bundle:nil] forCellReuseIdentifier:kFileCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fileList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FHGoogleDriveFileCell *fileCell = [tableView dequeueReusableCellWithIdentifier:kFileCellReuseIdentifier];
    GTLRDrive_File *file = self.fileList[indexPath.row];
    fileCell.textLabel.text = file.name;
    fileCell.detailTextLabel.text = file.iconLink;
    return fileCell;
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
