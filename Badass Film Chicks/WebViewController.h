//
//  WebViewController.h
//  Badass Film Chicks
//
//  Created by Romy on 7/11/15.
//  Copyright © 2015 Romy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFObject;
@interface WebViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) PFObject *directorObject;
@property (strong, nonatomic) NSURL *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarButtonItem;

- (IBAction)addBtnPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)closeBtnPressed:(id)sender;
@end
