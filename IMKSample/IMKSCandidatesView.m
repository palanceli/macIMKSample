//
//  IMKSCandidatesView.m
//  IMKSample
//
//  Created by palance on 17/3/26.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import "IMKSCandidatesView.h"

@implementation IMKSCandidatesView

- (void)drawRect:(NSRect)dirtyRect {
  [super drawRect:dirtyRect];
    
  // Drawing code here.
  NSLog(@"IMKSCandidatesView::drawRect");
  NSRect bounds = [self bounds];
  [[NSColor greenColor]set];
  [NSBezierPath fillRect:bounds];
}

@end
