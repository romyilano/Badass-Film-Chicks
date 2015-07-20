//
//  BFCMainViewController.m
//  Badass Film Chicks
//
//  Created by Romy on 7/11/15.
//  Copyright © 2015 Romy. All rights reserved.
//

#import "BFCMainViewController.h"
#import "NibTableViewCell.h"

static NSString *CellIdentifier = @"Cell";
@interface BFCMainViewController ()

@end

@implementation BFCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"NibTableViewCell" bundle:nil]
         forCellReuseIdentifier:CellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.backgroundImageView.image = [UIImage imageNamed:@"suprabha"];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.backgroundImageView.image = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NibTableViewCell *cell = (NibTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    cell.nibLabel.text = [NSString stringWithFormat:@"Section: %ld, row %ld", indexPath.section, (long)(long)indexPath.row];
    
    return cell;
}

/*
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // remember this causes a crash because it causes an infinite cycle
    // NibTableViewCell *cell = (NibTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    //return 100.0;return [NibTableViewCell nibCellHeight];//
}
 */

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

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
