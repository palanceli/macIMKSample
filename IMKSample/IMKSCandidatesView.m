//
//  IMKSCandidatesView.m
//  IMKSample
//
//  Created by palance on 17/3/26.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import "IMKSCandidatesView.h"
#import "SGDXIMEngine.h"

@implementation IMKSCandidatesView

- (void)drawRect:(NSRect)dirtyRect
{
  [super drawRect:dirtyRect];
    
  // Drawing code here.
  NSLog(@"IMKSCandidatesView::drawRect");
  // 绘制灰色背景
  NSRect bounds = [self bounds];
  [[NSColor lightGrayColor]set];
  [NSBezierPath fillRect:bounds];

  SGDXIMEngine *imEngine = [SGDXIMEngine sharedObject];
  // 绘制写作串
  NSMutableAttributedString* compString =
  [[NSMutableAttributedString alloc]initWithString:[imEngine composeString]];
  [compString addAttribute:NSFontAttributeName
                     value:[NSFont userFontOfSize:16]
                     range:NSMakeRange(0, [[imEngine composeString]length])];
  
  [compString drawInRect:[self bounds]];
}

@end
