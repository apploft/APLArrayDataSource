
#import "APLArrayDataSource.h"


@interface APLArrayDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end


@implementation APLArrayDataSource

- (id)init {
    return nil;
}

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [self itemsForSection:indexPath.section];
    NSUInteger row = indexPath.row;
    return (items && (row < [items count])) ? items[row] : 0;
}

- (NSArray*)itemsForSection:(NSInteger)section {
    return self.items;
}

- (void)setItems:(NSArray*)items forSection:(NSInteger)section {
    self.items = items;
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self itemsForSection:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    id<ALEditableModel> item = [self itemAtIndexPath:indexPath];
    return [item conformsToProtocol:@protocol(ALEditableModel)] ? [item isEditable] : NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        id<ALEditableModel> item = [self itemAtIndexPath:indexPath];
        if ([item conformsToProtocol:@protocol(ALEditableModel)]) {
            [item deleteObject];
        };
        
        NSMutableArray* mutableItems = [[self itemsForSection:indexPath.section] mutableCopy];
        [mutableItems removeObject:item];
        [self setItems:mutableItems forSection:indexPath.section];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
