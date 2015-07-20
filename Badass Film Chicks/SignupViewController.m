#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)signup:(id)sender {
    NSString *userName = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // todo check for valid email
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    if ([userName length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                       message:@"Make sure to enter a username, email address and password!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        PFUser *newUser = [PFUser user];
        newUser.username = userName;
        newUser.password = password;
        newUser.email = email;
        
        __weak typeof(self) weakSelf = self;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * __nullable error) {
            if (succeeded) {
                [weakSelf.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                UIAlertController *signupAlertController = [UIAlertController alertControllerWithTitle:@"Great!"
                                                                                               message:@"You're successfully registered!"
                                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [signupAlertController addAction:cancelAction];
                [weakSelf presentViewController:signupAlertController animated:YES completion:nil];
            } else {
                UIAlertController *signupAlertController = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                               message:[error.userInfo objectForKey:@"error"]
                                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [signupAlertController addAction:cancelAction];
                [weakSelf presentViewController:signupAlertController animated:YES completion:nil];
            }
        }];
    }
}

- (IBAction)dismiss:(id)sender {
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
