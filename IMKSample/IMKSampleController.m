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
  [sender setMarkedText:compString
         selectionRange:NSMakeRange(0, [compString length])
       replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
}

-(void) commitComposedString:(id)sender
{
  
}

// 该方法接收来自客户程序的按键输入，InputMethodKit会把按键事件转换成NSString发送给本方法。
//返回YES表明输入法要处理，系统将不再把按键继续发送给应用程序；否则返回NO
-(BOOL)inputText:(NSString*)string client:(id)sender
{
  NSLog(@"inputText:%@", string);
  if([string isEqualToString:@" "]){
    [sender insertText:[self composedString]
      replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    [self setComposedString:@""];
  }else{
    [[self composedString] appendString:string];
    NSLog(@"composed String:%@", [self composedString]);
  }
  return YES;
}


-(BOOL)didCommandBySelector:(SEL)aSelector client:(id)sender
{
  // 如果输入法要处理该事件，则返回YES，否则返回NO
  NSLog(@"didCommandBySelector:%@", NSStringFromSelector(aSelector));
  if(aSelector == @selector(insertNewline:)){
    [sender insertText:[self composedString]
      replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    [self setComposedString:@""];
    return YES;
  }
  return NO;
}
@end
