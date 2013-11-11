
#import "APLArrayWithSectionsDataSource.h"


@interface APLArrayWithSectionsDataSource ()

@end


@implementation APLArrayWithSectionsDataSource

- (NSArray*)itemsForSection:(NSInteger)section {
    return (section < [self.items count]) ? self.items[(NSUInteger)section] : nil;
}

- (void)setItems:(NSArray*)items forSection:(NSInteger)section {
    NSMutableArray* mutableItems = [self.items mutableCopy];
    [mutableItems replaceObjectAtIndex:(NSUInteger)section withObject:items];
    self.items = mutableItems;
}


#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return (section < [self.sectionHeaderTitles count]) ? self.sectionHeaderTitles[section] : nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.items count];
}

@end
