
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^TableViewCellConfigureBlock)(id cell, id item);
typedef void (^TableViewCommitEditingBlock)(BOOL success);
typedef void (^TableViewShouldCommitEditingBlock)(id item, UITableViewCellEditingStyle editingStyle, TableViewCommitEditingBlock completion);


@protocol ALEditableModel <NSObject>

@required
- (BOOL)isEditable;

@optional
- (void)deleteObject;

@end


@interface APLArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) TableViewShouldCommitEditingBlock shouldCommitEditingBlock;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray*)itemsForSection:(NSInteger)section;
- (void)setItems:(NSArray*)items forSection:(NSInteger)section;

@end
