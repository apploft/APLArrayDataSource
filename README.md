APLArrayDataSource
=========

UITableViewDataSource for NSArray. A UITableViewDataSource for data represented as NSArray being displayed in a UITableView.
                   
Concept and code is from this great [objc.io article](http://www.objc.io/issue-1/lighter-view-controllers.html).
                   
Additionally supports:

* multiple cell identifiers
* cell editing (deletion only)
* sections, with nested NSArrays as data source (use subclass APLArrayWithSectionsDataSource)

## Installation
Install via cocoapods by adding this to your Podfile:

	pod "APLArrayDataSource"

## Usage

Import header file:

	#import "ALArrayDataSource.h"
	
Declare a dataSource property:

	@property (nonatomic, strong) ALArrayDataSource* dataSource;
	
Init dataSource with your data array (empty here), cell identifier, a block for configuring the tableView cells and set the tableView dataSource:
	
	self.dataSource = [[ALArrayDataSource alloc] initWithItems:@[] cellIdentifier:@"CellIdentifier" configureCellBlock:[self configureCell]];
    self.tableView.dataSource = self.dataSource;
    
Declare a method returning a block for configuring the tableView cell:

	- (TableViewCellConfigureBlock)configureCell {
    	return ^(UITableViewCell* cell, id yourModel) {
        	cell.textLabel.text = yourModel.name;
        	cell.imageView.image = yourModel.image;
    	};
	}

When you retrieve new data, update your dataSource and tableView like this:

    self.dataSource.items = modelArray;
    [self.tableView reloadData];