/*
 * AppController.j
 * RSSReader
 *
 * Created by You on December 20, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "FeedsController.j"
@import "Feed.j"
@import <Foundation/CPURL.j>

@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPTableView feedsTableView;
    FeedsController feedsController;
}

- (void)awakeFromCib
{
  feedsController = [[FeedsController alloc] initWithTableView:feedsTableView];

  var feed1 = [[Feed alloc] initWithURL:[[CPURL alloc] initWithString:@"http://cappuccino.org/discuss/feed"]];
  var feed2 = [[Feed alloc] initWithURL:[[CPURL alloc] initWithString:@"http://cappuccino.org/discuss/feed"]];

  [feedsController addFeed:feed1];
  [feedsController addFeed:feed2];

  [theWindow setFullBridge:YES];
}

- (void)newFeed:(id)sender
{
  var url = [[CPURL alloc] initWithString:prompt("Feed URL")];
  var feed = [[Feed alloc] initWithURL:url];
  [feedsController addFeed:feed];
}

@end
