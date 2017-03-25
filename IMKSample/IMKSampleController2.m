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

- (BOOL)inputText:(NSString*)string
              key:(NSInteger)keyCode
        modifiers:(NSUInteger)flags
           client:(id)sender
{
  NSLog(@"inputText:%@ key:0x%2lX modifiers:0x%4lX",
        string, (long)keyCode, (unsigned long)flags);
  if(flags & NSShiftKeyMask){
    NSLog(@"shift key is pressed.");
  }else if(flags & NSControlKeyMask){
    NSLog(@"ctrl key is pressed.");
  }
  return NO;
}

// 该方法接收来自客户程序的按键输入，InputMethodKit会把按键事件转换成NSString发送给本方法。
//返回YES表明输入法要处理，系统将不再把按键继续发送给应用程序；否则返回NO
-(BOOL)inputText:(NSString*)string client:(id)sender
{
  NSLog(@"inputText:%@", string);
  if([string isEqualToString:@" "]){  // 如果是空格则上屏
    [self commitComposedString:sender];
  }else{                              // 否则追加到写作串
    [self appendComposedString:string client:sender];
    NSLog(@"composed String:%@", [self composedString]);
  }
  return YES;
}

-(BOOL)didCommandBySelector:(SEL)aSelector client:(id)sender
{
  // 如果输入法要处理该事件，则返回YES，否则返回NO
  NSLog(@"didCommandBySelector:%@", NSStringFromSelector(aSelector));
  if(aSelector == @selector(insertNewline:)){ // 如果是回车则上屏
    [self commitComposedString:sender];
    return YES;
  }
  return NO;
}

-(void)setValue:(id)value forTag:(long)tag client:(id)sender
{
  NSLog(@"value:%@ forTag:%ld", value, tag);
}
@end
