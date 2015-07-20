//
//  LoginViewController.h
//  Ribbit
//
//  Created by Romy on 7/2/15.
//  Copyright © 2015 Treehouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

- (IBAction)login:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)forgotPwdBtnPressed:(UIButton *)sender;

@end
