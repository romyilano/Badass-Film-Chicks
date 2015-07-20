//
//  YSLChildViewController.h
//  BACE Time
//
//  Created by Romy on 6/19/15.
//  Copyright © 2015 Romy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLChildViewControllerDelegate.h"

@interface YSLChildViewController : UIViewController

@property (nonatomic, weak) id <YSLChildViewControllerDelegate> delegate;

@end
