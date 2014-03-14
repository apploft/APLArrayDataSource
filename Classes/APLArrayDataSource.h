
#import <Foundation/Foundation.h>


typedef void (^TableViewCellConfigureBlock)(id cell, id item);
typedef NSString* (^CellIdentifierForIndexPathItemBlock)(NSIndexPath *indexPath, id item);

@protocol ALEditableModel <NSObject>

@required
- (BOOL)isEditable;
- (void)deleteObject;

@end


@interface APLArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)initWithItems:(NSArray *)anItems
cellIdentifierBlock:(CellIdentifierForIndexPathItemBlock)aCellIdentifierBlock
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (NSString*)cellIdentifierForIndexPath:(NSIndexPath*)indexPath;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray*)itemsForSection:(NSInteger)section;
- (void)setItems:(NSArray*)items forSection:(NSInteger)section;

@end
