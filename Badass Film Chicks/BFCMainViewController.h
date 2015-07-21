//
//  BFCMainViewController.h
//  Badass Film Chicks
//
//  Created by Romy on 7/11/15.
//  Copyright © 2015 Romy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLChildViewControllerDelegate.h"
#import <MWFeedParser/MWFeedParser.h>
#import <MWFeedParser/NSString+HTML.h>

@class MWFeedParser;
@interface BFCMainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MWFeedParserDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (strong, nonatomic) MWFeedParser *feedParser;
@property (strong, nonatomic) NSMutableArray *parsedItems;
@property (strong, nonatomic) NSDateFormatter *formatter;
@property (strong, nonatomic) NSArray *articles;

@property (weak, nonatomic) id <YSLChildViewControllerDelegate> delegate;

@end
