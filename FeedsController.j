@import <Foundation/CPObject.j>
@import "Feed.j"

@implementation FeedsController : CPObject
{
  CPArray     feeds;
  CPTableView tableView;
  CPObject    delegate @accessors;
}

- (id)initWithTableView:(CPTableView)aTableView
{
  self = [super init];
  if(self) {
    tableView = aTableView;
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    feeds = [];
  }
  return self;
}

- (void)addFeed:(Feed)aFeed
{
  [feeds addObject:aFeed];
  [tableView reloadData];
}

- (int)numberOfRowsInTableView:(CPTableView)aTableView
{
  console.log([feeds count]);
  return [feeds count];
}

- (id)tableView:(CPTableView)theTableView 
        objectValueForTableColumn:(CPTableColumn)column 
        row:(int)index
{
  return [[feeds objectAtIndex:index] title];
}

@end

@implementation FeedsController (CPTableViewDelegateMethods)

- (void)tableViewSelectionDidChange:(CPNotification)aNotification
{
  var feed = [feeds objectAtIndex:[tableView selectedRow]];
  CPLog(@"%@", feed);
  [delegate feedSelectionDidChange:feed];
}

@end
