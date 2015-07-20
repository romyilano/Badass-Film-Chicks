//
//  FilmTableViewController.m
//  Badass Film Chicks
//
//  Created by Romy on 7/11/15.
//  Copyright © 2015 Romy. All rights reserved.
//

#import "FilmTableViewController.h"
#import "BFCController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "WebViewController.h"
#import "NibTableViewCell.h"

static NSString *CellIdentifier = @"Cell";

@interface FilmTableViewController ()
@property (strong, nonatomic) NSMutableArray *filmArray;
@end

@implementation FilmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    UIImageView *tableBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kateBush"]];
    tableBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.backgroundView = tableBackgroundImageView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NibTableViewCell" bundle:nil]
         forCellReuseIdentifier:CellIdentifier];
    
    [self refreshFilmList];
}

- (void)refreshFilmList {
    __weak typeof(self) weakSelf = self;
    [[BFCController shared] loadFilmsInBackgroundFromParseiOSAPI:^(NSArray *filmArray, NSError *error) {
        if (!error) {
            weakSelf.filmArray = [NSMutableArray arrayWithArray:filmArray];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filmArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NibTableViewCell *cell = (NibTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *filmObj = self.filmArray[indexPath.row];
    cell.nibLabel.text = [NSString stringWithFormat:@"%@", [filmObj objectForKey:@"film"]];
    
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [NibTableViewCell nibCellHeight];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
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
