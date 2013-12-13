#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "AddNewRssViewController.h"
#include "ResetSettingToDefault.h"

@interface SelectionTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    UIBarButtonItem *barButtonTrashAllChanel;
    UIBarButtonItem *barButtonAddChanel;
    
    NSDictionary *dictionaryRssChanel;
}

#pragma mark - Action
- (IBAction)buttonAddNewRssChanel:(id)sender;
- (IBAction)buttonBarTrashAllChanel:(id)sender;

#pragma mark -
- (NSArray *)arrayGetRssChanel;

@end
