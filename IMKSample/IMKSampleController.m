//
//  IMKSampleController.m
//  IMKSample
//
//  Created by palance on 17/3/22.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import "IMKSampleController.h"

@implementation IMKSampleController{
  NSMutableString* _composedString;
}

-(NSMutableString*) composedString
{
  if(_composedString == nil){
    _composedString = [[NSMutableString alloc]init];
  }
  return _composedString;
}

-(void) setComposedString:(NSString*) value
{
  [[self composedString] setString:value];
}

-(void) appendComposedString:(NSString*) string client:(id)sender
{
  [[self composedString] appendString:string];
  NSString *compString = [self composedString];
  // 向光标处插入内嵌文字
  [sender setMarkedText:compString
         selectionRange:NSMakeRange(0, [compString length])
       replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
}

-(void) commitComposedString:(id)sender
{
  // 向光标处插入上屏文字
  [sender insertText:[self composedString]
    replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
  [self setComposedString:@""];
}

- (BOOL)handleEvent:(NSEvent *)event client:(id)sender
{
  NSLog(@"%@", event);
  if([event type] == NSKeyDown){
    unichar key = [[event characters] characterAtIndex:0];
    // 如果是字符则追加到写作串
    if((key >= 'a' && key <= 'z') ||(key >= '0' && key <= '9')){
      [self appendComposedString:[event characters] client:sender];
      return YES;
    }
    // 如果是空格或回车且有写作串则上屏
    if(([event keyCode] == kVK_Space || [event keyCode] == kVK_Return)&&
      [[self composedString] length] > 0)
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

// - (BOOL)inputText:(NSString*)string
//              key:(NSInteger)keyCode
//        modifiers:(NSUInteger)flags
//           client:(id)sender
//{
//  NSLog(@"inputText:%@ key:0x%02lX modifiers:0x%04lX",
//        string, (long)keyCode, (unsigned long)flags);
//
//  unichar key = [string characterAtIndex:0];
//  if((key >= 'a' && key <= 'z') || (key >= '0' && key <= '9'))
//  { // 如果是字符则追加到写作串
//    [self appendComposedString:string client:sender];
//    return YES;
//  }
//
//  if((keyCode == kVK_Space || keyCode == kVK_Return)
//     && [[self composedString] length]>0)
//  { // 如果是空格或回车且有写作串则上屏
//    [self commitComposedString:sender];
//    return YES;
//  }
//  return NO;
//}

// 该方法接收来自客户程序的按键输入，InputMethodKit会把按键事件转换成NSString发送给本方法。
//返回YES表明输入法要处理，系统将不再把按键继续发送给应用程序；否则返回NO
-(BOOL)inputText:(NSString*)string client:(id)sender
{
  NSLog(@"inputText:%@", string);
  if([string isEqualToString:@" "]){
    if([[self composedString] length] > 0){
      [self commitComposedString:sender]; // 如果是空格且有写作串则上屏
    }else{
      return NO;
    }
  }else{                                  // 否则追加到写作串
    [self appendComposedString:string client:sender];
    NSLog(@"composed String:%@", [self composedString]);
  }
  return YES;
}

-(BOOL)didCommandBySelector:(SEL)aSelector client:(id)sender
{
  // 如果输入法要处理该事件，则返回YES，否则返回NO
  NSLog(@"didCommandBySelector:%@", NSStringFromSelector(aSelector));
  if(aSelector == @selector(insertNewline:) &&
     [[self composedString] length] > 0)
  {
    [self commitComposedString:sender]; // 如果是回车则上屏
    return YES;
  }
  return NO;
}
@end
