//
//  WebViewController.m
//  Badass Film Chicks
//
//  Created by Romy on 7/11/15.
//  Copyright © 2015 Romy. All rights reserved.
//

#import "WebViewController.h"
#import "DZNWebViewController.h"
#import "BFCController.h"
#import <Parse/Parse.h>
#import "Constants.h"

@interface WebViewController ()
@property (strong, nonatomic) PFRelation *directorRelation;
@property (strong, nonatomic) NSArray *favoriteDirectors;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    
    [self refreshFavoriteDirectors];
}

- (void)refreshFavoriteDirectors {
    // check if the director is already a favorite
    self.directorRelation = [[PFUser currentUser] relationForKey:kParseUserClassDirectorRelationKey];
    PFQuery *relationQuery = [self.directorRelation query];
    [relationQuery orderByAscending:@"lastName"];
    __weak typeof(self) weakSelf = self;
    [relationQuery findObjectsInBackgroundWithBlock:^(NSArray * __nullable objects, NSError * __nullable error) {
        if (!error && objects.count > 0) {
            weakSelf.favoriteDirectors = objects;
            // make the add button not visible
            [weakSelf refreshBarButtonItem];
        }
    }];
}

- (void)refreshBarButtonItem {
    if ([self isFavoriteDirector:[PFUser currentUser]]) {
        self.addBarButtonItem.title = @"-";
    } else {
        self.addBarButtonItem.title = @"+";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

- (BOOL)isFavoriteDirector:(PFUser *)user {
    if (self.favoriteDirectors.count == 0) {
        return NO;
    } else {
        for (PFObject *directorObj in self.favoriteDirectors) {
            if ([self.directorObject.objectId isEqualToString:directorObj.objectId]) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - Action Methods

- (IBAction)addBtnPressed:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    if ([PFUser currentUser]) {
        if ([self isFavoriteDirector:[PFUser currentUser]]) {
            // remove it
            [self.directorRelation removeObject:self.directorObject];
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * __nullable error) {
                if (!error && succeeded) {
                    NSLog(@"director : %@ deleted successfully for user: %@", weakSelf.directorObject, [[PFUser currentUser] valueForKey:@"username"]);
                    [weakSelf refreshFavoriteDirectors];
                }
            }];
        } else {
            // add it
            [self.directorRelation addObject:self.directorObject];
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * __nullable error) {
                if (!error) {
                    NSLog(@"director : %@ saved successfully for user: %@", weakSelf.directorObject, [[PFUser currentUser] valueForKey:@"username"]);
                    [weakSelf refreshFavoriteDirectors];
                }
            }];
        }

        }
        
}

- (IBAction)backBtnPressed:(id)sender {
    [self.webView goBack];
}

- (IBAction)closeBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
