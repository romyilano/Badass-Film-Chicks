#import "DirectorsTableViewController.h"
#import "BFCController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "WebViewController.h"
#import "NibTableViewCell.h"

static NSString *CellIdentifier = @"Cell";

@interface DirectorsTableViewController ()

@property (strong, nonatomic) NSMutableArray *directorArray;
@property (strong, nonatomic) NSArray *favoriteDirectors;

@end

@implementation DirectorsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    UIImageView *tableBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bigelow"]];
    tableBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.backgroundView = tableBackgroundImageView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NibTableViewCell" bundle:nil]
         forCellReuseIdentifier:CellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshDirectors];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

- (void)refreshDirectors {
    __weak typeof(self) weakSelf = self;
    [[BFCController shared] loadDirectorsInBackgroundFromParseiOSAPI:^(NSArray *directorArray, NSError *error) {
        if (!error) {
            weakSelf.directorArray = [NSMutableArray arrayWithArray:directorArray];
            [[BFCController shared] getCurrentUserFreshListUsersFavoriteDirectors:^(NSArray *directors, NSError *error) {
                if (!error) {
                    weakSelf.favoriteDirectors = directors;
                    [weakSelf.tableView reloadData];
                }
            }];
        }
    }];
}

- (void)refreshDirectorListFavorites {
    __weak typeof(self) weakSelf = self;
    [[BFCController shared] getCurrentUserFreshListUsersFavoriteDirectors:^(NSArray *directors, NSError *error) {
        if (!error) {
            NSLog(@"current thread: %@", [NSThread currentThread]);
            weakSelf.favoriteDirectors = self.favoriteDirectors;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)refreshDirectorList {
    __weak typeof(self) weakSelf = self;
    [[BFCController shared] loadDirectorsInBackgroundFromParseiOSAPI:^(NSArray *directorArray, NSError *error) {
        if (!error) {
            weakSelf.directorArray = [NSMutableArray arrayWithArray:directorArray];
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSString *)tableView:(nonnull UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"Favorite Directors";
            break;
        case 1:
            title = @"Directors";
            break;
        default:
            title = @"";
            break;
    }
    return title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger finalNumber = 0;
    switch (section) {
        case 0:
            finalNumber = [self.favoriteDirectors count];
            break;
        case 1:
            finalNumber = [self.directorArray count];
            break;
        default:
            finalNumber = 1;
            break;
    }
    return finalNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NibTableViewCell *cell = (NibTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    PFObject *directorObj = nil;
    
    if (indexPath.section == 0) {
        directorObj = self.favoriteDirectors[indexPath.row];
        
    } else if (indexPath.section == 1) {
        directorObj = self.directorArray[indexPath.row];
       
    }
    cell.nibLabel.text = [NSString stringWithFormat:@"%@ %@",
                          [directorObj objectForKey:kParseDirectorFirstNameClassKey],
                            [directorObj objectForKey:kParseDirectorLastNameClassKey]];
   
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [NibTableViewCell nibCellHeight];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *directorObj = self.directorArray[indexPath.row];
    NSString *wikiURLString = [directorObj objectForKey:@"director_wiki"];
    NSURL *wikURL = [NSURL URLWithString:wikiURLString];
    WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webVC.url = wikURL;
    webVC.directorObject = directorObj;
    [self presentViewController:webVC animated:YES completion:nil];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
