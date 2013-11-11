
#import <Foundation/Foundation.h>


typedef void (^TableViewCellConfigureBlock)(id cell, id item);


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

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray*)itemsForSection:(NSInteger)section;
- (void)setItems:(NSArray*)items forSection:(NSInteger)section;

@end
