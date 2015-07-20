#import <Parse/Parse.h>
#import "BFCFrontViewController.h"
#import "Constants.h"
#import "BFCUtility.h"
#import "BFCMainViewController.h"
#import "YSLSettingsViewController.h"
#import "DirectorsTableViewController.h"
#import "FilmTableViewController.h"
#import "LoginViewController.h"

@interface BFCFrontViewController ()

@property (strong, nonatomic) YSLContainerViewController *yslContainerVC;

@end

@implementation BFCFrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Navigation bar - thank you!
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.font = [BFCUtility bfcCellFont];
    titleView.textColor = [UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0];;
    titleView.text = @"Menu";
    [titleView sizeToFit];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    [self setUpYSLControllers];
}

- (void)setUpYSLControllers {
    BFCMainViewController *bfcMainVC = [[BFCMainViewController alloc] initWithNibName:@"BFCMainViewController" bundle:nil];
    bfcMainVC.title = @"Main";
    
    DirectorsTableViewController *directorsTVC = [[DirectorsTableViewController alloc] init];
    directorsTVC.title = @"Directors";
    
    FilmTableViewController *filmTVC = [[FilmTableViewController alloc] init];
    filmTVC.title = @"Films";
    
    YSLSettingsViewController *settingsVC = [[YSLSettingsViewController alloc] init];
    settingsVC.title = @"Settings";
    
    //container view
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationheight = self.navigationController.navigationBar.frame.size.height;
    
    self.yslContainerVC = [[YSLContainerViewController alloc] initWithControllers:@[bfcMainVC, directorsTVC, filmTVC, settingsVC]
                                                                     topBarHeight:statusHeight + navigationheight
                                                             parentViewController:self];
    self.yslContainerVC.delegate = self;
    self.yslContainerVC.menuItemFont = [BFCUtility secondaryCellFont];
    
    // set delegates for the child view controllers so they can talk to the ysl container
    bfcMainVC.delegate = self;
    directorsTVC.delegate = self;
    filmTVC.delegate = self;
  
    [self.view addSubview:self.yslContainerVC.view];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Badass Chicks";
    
    if ([PFUser currentUser]) {
        self.frontBarBtn.title = @"Profile";
    } else {
        self.frontBarBtn.title = @"Login";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YSLContainerViewControllerDelegate

- (void)containerViewItemIndex:(NSInteger)index
             currentController:(UIViewController *)controller {
   // NSLog(@"current Index : %ld",(long)index);
   // NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}

#pragma mark - YSLChildViewControllerDelegate

- (void)childViewController:(UIViewController *)childViewController didChooseValue:(NSInteger)value {
    // tood - 
}

#pragma mark - Storyboard Navigation

- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    if ([segue.identifier isEqualToString:kSegueLoginKey]) {
        self.title = @"";
    }
}
#pragma mark - Action Items

- (IBAction)frontBarBtnPressed:(id)sender {
    if (![PFUser currentUser]) {
        UIStoryboard *currentStoryboard = [UIStoryboard storyboardWithName:@"DesignStoryboard" bundle:nil];
        LoginViewController *loginVC = [currentStoryboard instantiateViewControllerWithIdentifier:kLoneWolfSTIDLoginNavKey];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    } else {
        [self performSegueWithIdentifier:@"ProfileSegue" sender:self];
    }
}

@end
