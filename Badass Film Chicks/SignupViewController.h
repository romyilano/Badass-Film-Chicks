//
//  SignupViewController.h
//  Ribbit
//
//  Created by Romy on 7/2/15.
//  Copyright © 2015 Treehouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) UIImageView *imageBackgroundView;

- (IBAction)signup:(id)sender;

@end
