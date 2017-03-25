//
//  IMKSCandidatesWindowMgr.m
//  IMKSample
//
//  Created by palance on 17/3/25.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import "IMKSCandidatesWindowMgr.h"
#import "IMKSCandidatesWindow.h"

@implementation IMKSCandidatesWindowMgr
{
  IMKSCandidatesWindow* _window;
}

-(id)init
{
  self = [super init];
  if(self){
    _window = [[IMKSCandidatesWindow alloc]
               initWithContentRect:NSZeroRect
               styleMask:NSBorderlessWindowMask
               backing:NSBackingStoreBuffered
               defer:YES];
  }
  return self;
}

-(void)updateCandidateWindow:(id<IMKTextInput, NSObject>) sender
{
  [_window update:sender];
}

+(IMKSCandidatesWindowMgr*)sharedObject
{
  static IMKSCandidatesWindowMgr* sObj = nil;
  @synchronized (self) {
    if(sObj == nil){
      sObj = [[self alloc] init];
    }
  }
  return sObj;
}
@end
