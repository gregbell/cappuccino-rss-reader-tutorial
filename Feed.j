@import <Foundation/CPObject.j>

@implementation Feed : CPObject
{
  CPString    title;
  CPURL       url;
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
  URL = aURL;
  title = [URL host];
  iconPath = @"http://" + [URL host] + @"/favicon.ico";
}


@end
