//
//  FHGoogleAccountViewController.m
//  FHGoogleiOSClient
//
//  Created by Moxtra on 2017/5/16.
//  Copyright © 2017年 MADAO. All rights reserved.
//

#import "FHGoogleAccountViewController.h"
#import "FHGoogleDriveViewController.h"

#import <Google/SignIn.h>

@interface FHGoogleAccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *const kNormalCellReuseIdentifier = @"kNormalCellReuseIdentifier";

@implementation FHGoogleAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationItem];
    [self setupTableView];
}

- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStyleDone target:self action:@selector(handleLogoutButtonOnClicked:)];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kNormalCellReuseIdentifier];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:kNormalCellReuseIdentifier];
    tableViewCell.textLabel.text = @"Drive";
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FHGoogleDriveViewController *googleDriveViewController = [[FHGoogleDriveViewController alloc] init];
    [self.navigationController pushViewController:googleDriveViewController animated:YES];
}

#pragma mark - WidgetsActions

- (void)handleLogoutButtonOnClicked:(UIBarButtonItem *)sender {
    [[GIDSignIn sharedInstance] signOut];
    [[GIDSignIn sharedInstance] disconnect];
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
