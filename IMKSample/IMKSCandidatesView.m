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
  NSPoint pt1 = NSMakePoint(0, 0);
  NSPoint pt2 = NSMakePoint(500, 500);
  NSColor* lineColor = [NSColor colorWithCalibratedRed:255
                                                 green:255
                                                  blue:0
                                                 alpha:1.0f];
  [lineColor set];
  [NSBezierPath strokeLineFromPoint:pt1 toPoint:pt2];
}

@end
