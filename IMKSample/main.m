//
//  main.m
//  IMKSample
//
//  Created by palance on 17/3/21.
//  Copyright © 2017年 palanceli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <InputMethodKit/InputMethodKit.h> // 添加包含

// 每个输入法必须有唯一连接名称，注意：不能包含点和空格
const NSString* kConnectionName = @"IMKSampleConnection";
IMKServer*      server;
IMKCandidates*  candidates = nil;

int main(int argc, const char * argv[]) {
  @autoreleasepool{
    // 获取bundle ID
    NSString* bundleID = [[NSBundle mainBundle] bundleIdentifier];
    server = [[IMKServer alloc] initWithName:(NSString*)kConnectionName
                            bundleIdentifier:bundleID];
    
    candidates = [[IMKCandidates alloc]
                  initWithServer:server
                  panelType:kIMKSingleRowSteppingCandidatePanel];
    
    //finally run everything
    [[NSApplication sharedApplication] run];
  }
  return 0;
}
