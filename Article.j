@import <Foundation/CPObject.j>

@implementation Article : CPObject
{
  CPString title @accessors;
  CPString content @accessors;
}

- (id)initWithJSON:(Object)json
{
  self = [self init];
  if(self) {
    title = json.title;
    content = json.content;
  }
  return self;
}

@end
