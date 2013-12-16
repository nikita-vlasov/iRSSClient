#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "EditChannelTableViewController.h"
#include "ResetSettingToDefault.h"

@interface SelectionTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    UIBarButtonItem *barButtonTrashAllChanel;
    UIBarButtonItem *barButtonAddChanel;
    
    NSDictionary *dictionaryRssChanel;
}

#pragma mark -
- (NSArray *)arrayGetRssChanel;

@end
