#import <UIKit/UIKit.h>
#import "TableViewController.h"

@interface SelectionTableViewController : UITableViewController {
    @private
    NSArray *arrayTopic;
    NSArray *arrayDescription;
}

#pragma mark -
- (IBAction)buttonAddNewRssChanel:(id)sender;
- (NSArray *)arrayGetRssChanel;

@end
