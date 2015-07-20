#import <UIKit/UIKit.h>
#import "YSLContainerViewController.h"
#import "YSLChildViewControllerDelegate.h"

@interface BFCFrontViewController : UIViewController <YSLContainerViewControllerDelegate, YSLChildViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *frontBarBtn;

- (IBAction)frontBarBtnPressed:(id)sender;

@end
