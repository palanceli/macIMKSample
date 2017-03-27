//
//  IMKSampleController.m
//  IMKSample
//
//  Created by palance on 17/3/22.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import "IMKSampleController.h"
#import "SGDXIMEngine.h"
#import "IMKSCandidatesWindow.h"

@implementation IMKSampleController
{
  IMKSCandidatesWindow* _candidatesWindow;
}
-(IMKSCandidatesWindow*) candidatesWindow
{
  if(_candidatesWindow == nil){
    _candidatesWindow = [[IMKSCandidatesWindow alloc]
               initWithContentRect:NSZeroRect
               styleMask:NSBorderlessWindowMask
               backing:NSBackingStoreBuffered
               defer:YES];
  }
  return _candidatesWindow;
}

-(void) appendComposedString:(NSString*) string client:(id)sender
{
  SGDXIMEngine* imEngine = [SGDXIMEngine sharedObject];
  NSString *compString = [imEngine appendComposeString:string];
  // 向光标处插入内嵌文字
  [sender setMarkedText:compString
         selectionRange:NSMakeRange(0, [compString length])
       replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
  [[self candidatesWindow]update:[self client]]; // 更新候选窗
}

-(void) commitComposedString:(id)sender
{
  SGDXIMEngine* imEngine = [SGDXIMEngine sharedObject];
  // 向光标处插入上屏文字
  [sender insertText:[[SGDXIMEngine sharedObject] composeString] 
    replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
  [imEngine cleanComposeString];
  [[self candidatesWindow]update:[self client]];  // 更新候选窗
}

- (BOOL)handleEvent:(NSEvent *)event client:(id)sender
{
//  NSLog(@"%@", event);
  if([event type] == NSKeyDown){
    unichar key = [[event characters] characterAtIndex:0];
    // 如果是字符则追加到写作串，并更新候选窗
    if((key >= 'a' && key <= 'z') ||(key >= '0' && key <= '9')){
      [self appendComposedString:[event characters] client:sender];
      return YES;
    }
    // 如果是空格或回车且有写作串则上屏，并更新候选窗
    if(([event keyCode] == kVK_Space || [event keyCode] == kVK_Return)&&
      [[[SGDXIMEngine sharedObject] composeString] length] > 0)
    {
      [self commitComposedString:sender];
      return YES;
    }
  }
  return NO;
}

- (NSUInteger)recognizedEvents:(id)sender {
  return NSEventMaskFlagsChanged | NSEventMaskKeyDown | NSEventMaskKeyUp;
}

@end
