//
//  LoginViewController.m
//  Ribbit
//
//  Created by Romy on 7/2/15.
//  Copyright © 2015 Treehouse. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (strong, nonatomic) UIImageView *loginBackgroundImageView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)login:(id)sender {
    
    NSString *userName = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    if ([userName length] == 0 || [password length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                       message:@"Make sure to enter a username and password"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        
        __weak typeof(self) weakSelf = self;
        
        [PFUser logInWithUsernameInBackground:userName
                                     password:password block:^(PFUser * __nullable user, NSError * __nullable error) {
                                         if (error) {
                                             UIAlertController *loginErrorAlert = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                                                      message:[error.userInfo objectForKey:@"error"]
                                                                                                               preferredStyle:UIAlertControllerStyleAlert];
                                             
                                             [loginErrorAlert addAction:cancelAction];
                                             [weakSelf presentViewController:loginErrorAlert animated:YES completion:nil];
                                         } else {
                                             [self dismissViewControllerAnimated:YES completion:nil];
                                         }
                                     }];
    }
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)forgotPwdBtnPressed:(UIButton *)sender {
    // todo solution for user to enter email
}

@end
