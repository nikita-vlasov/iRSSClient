#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "AddNewRssViewController.h"

@interface SelectionTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSDictionary *dictionaryItems;
    NSInteger valueKey;
}

#pragma mark - Action
- (IBAction)buttonAddNewRssChanel:(id)sender;

#pragma mark -
- (NSArray *)arrayGetRssChanel;

@end
