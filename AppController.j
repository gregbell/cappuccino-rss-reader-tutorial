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
@import "Article.j"
@import "ArticlesController.j"
@import <Foundation/CPURL.j>

@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPTableView feedsTableView;
    @outlet CPTableView articlesTableView;
    @outlet CPWebView   webView;
    FeedsController feedsController;
    ArticlesController articlesController;
}

- (void)awakeFromCib
{
  feedsController = [[FeedsController alloc] initWithTableView:feedsTableView];
  [feedsController setDelegate:self];

  articlesController = [[ArticlesController alloc] initWithTableView:articlesTableView];
  [articlesController setDelegate:self];

  [theWindow setFullBridge:YES];
}

- (void)newFeed:(id)sender
{
  var url = [[CPURL alloc] initWithString:prompt("Feed URL")];
  var feed = [[Feed alloc] initWithURL:url];
  [feedsController addFeed:feed];
}

- (void)feedSelectionDidChange:(Feed)aFeed
{
  console.log([aFeed url]);
  var request = [CPURLRequest requestWithURL:"https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=" + encodeURIComponent([aFeed url])];
  [request setValue:@"http://gregbell.ca" forHTTPHeaderField:@"Referer"];

  // see important note about CPJSONPConnection above
  [CPJSONPConnection sendRequest:request callback:"callback" delegate:self];  
}

- (void)articleSelectionDidChange:(Article)article
{
  console.log(article);
  [webView loadHTMLString:[article content]];
}

// URL Connection delegate methods

-(void)connection:(CPURLConnection)connection didFailWithError:(id)error
{
  console.log("Error: " + error);
}

-(void)connection:(CPURLConnection)connection didReceiveData:(Object)data
{
  var articles = [];
  var articlesJSON = data.responseData.feed.entries;
  for(var i = 0; i < articlesJSON.length; i++){
    var article = [[Article alloc] initWithJSON:articlesJSON[i]];
    [articles addObject:article];
  }
  console.log(articles);
  [articlesController setArticles:articles];
}


@end
