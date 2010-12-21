@import <Foundation/CPObject.j>

@implementation Feed : CPObject
{
  CPString    title;
  CPURL       url @accessors;
}

- (id)initWithURL:(CPURL)aURL
{
  [self init];
  [self setURL: aURL];
  return self;
}

- (CPString)title
{
  return title;
}

- (void)setURL:(CPURL)aURL
{
  url = aURL;
  title = [url host];
  iconPath = @"http://" + [url host] + @"/favicon.ico";
}


@end
