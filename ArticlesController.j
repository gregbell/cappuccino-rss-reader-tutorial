@import <Foundation/CPObject.j>

@implementation ArticlesController : CPObject
{
  CPTableView   tableView;
  CPArray       articles;
  CPObject      delegate @accessors;
}

- (id)initWithTableView:(CPTableView)aTableView
{
  self = [self init];
  if(self) {
    articles = [];
    tableView = aTableView;
    [tableView setDataSource:self];
    [tableView setDelegate:self];
  }
  return self;
}

-(void)setArticles:(CPArray)newArticles
{
  articles = newArticles;
  [tableView reloadData];
}

- (int)numberOfRowsInTableView:(CPTableView)aTableView
{
  return [articles count];
}

- (id)tableView:(CPTableView)theTableView 
        objectValueForTableColumn:(CPTableColumn)column 
        row:(int)index
{
  if([column identifier] === @"title") {
    return [[articles objectAtIndex:index] title];
  }
}

- (void)tableViewSelectionDidChange:(CPNotification)aNotification
{
  var article = [articles objectAtIndex:[tableView selectedRow]];
  [delegate articleSelectionDidChange:article];
}
@end
