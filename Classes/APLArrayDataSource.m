
#import "APLArrayDataSource.h"


@interface APLArrayDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CellIdentifierForIndexPathItemBlock cellIdentifierBlock;
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

- (id)initWithItems:(NSArray *)anItems
cellIdentifierBlock:(CellIdentifierForIndexPathItemBlock)aCellIdentifierBlock
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifierBlock = aCellIdentifierBlock;
        self.configureCellBlock = aConfigureCellBlock;
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

- (NSString*)cellIdentifierForIndexPath:(NSIndexPath*)indexPath {
    if (self.cellIdentifierBlock) {
        id item = [self itemAtIndexPath:indexPath];
        return self.cellIdentifierBlock(indexPath,item);
    }
    return self.cellIdentifier;
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self itemsForSection:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [self cellIdentifierForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    id<ALEditableModel> item = [self itemAtIndexPath:indexPath];
    return [item respondsToSelector:@selector(isEditable)] ? [item isEditable] : NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        id<ALEditableModel> item = [self itemAtIndexPath:indexPath];
        __weak APLArrayDataSource* weakSelf = self;
        
        TableViewCommitEditingBlock completion = ^(BOOL success) {
            if (success) {
                if ([item respondsToSelector:@selector(deleteObject)]) {
                    [item deleteObject];
                };
                
                NSMutableArray* mutableItems = [[weakSelf itemsForSection:indexPath.section] mutableCopy];
                [mutableItems removeObject:item];
                [weakSelf setItems:mutableItems forSection:indexPath.section];
                
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        };
        
        if (self.shouldCommitEditingBlock == nil) {
            completion(YES);
        } else {
            self.shouldCommitEditingBlock(item, editingStyle, completion);
        }
    }
}

@end
