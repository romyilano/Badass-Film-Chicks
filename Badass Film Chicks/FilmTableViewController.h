//
//  FilmTableViewController.h
//  Badass Film Chicks
//
//  Created by Romy on 7/11/15.
//  Copyright © 2015 Romy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLChildViewControllerDelegate.h"

@interface FilmTableViewController : UITableViewController
@property (weak, nonatomic) id <YSLChildViewControllerDelegate> delegate;
@end
