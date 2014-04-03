#import "DataModel.h"

@interface DataModel () {
    @private
    NSManagedObjectContext *managedObjectContext;
}

@end


@implementation DataModel

+ (DataModel *)sharedModel {
    static DataModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[DataModel alloc] init];
    });

    return model;
}

- (NSArray *)entityDataSetEnturyName:(NSString *)entityName {
    managedObjectContext = [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    [fetchRequest setIncludesPropertyValues:NO];

    NSError *error = nil;
    NSArray *arrayFetchObject = [managedObjectContext executeFetchRequest:fetchRequest error:&error];

    return arrayFetchObject;
}

@end
