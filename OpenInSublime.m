//  Created by Ray Kola
//  Based on Open in Textmate by orta therox on 06/09/2010. Copyright 2010 wgrids. All rights reserved.

#import "OpenInSublime.h"


@implementation OpenInSublime

@synthesize host;

+ (id)plugin:(id<NTPathFinderPluginHostProtocol>)pathfinder_host;
{
  OpenInSublime* result = [[self alloc] init];
  result.host = pathfinder_host;
  
  return [result autorelease];
}

- (NSMenuItem*)contextualMenuItem;
{
	return [self menuItem];
}

- (NSMenuItem*)menuItem;
{
  NSMenuItem* menuItem;

  menuItem = [[[NSMenuItem alloc] initWithTitle:@"Open in Sublime" action:@selector(pluginAction:) keyEquivalent:@""] autorelease];
  [menuItem setTarget:self];
  return menuItem;
}

- (void)pluginAction:(id)sender;
{
  [self processItems:nil parameter:nil];
}

- (BOOL)validateMenuItem:(NSMenuItem*)menuItem;
{
  return [[[self host] selection:nil browserID:nil] count] > 0;
}

- (id)processItems:(NSArray*)items parameter:(id)parameter;
{
	if (!items)
		items = [self.host  selection:nil browserID:nil];
	
    // Look for the files selected and turn it into one nice string
  NSEnumerator* enumerator = [items objectEnumerator];
  NSString *path;
  id<NTFSItem> item;
	
  while (item = [enumerator nextObject])
   {
		path = [item path];
		
		if (path)
     {
            [[NSWorkspace sharedWorkspace] openFile:path withApplication:@"Sublime Text 2"];
     }
   }
  
    //This is a round about way of doing it, and there's the limit of
    // only allowing one file to be worked on at once but it's good enough for
    // the minute, and for me.
  
    
  return nil;
}


@end
