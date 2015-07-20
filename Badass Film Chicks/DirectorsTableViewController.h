#import <UIKit/UIKit.h>
#import "YSLChildViewControllerDelegate.h"

@interface DirectorsTableViewController : UITableViewController
@property (weak, nonatomic) id <YSLChildViewControllerDelegate> delegate;
@end
