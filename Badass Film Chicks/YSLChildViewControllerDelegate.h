//
//  YSLChildViewControllerDelegate.h
//  BACE Time
//
//  Created by Romy on 6/19/15.
//  Copyright © 2015 Romy. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@protocol YSLChildViewControllerDelegate <NSObject>

- (void)childViewController:(UIViewController *)childViewController
             didChooseValue:(NSInteger)value;

@end
