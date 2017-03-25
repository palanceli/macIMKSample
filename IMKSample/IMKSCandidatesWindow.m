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
    [self setAcceptsMouseMovedEvents:YES];
    [self setBackgroundColor:[NSColor whiteColor]];
    _view = [[IMKSCandidatesView alloc]initWithFrame:self.frame];
    [self setContentView:_view];
  }
  return self;
}

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
  Boolean display = YES;
  NSPoint caretPosition = [self getCaretPosition:sender];
  NSRect rect = NSMakeRect(caretPosition.x, caretPosition.y, 500, 500);
  if([[SGDXIMEngine sharedObject]candidates] == nil){
    display = NO;
  }
  
  NSLog(@"IMKSCandidatesWindow::update display:%hhu", display);
  [self setFrame:rect display:display];
}
@end
