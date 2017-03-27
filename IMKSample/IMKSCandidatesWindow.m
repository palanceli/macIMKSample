//
//  IMKSCandidatesWindow.m
//  IMKSample
//
//  Created by palance on 17/3/25.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import "IMKSCandidatesWindow.h"
#import "SGDXIMEngine.h"
#import "IMKSCandidatesView.h"

@implementation IMKSCandidatesWindow
{
  IMKSCandidatesView* _view;
}

-(id)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style
                 backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
  self = [super initWithContentRect:contentRect
                          styleMask:NSBorderlessWindowMask
                            backing:bufferingType defer:flag];
  if(self){
    [self setOpaque:NO];
    [self setLevel:NSFloatingWindowLevel];
    [self setBackgroundColor:[NSColor clearColor]];
    _view = [[IMKSCandidatesView alloc]initWithFrame:self.frame];
    [self setContentView:_view];
    [self orderFront:nil];
  }
  return self;
}

// 计算光标位置
-(NSPoint) getCaretPosition:(id<IMKTextInput, NSObject>)sender
{
  NSPoint ps;
  NSRect lineHeightRect;
  [sender attributesForCharacterIndex:0 lineHeightRectangle:&lineHeightRect];
  ps = NSMakePoint(lineHeightRect.origin.x, lineHeightRect.origin.y);
  return ps;
}

-(void)update:(id<IMKTextInput, NSObject>)sender
{
  NSPoint caretPosition = [self getCaretPosition:sender];
  SGDXIMEngine *imEngine = [SGDXIMEngine sharedObject];
  
  NSMutableAttributedString* compString =
  [[NSMutableAttributedString alloc]initWithString:[imEngine composeString]];
  [compString addAttribute:NSFontAttributeName
                     value:[NSFont userFontOfSize:16]
                     range:NSMakeRange(0, [[imEngine composeString]length])];
  
  NSRect rect = NSZeroRect;   // 写作串为空则不显示
  
  // 计算窗口区域
  if([[[SGDXIMEngine sharedObject]composeString] length] > 0){
    rect = NSMakeRect(caretPosition.x,
                      caretPosition.y - [compString size].height,
                      [compString size].width ,
                      [compString size].height);
  }
  
  NSLog(@"IMKSCandidatesWindow::update rect:(%.0f, %.0f, %.0f, %.0f)",
        rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
  [self setFrame:rect display:YES];
  // 计算视图区域
  [_view setFrame:NSMakeRect(0, 0, rect.size.width, rect.size.height)];
  [_view setNeedsDisplay:YES];
}
@end
